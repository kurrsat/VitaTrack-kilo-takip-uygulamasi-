import 'package:equatable/equatable.dart';
import 'package:water_reminder/features/hydration/domain/intake_log.dart';

/// Statistics for a specific day
class DayStats extends Equatable {
  const DayStats({
    required this.date,
    required this.totalMl,
    required this.goalMl,
    required this.logs,
  });

  final DateTime date;
  final int totalMl;
  final int goalMl;
  final List<IntakeLog> logs;

  /// Percentage of goal achieved (0-100+)
  double get goalPercentage => goalMl > 0 ? (totalMl / goalMl) * 100 : 0;

  /// Whether goal was achieved
  bool get goalAchieved => totalMl >= goalMl;

  /// Number of log entries
  int get logCount => logs.length;

  @override
  List<Object?> get props => [date, totalMl, goalMl, logs];
}

/// Weekly statistics
class WeekStats extends Equatable {
  const WeekStats({
    required this.dayStats,
    required this.currentStreak,
  });

  final List<DayStats> dayStats;
  final int currentStreak;

  /// Total ml for the week
  int get weeklyTotal => dayStats.fold(0, (sum, day) => sum + day.totalMl);

  /// Average daily intake
  double get dailyAverage =>
      dayStats.isEmpty ? 0 : weeklyTotal / dayStats.length;

  /// Number of days goal was achieved
  int get daysGoalAchieved => dayStats.where((day) => day.goalAchieved).length;

  /// Percentage of days goal was achieved
  double get weeklyGoalPercentage =>
      dayStats.isEmpty ? 0 : (daysGoalAchieved / dayStats.length) * 100;

  @override
  List<Object?> get props => [dayStats, currentStreak];
}

/// Achievement/Badge types
enum AchievementType {
  firstTwoLiterDay('Ilk 2L Gunu', 'Bir gunde 2000 ml hedefine ulasti', '??'),
  sevenDayStreak('7 Gun Serisi', 'Ardisik 7 gun hedefi korudu', '??'),
  perfectWeek('Mukemmel Hafta', 'Bu hafta her gun hedefe ulasti', '?'),
  hundredLogs('Yuzuncu Kayit', 'Su kaydi 100 kez yapildi', '??');

  const AchievementType(this.title, this.description, this.emoji);

  final String title;
  final String description;
  final String emoji;
}

/// Achievement model
class Achievement extends Equatable {
  const Achievement({
    required this.type,
    required this.unlockedAt,
  });

  final AchievementType type;
  final DateTime unlockedAt;

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'unlockedAt': unlockedAt.toIso8601String(),
      };

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      type: AchievementType.values.byName(json['type'] as String),
      unlockedAt: DateTime.parse(json['unlockedAt'] as String),
    );
  }

  @override
  List<Object?> get props => [type, unlockedAt];
}

/// Daily challenge/task
class DailyChallenge extends Equatable {
  const DailyChallenge({
    required this.date,
    required this.targetLogCount,
    required this.currentLogCount,
  });

  final DateTime date;
  final int targetLogCount;
  final int currentLogCount;

  bool get isCompleted => currentLogCount >= targetLogCount;

  double get progress => targetLogCount > 0
      ? (currentLogCount / targetLogCount).clamp(0.0, 1.0)
      : 0.0;

  @override
  List<Object?> get props => [date, targetLogCount, currentLogCount];
}
