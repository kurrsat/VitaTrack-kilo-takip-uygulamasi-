import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_reminder/features/hydration/domain/intake_log.dart';
import 'package:water_reminder/features/hydration/presentation/hydration_providers.dart';
import 'package:water_reminder/features/onboarding/presentation/onboarding_providers.dart';
import 'package:water_reminder/features/stats/domain/stats_models.dart';
import 'package:water_reminder/features/stats/domain/stats_use_cases.dart';

/// Provider for calculate day stats use case
final calculateDayStatsProvider = Provider((ref) => CalculateDayStatsUseCase());

/// Provider for calculate streak use case
final calculateStreakProvider = Provider((ref) => CalculateStreakUseCase());

/// Provider for calculate week stats use case
final calculateWeekStatsProvider = Provider((ref) {
  return CalculateWeekStatsUseCase(
    calculateDayStats: ref.watch(calculateDayStatsProvider),
    calculateStreak: ref.watch(calculateStreakProvider),
  );
});

/// Provider for check achievements use case
final checkAchievementsProvider = Provider((ref) => CheckAchievementsUseCase());

/// Provider for update daily challenge use case
final updateDailyChallengeProvider =
    Provider((ref) => UpdateDailyChallengeUseCase());

/// Provider for today's stats
final todayStatsProvider = Provider<DayStats>((ref) {
  final logsAsync = ref.watch(allLogsProvider);
  final goalHistoryAsync = ref.watch(dailyGoalHistoryProvider);
  final profile = ref.watch(userProfileProvider).value;

  final logs = logsAsync.value ?? <IntakeLog>[];
  final goalHistory = goalHistoryAsync.value ?? const <String, int>{};
  final fallbackGoal = profile?.effectiveDailyGoal ?? 2000;
  final goalMl = resolveDailyGoal(goalHistory, DateTime.now(), fallbackGoal);

  return ref.watch(calculateDayStatsProvider)(
    date: DateTime.now(),
    logs: logs,
    goalMl: goalMl,
  );
});

/// Provider for week stats
final weekStatsProvider = Provider<WeekStats>((ref) {
  final logsAsync = ref.watch(allLogsProvider);
  final goalHistoryAsync = ref.watch(dailyGoalHistoryProvider);
  final profile = ref.watch(userProfileProvider).value;
  final fallbackGoal = profile?.effectiveDailyGoal ?? 2000;
  final logs = logsAsync.value ?? <IntakeLog>[];
  final goalHistory = goalHistoryAsync.value ?? const <String, int>{};

  return ref.watch(calculateWeekStatsProvider)(
    allLogs: logs,
    goalMl: fallbackGoal,
    goalForDate: (date) => resolveDailyGoal(goalHistory, date, fallbackGoal),
  );
});

/// Provider for daily challenge
final dailyChallengeProvider = Provider<DailyChallenge>((ref) {
  final logsAsync = ref.watch(allLogsProvider);
  final logs = logsAsync.value ?? <IntakeLog>[];

  return ref.watch(updateDailyChallengeProvider)(
    date: DateTime.now(),
    logs: logs,
  );
});

/// Provider for achievements
final achievementsProvider = StateProvider<List<Achievement>>((ref) {
  // TODO: Load from Hive
  return [];
});
