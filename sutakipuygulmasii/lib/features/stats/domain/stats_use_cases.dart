import 'package:water_reminder/features/hydration/domain/intake_log.dart';
import 'package:water_reminder/features/stats/domain/stats_models.dart';

/// Use case for calculating streak
class CalculateStreakUseCase {
  /// Calculates current streak from daily stats
  /// Streak = consecutive days where goal was achieved
  int call(List<DayStats> dailyStats) {
    if (dailyStats.isEmpty) return 0;

    // Sort by date descending (most recent first)
    final sortedStats = List<DayStats>.from(dailyStats)
      ..sort((a, b) => b.date.compareTo(a.date));

    var streak = 0;
    var previousDate = DateTime.now();

    for (final dayStat in sortedStats) {
      // Check if goal was achieved
      if (!dayStat.goalAchieved) break;

      // Check if dates are consecutive
      final dayDifference = previousDate.difference(dayStat.date).inDays;

      if (streak == 0) {
        // First day - check if it's today or yesterday
        if (dayDifference <= 1) {
          streak = 1;
          previousDate = dayStat.date;
        } else {
          break; // Streak broken
        }
      } else {
        // Subsequent days - must be exactly 1 day apart
        if (dayDifference == 1) {
          streak++;
          previousDate = dayStat.date;
        } else {
          break; // Streak broken
        }
      }
    }

    return streak;
  }
}

/// Use case for calculating daily statistics
class CalculateDayStatsUseCase {
  /// Calculates statistics for a specific day
  DayStats call({
    required DateTime date,
    required List<IntakeLog> logs,
    required int goalMl,
  }) {
    // Normalize date to start of day
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));

    // Filter logs for this specific day
    final dayLogs = logs.where((log) {
      final logDate = log.timestampUtc.toLocal();
      return logDate.isAfter(dayStart) && logDate.isBefore(dayEnd) ||
          logDate.isAtSameMomentAs(dayStart);
    }).toList();

    // Calculate total
    final totalMl = dayLogs.fold<int>(
      0,
      (sum, log) => sum + log.amountMl,
    );

    return DayStats(
      date: dayStart,
      totalMl: totalMl,
      goalMl: goalMl,
      logs: dayLogs,
    );
  }
}

/// Use case for calculating weekly statistics
class CalculateWeekStatsUseCase {
  CalculateWeekStatsUseCase({
    required this.calculateDayStats,
    required this.calculateStreak,
  });

  final CalculateDayStatsUseCase calculateDayStats;
  final CalculateStreakUseCase calculateStreak;

  /// Calculates statistics for the past 7 days
  WeekStats call({
    required List<IntakeLog> allLogs,
    required int goalMl,
    int Function(DateTime date)? goalForDate,
  }) {
    final now = DateTime.now();
    final dayStats = <DayStats>[];

    // Calculate stats for each of the last 7 days
    for (var i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dayGoal = goalForDate?.call(date) ?? goalMl;
      final stats = calculateDayStats(
        date: date,
        logs: allLogs,
        goalMl: dayGoal,
      );
      dayStats.add(stats);
    }

    // Calculate streak
    final streak = calculateStreak(dayStats);

    return WeekStats(
      dayStats: dayStats,
      currentStreak: streak,
    );
  }
}

/// Use case for checking achievements
class CheckAchievementsUseCase {
  /// Checks which achievements have been unlocked
  List<AchievementType> call({
    required List<IntakeLog> allLogs,
    required WeekStats weekStats,
    required List<Achievement> unlockedAchievements,
  }) {
    final newAchievements = <AchievementType>[];
    final alreadyUnlocked = unlockedAchievements.map((a) => a.type).toSet();

    // Check for 2L day
    if (!alreadyUnlocked.contains(AchievementType.firstTwoLiterDay)) {
      final has2LDay = weekStats.dayStats.any((day) => day.totalMl >= 2000);
      if (has2LDay) {
        newAchievements.add(AchievementType.firstTwoLiterDay);
      }
    }

    // Check for 7 day streak
    if (!alreadyUnlocked.contains(AchievementType.sevenDayStreak)) {
      if (weekStats.currentStreak >= 7) {
        newAchievements.add(AchievementType.sevenDayStreak);
      }
    }

    // Check for perfect week
    if (!alreadyUnlocked.contains(AchievementType.perfectWeek)) {
      if (weekStats.daysGoalAchieved == 7) {
        newAchievements.add(AchievementType.perfectWeek);
      }
    }

    // Check for 100 logs
    if (!alreadyUnlocked.contains(AchievementType.hundredLogs)) {
      if (allLogs.length >= 100) {
        newAchievements.add(AchievementType.hundredLogs);
      }
    }

    return newAchievements;
  }
}

/// Use case for daily challenge
class UpdateDailyChallengeUseCase {
  /// Updates daily challenge progress
  DailyChallenge call({
    required DateTime date,
    required List<IntakeLog> logs,
  }) {
    const targetLogCount = 6; // "Log water 6 times today"

    // Normalize date to start of day
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));

    // Count logs for today
    final todayLogs = logs.where((log) {
      final logDate = log.timestampUtc.toLocal();
      return logDate.isAfter(dayStart) && logDate.isBefore(dayEnd) ||
          logDate.isAtSameMomentAs(dayStart);
    }).length;

    return DailyChallenge(
      date: dayStart,
      targetLogCount: targetLogCount,
      currentLogCount: todayLogs,
    );
  }
}
