import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_reminder/app/providers.dart';
import 'package:water_reminder/features/hydration/data/intake_log_repository.dart';
import 'package:water_reminder/features/hydration/domain/beverage_type.dart';
import 'package:water_reminder/features/hydration/domain/intake_log.dart';
import 'package:water_reminder/features/hydration/domain/quick_add_defaults.dart';
import 'package:water_reminder/features/onboarding/presentation/onboarding_providers.dart';

const _dailyGoalBoxName = 'daily_goal_history';

String _dailyGoalKey(DateTime date) {
  final normalized = DateTime(date.year, date.month, date.day);
  final year = normalized.year.toString().padLeft(4, '0');
  final month = normalized.month.toString().padLeft(2, '0');
  final day = normalized.day.toString().padLeft(2, '0');
  return '$year-$month-$day';
}

int resolveDailyGoal(
  Map<String, int> history,
  DateTime date,
  int fallbackGoal,
) {
  return history[_dailyGoalKey(date)] ?? fallbackGoal;
}

/// Repository provider
final intakeLogRepositoryProvider = Provider<IntakeLogRepository>((ref) {
  final timeService = ref.watch(timeServiceProvider);
  return IntakeLogRepository(timeService);
});

/// All logs (for stats/history)
final allLogsProvider = FutureProvider<List<IntakeLog>>((ref) async {
  final repository = ref.watch(intakeLogRepositoryProvider);
  return repository.getAllLogs();
});

/// Stream of today's logs (auto-refreshes when logs change)
final todayLogsProvider = StreamProvider<List<IntakeLog>>((ref) async* {
  final repository = ref.watch(intakeLogRepositoryProvider);
  
  // Initial load
  yield await repository.getTodayLogs();
  
  // Refresh every 30 seconds to catch new day transitions
  await for (final _ in Stream.periodic(const Duration(seconds: 30))) {
    yield await repository.getTodayLogs();
  }
});

/// Today's total EFFECTIVE ml (considering beverage types)
final todayTotalProvider = FutureProvider<int>((ref) async {
  // Watch today's logs to auto-refresh when they change
  final logsAsync = ref.watch(todayLogsProvider);
  
  return logsAsync.when(
    data: (logs) => logs.fold<int>(0, (sum, log) => sum + log.effectiveHydrationMl),
    loading: () => 0,
    error: (_, __) => 0,
  );
});

/// Goal progress percentage (0.0 to 1.0)
final goalProgressProvider = FutureProvider<double>((ref) async {
  final totalAsync = ref.watch(todayTotalProvider);
  final profileAsync = ref.watch(userProfileProvider);
  
  final total = totalAsync.value ?? 0;
  final goal = profileAsync.value?.effectiveDailyGoal ?? 2000;
  
  if (goal == 0) return 0.0;
  return (total / goal).clamp(0.0, 1.0);
});

/// Remaining ml to reach goal
final remainingMlProvider = FutureProvider<int>((ref) async {
  final totalAsync = ref.watch(todayTotalProvider);
  final profileAsync = ref.watch(userProfileProvider);
  
  final total = totalAsync.value ?? 0;
  final goal = profileAsync.value?.effectiveDailyGoal ?? 2000;
  
  return (goal - total).clamp(0, goal);
});

/// Last used amount (for quick re-add)
final lastUsedAmountProvider = FutureProvider<int?>((ref) async {
  final repository = ref.watch(intakeLogRepositoryProvider);
  final lastLog = await repository.getLastLog();
  return lastLog?.amountMl;
});

/// Quick add defaults for water, tea, coffee
final quickAddDefaultsProvider = FutureProvider<QuickAddDefaults>((ref) async {
  final box = await Hive.openBox('quick_add_settings');
  final data = box.get('defaults');
  if (data is Map) {
    return QuickAddDefaults.fromJson(Map<String, dynamic>.from(data));
  }
  return QuickAddDefaults.standard;
});

Future<void> saveQuickAddDefaults(
  WidgetRef ref,
  QuickAddDefaults defaults,
) async {
  final box = await Hive.openBox('quick_add_settings');
  await box.put('defaults', defaults.toJson());
  ref.invalidate(quickAddDefaultsProvider);
}

/// Daily goal history for past days (keyed by yyyy-MM-dd)
final dailyGoalHistoryProvider = FutureProvider<Map<String, int>>((ref) async {
  final box = await Hive.openBox(_dailyGoalBoxName);
  final history = <String, int>{};

  for (final entry in box.toMap().entries) {
    final key = entry.key.toString();
    final value = entry.value;
    if (value is int) {
      history[key] = value;
    } else if (value is num) {
      history[key] = value.round();
    }
  }

  return history;
});

Future<void> storeDailyGoalSnapshot(
  WidgetRef ref,
  DateTime date,
  int goalMl,
) async {
  final box = await Hive.openBox(_dailyGoalBoxName);
  final key = _dailyGoalKey(date);
  if (!box.containsKey(key)) {
    await box.put(key, goalMl);
    ref.invalidate(dailyGoalHistoryProvider);
  }
}

/// Undo stack for deleted logs (for 5-second undo)
final undoStackProvider = StateProvider<IntakeLog?>((ref) => null);

/// Helper to add water and refresh providers
Future<IntakeLog> addWater(
  WidgetRef ref,
  int amountMl, {
  BeverageType beverageType = BeverageType.water,
}) async {
  final repository = ref.read(intakeLogRepositoryProvider);
  final profile = ref.read(userProfileProvider).value;
  final goalMl = profile?.effectiveDailyGoal ?? 2000;
  final log = IntakeLog(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    amountMl: amountMl,
    timestampUtc: DateTime.now().toUtc(),
    beverageType: beverageType,
  );
  
  await repository.addLog(log);
  await storeDailyGoalSnapshot(ref, DateTime.now(), goalMl);
  
  // Invalidate providers to refresh UI
  ref.invalidate(allLogsProvider);
  ref.invalidate(todayLogsProvider);
  ref.invalidate(todayTotalProvider);

  return log;
}

/// Helper to delete log with undo support
Future<void> deleteLogWithUndo(WidgetRef ref, IntakeLog log) async {
  final repository = ref.read(intakeLogRepositoryProvider);
  
  // Store in undo stack
  ref.read(undoStackProvider.notifier).state = log;
  
  await repository.deleteLog(log.id);
  
  // Invalidate providers to refresh UI
  ref.invalidate(allLogsProvider);
  ref.invalidate(todayLogsProvider);
  ref.invalidate(todayTotalProvider);
}

/// Helper to delete a log by id without undo
Future<void> deleteLogById(WidgetRef ref, String id) async {
  final repository = ref.read(intakeLogRepositoryProvider);
  await repository.deleteLog(id);

  ref.invalidate(allLogsProvider);
  ref.invalidate(todayLogsProvider);
  ref.invalidate(todayTotalProvider);
}

/// Helper to undo delete
Future<void> undoDelete(WidgetRef ref) async {
  final log = ref.read(undoStackProvider);
  if (log == null) return;
  
  final repository = ref.read(intakeLogRepositoryProvider);
  await repository.addLog(log);
  
  // Clear undo stack
  ref.read(undoStackProvider.notifier).state = null;
  
  // Invalidate providers to refresh UI
  ref.invalidate(allLogsProvider);
  ref.invalidate(todayLogsProvider);
  ref.invalidate(todayTotalProvider);
}
