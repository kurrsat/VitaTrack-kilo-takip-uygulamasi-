import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/constants/app_constants.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/weight/weight_providers.dart';

class WeeklyReport {
  const WeeklyReport({
    required this.startDate,
    required this.endDate,
    required this.weightChange,
    required this.trendSpeed,
    required this.weightSeries,
    required this.trendSeries,
    required this.waterSeries,
    required this.days,
    required this.waterGoalDays,
    required this.fastingSessions,
  });

  final DateTime startDate;
  final DateTime endDate;
  final double weightChange;
  final double trendSpeed;
  final List<double> weightSeries;
  final List<double> trendSeries;
  final List<int> waterSeries;
  final List<DateTime> days;
  final int waterGoalDays;
  final int fastingSessions;

  bool get hasWeightData => weightSeries.isNotEmpty;
}

final weeklyReportProvider = FutureProvider<WeeklyReport?>((ref) async {
  final uid = ref.read(currentUserIdProvider);
  if (uid == null) {
    return null;
  }
  final now = DateTime.now().toUtc();
  final endDay = DateTime.utc(now.year, now.month, now.day);
  final startDay = endDay.subtract(const Duration(days: 6));
  final days = List.generate(7, (index) => startDay.add(Duration(days: index)));

  final weights = await ref.read(weightRepositoryProvider).watchEntries(uid).first;
  final weekWeights = weights
      .where(
        (entry) =>
            !entry.dateTime.isBefore(startDay) &&
            entry.dateTime.isBefore(endDay.add(const Duration(days: 1))),
      )
      .toList()
    ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

  final settings = ref.read(trendSettingsProvider);
  final trendService = ref.read(trendServiceProvider);
  final trend = weekWeights.isEmpty
      ? <double>[]
      : trendService.calculateTrend(
          weekWeights,
          method: settings.method,
          alpha: settings.alpha,
          beta: settings.beta,
        );
  final weightSeries = weekWeights.map((e) => e.weightKg).toList();
  final weightChange = weekWeights.length > 1
      ? weekWeights.last.weightKg - weekWeights.first.weightKg
      : 0.0;
  final trendSpeed = trend.length > 1 ? trend.last - trend.first : 0.0;

  final waters = await ref.read(waterRepositoryProvider).watchAll(uid).first;
  final waterTotals = _buildWeekTotals(waters, startDay, endDay);
  final waterSeries = days.map((day) => waterTotals[day] ?? 0).toList();
  final waterGoalDays =
      waterSeries.where((total) => total >= AppConstants.defaultWaterGoalMl).length;

  final fastings = await ref.read(fastingRepositoryProvider).watchAll(uid).first;
  final fastingSessions = fastings.where(
    (session) {
      if (!session.completed) return false;
      return !session.start.isBefore(startDay) &&
          session.start.isBefore(endDay.add(const Duration(days: 1)));
    },
  ).length;

  return WeeklyReport(
    startDate: startDay,
    endDate: endDay,
    weightChange: weightChange,
    trendSpeed: trendSpeed,
    weightSeries: weightSeries,
    trendSeries: trend,
    waterSeries: waterSeries,
    days: days,
    waterGoalDays: waterGoalDays,
    fastingSessions: fastingSessions,
  );
});

Map<DateTime, int> _buildWeekTotals(
  List<WaterEntry> entries,
  DateTime startDay,
  DateTime endDay,
) {
  final totals = <DateTime, int>{};
  for (final entry in entries) {
    final day = DateTime.utc(entry.date.year, entry.date.month, entry.date.day);
    if (day.isBefore(startDay) || day.isAfter(endDay)) {
      continue;
    }
    totals[day] = (totals[day] ?? 0) + entry.ml;
  }
  return totals;
}
