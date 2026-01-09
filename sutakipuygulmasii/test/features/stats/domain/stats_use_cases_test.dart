import 'package:flutter_test/flutter_test.dart';
import 'package:water_reminder/features/hydration/domain/intake_log.dart';
import 'package:water_reminder/features/stats/domain/stats_models.dart';
import 'package:water_reminder/features/stats/domain/stats_use_cases.dart';

void main() {
  group('CalculateStreakUseCase', () {
    late CalculateStreakUseCase useCase;

    setUp(() {
      useCase = CalculateStreakUseCase();
    });

    test('returns 0 for empty list', () {
      expect(useCase([]), 0);
    });

    test('returns 1 for single day with goal achieved', () {
      final stats = [
        DayStats(
          date: DateTime.now(),
          totalMl: 2000,
          goalMl: 2000,
          logs: [],
        ),
      ];

      expect(useCase(stats), 1);
    });

    test('returns 0 if today goal not achieved', () {
      final stats = [
        DayStats(
          date: DateTime.now(),
          totalMl: 1000,
          goalMl: 2000,
          logs: [],
        ),
      ];

      expect(useCase(stats), 0);
    });

    test('calculates streak for consecutive days', () {
      final now = DateTime.now();
      final stats = [
        DayStats(
          date: now,
          totalMl: 2000,
          goalMl: 2000,
          logs: [],
        ),
        DayStats(
          date: now.subtract(const Duration(days: 1)),
          totalMl: 2000,
          goalMl: 2000,
          logs: [],
        ),
        DayStats(
          date: now.subtract(const Duration(days: 2)),
          totalMl: 2000,
          goalMl: 2000,
          logs: [],
        ),
      ];

      expect(useCase(stats), 3);
    });

    test('streak breaks with missed day', () {
      final now = DateTime.now();
      final stats = [
        DayStats(
          date: now,
          totalMl: 2000,
          goalMl: 2000,
          logs: [],
        ),
        DayStats(
          date: now.subtract(const Duration(days: 1)),
          totalMl: 1000, // Goal not achieved
          goalMl: 2000,
          logs: [],
        ),
        DayStats(
          date: now.subtract(const Duration(days: 2)),
          totalMl: 2000,
          goalMl: 2000,
          logs: [],
        ),
      ];

      expect(useCase(stats), 1); // Only today counts
    });

    test('streak breaks with non-consecutive dates', () {
      final now = DateTime.now();
      final stats = [
        DayStats(
          date: now,
          totalMl: 2000,
          goalMl: 2000,
          logs: [],
        ),
        DayStats(
          date: now.subtract(const Duration(days: 3)), // Gap of 2 days
          totalMl: 2000,
          goalMl: 2000,
          logs: [],
        ),
      ];

      expect(useCase(stats), 1);
    });

    test('includes yesterday if today not completed yet', () {
      final now = DateTime.now();
      final stats = [
        DayStats(
          date: now,
          totalMl: 500, // Not achieved yet
          goalMl: 2000,
          logs: [],
        ),
        DayStats(
          date: now.subtract(const Duration(days: 1)),
          totalMl: 2000,
          goalMl: 2000,
          logs: [],
        ),
        DayStats(
          date: now.subtract(const Duration(days: 2)),
          totalMl: 2000,
          goalMl: 2000,
          logs: [],
        ),
      ];

      expect(useCase(stats), 0); // Streak broken by today
    });

    test('handles 7+ day streak', () {
      final now = DateTime.now();
      final stats = List.generate(
        10,
        (i) => DayStats(
          date: now.subtract(Duration(days: i)),
          totalMl: 2000,
          goalMl: 2000,
          logs: [],
        ),
      );

      expect(useCase(stats), 10);
    });
  });

  group('CalculateDayStatsUseCase', () {
    late CalculateDayStatsUseCase useCase;

    setUp(() {
      useCase = CalculateDayStatsUseCase();
    });

    test('calculates stats for day with logs', () {
      final date = DateTime(2024, 1, 15);
      final logs = [
        IntakeLog(
          id: '1',
          amountMl: 200,
          timestampUtc: DateTime(2024, 1, 15, 8, 0).toUtc(),
        ),
        IntakeLog(
          id: '2',
          amountMl: 300,
          timestampUtc: DateTime(2024, 1, 15, 12, 0).toUtc(),
        ),
        IntakeLog(
          id: '3',
          amountMl: 500,
          timestampUtc: DateTime(2024, 1, 15, 18, 0).toUtc(),
        ),
      ];

      final stats = useCase(date: date, logs: logs, goalMl: 2000);

      expect(stats.totalMl, 1000);
      expect(stats.goalMl, 2000);
      expect(stats.goalPercentage, 50.0);
      expect(stats.goalAchieved, false);
      expect(stats.logCount, 3);
    });

    test('filters out logs from other days', () {
      final date = DateTime(2024, 1, 15);
      final logs = [
        IntakeLog(
          id: '1',
          amountMl: 200,
          timestampUtc: DateTime(2024, 1, 15, 8, 0).toUtc(),
        ),
        IntakeLog(
          id: '2',
          amountMl: 300,
          timestampUtc: DateTime(2024, 1, 14, 12, 0).toUtc(), // Previous day
        ),
        IntakeLog(
          id: '3',
          amountMl: 500,
          timestampUtc: DateTime(2024, 1, 16, 18, 0).toUtc(), // Next day
        ),
      ];

      final stats = useCase(date: date, logs: logs, goalMl: 2000);

      expect(stats.totalMl, 200);
      expect(stats.logCount, 1);
    });

    test('returns zero stats for day with no logs', () {
      final date = DateTime(2024, 1, 15);
      final stats = useCase(date: date, logs: [], goalMl: 2000);

      expect(stats.totalMl, 0);
      expect(stats.goalPercentage, 0.0);
      expect(stats.goalAchieved, false);
      expect(stats.logCount, 0);
    });

    test('marks goal as achieved when total >= goal', () {
      final date = DateTime(2024, 1, 15);
      final logs = [
        IntakeLog(
          id: '1',
          amountMl: 2000,
          timestampUtc: DateTime(2024, 1, 15, 8, 0).toUtc(),
        ),
      ];

      final stats = useCase(date: date, logs: logs, goalMl: 2000);

      expect(stats.goalAchieved, true);
      expect(stats.goalPercentage, 100.0);
    });
  });

  group('CheckAchievementsUseCase', () {
    late CheckAchievementsUseCase useCase;

    setUp(() {
      useCase = CheckAchievementsUseCase();
    });

    test('unlocks 2L day achievement', () {
      final now = DateTime.now();
      final weekStats = WeekStats(
        dayStats: [
          DayStats(
            date: now,
            totalMl: 2500,
            goalMl: 2000,
            logs: [],
          ),
        ],
        currentStreak: 1,
      );

      final newAchievements = useCase(
        allLogs: [],
        weekStats: weekStats,
        unlockedAchievements: [],
      );

      expect(
        newAchievements,
        contains(AchievementType.firstTwoLiterDay),
      );
    });

    test('unlocks 7 day streak achievement', () {
      final weekStats = WeekStats(
        dayStats: [],
        currentStreak: 7,
      );

      final newAchievements = useCase(
        allLogs: [],
        weekStats: weekStats,
        unlockedAchievements: [],
      );

      expect(
        newAchievements,
        contains(AchievementType.sevenDayStreak),
      );
    });

    test('unlocks perfect week achievement', () {
      final now = DateTime.now();
      final weekStats = WeekStats(
        dayStats: List.generate(
          7,
          (i) => DayStats(
            date: now.subtract(Duration(days: i)),
            totalMl: 2000,
            goalMl: 2000,
            logs: [],
          ),
        ),
        currentStreak: 7,
      );

      final newAchievements = useCase(
        allLogs: [],
        weekStats: weekStats,
        unlockedAchievements: [],
      );

      expect(
        newAchievements,
        contains(AchievementType.perfectWeek),
      );
    });

    test('does not unlock already unlocked achievements', () {
      final weekStats = WeekStats(
        dayStats: [],
        currentStreak: 7,
      );

      final alreadyUnlocked = [
        Achievement(
          type: AchievementType.sevenDayStreak,
          unlockedAt: DateTime.now(),
        ),
      ];

      final newAchievements = useCase(
        allLogs: [],
        weekStats: weekStats,
        unlockedAchievements: alreadyUnlocked,
      );

      expect(
        newAchievements,
        isNot(contains(AchievementType.sevenDayStreak)),
      );
    });
  });

  group('UpdateDailyChallengeUseCase', () {
    late UpdateDailyChallengeUseCase useCase;

    setUp(() {
      useCase = UpdateDailyChallengeUseCase();
    });

    test('tracks progress towards 6 log challenge', () {
      final today = DateTime.now();
      final logs = List.generate(
        4,
        (i) => IntakeLog(
          id: '$i',
          amountMl: 200,
          timestampUtc: today.add(Duration(hours: i)).toUtc(),
        ),
      );

      final challenge = useCase(date: today, logs: logs);

      expect(challenge.targetLogCount, 6);
      expect(challenge.currentLogCount, 4);
      expect(challenge.isCompleted, false);
      expect(challenge.progress, closeTo(0.667, 0.01));
    });

    test('marks challenge as completed with 6+ logs', () {
      final today = DateTime.now();
      final logs = List.generate(
        7,
        (i) => IntakeLog(
          id: '$i',
          amountMl: 200,
          timestampUtc: today.add(Duration(hours: i)).toUtc(),
        ),
      );

      final challenge = useCase(date: today, logs: logs);

      expect(challenge.isCompleted, true);
      expect(challenge.progress, 1.0);
    });

    test('filters logs to only count today', () {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));

      final logs = [
        IntakeLog(
          id: '1',
          amountMl: 200,
          timestampUtc: today.toUtc(),
        ),
        IntakeLog(
          id: '2',
          amountMl: 200,
          timestampUtc: yesterday.toUtc(),
        ),
      ];

      final challenge = useCase(date: today, logs: logs);

      expect(challenge.currentLogCount, 1);
    });
  });
}
