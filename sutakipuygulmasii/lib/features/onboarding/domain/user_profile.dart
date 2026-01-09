import 'package:equatable/equatable.dart';

/// Activity levels for water intake calculation
enum ActivityLevel {
  sedentary('Hareketsiz', 'Az veya hic egzersiz', 30),
  light('Hafif', 'Haftada 1-3 gun egzersiz', 35),
  moderate('Orta', 'Haftada 3-5 gun egzersiz', 40),
  active('Aktif', 'Haftada 6-7 gun egzersiz', 45),
  veryActive('Cok Aktif', 'Fiziksel is veya yogun antrenman', 50);

  const ActivityLevel(this.label, this.description, this.mlPerKg);

  final String label;
  final String description;
  final int mlPerKg; // ml of water per kg of body weight
}

/// Unit preferences
enum UnitSystem {
  metric('Metrik', 'kg, ml'),
  imperial('Imperyal', 'lbs, oz');

  const UnitSystem(this.label, this.units);

  final String label;
  final String units;
}

/// Cup preset configuration
class CupPreset extends Equatable {
  const CupPreset({
    required this.amountMl,
    required this.isDefault,
  });

  final int amountMl;
  final bool isDefault;

  CupPreset copyWith({
    int? amountMl,
    bool? isDefault,
  }) {
    return CupPreset(
      amountMl: amountMl ?? this.amountMl,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toJson() => {
        'amountMl': amountMl,
        'isDefault': isDefault,
      };

  factory CupPreset.fromJson(Map<String, dynamic> json) => CupPreset(
        amountMl: json['amountMl'] as int,
        isDefault: json['isDefault'] as bool,
      );

  @override
  List<Object?> get props => [amountMl, isDefault];
}

/// User profile information
class UserProfile extends Equatable {
  const UserProfile({
    required this.weightKg,
    required this.activityLevel,
    required this.wakeHour,
    required this.wakeMinute,
    required this.sleepHour,
    required this.sleepMinute,
    this.unitSystem = UnitSystem.metric,
    this.dailyGoalMl,
    this.dayStartHour = 0,
    this.cupPresets = const [],
  });

  final double weightKg;
  final ActivityLevel activityLevel;
  final int wakeHour;
  final int wakeMinute;
  final int sleepHour;
  final int sleepMinute;
  final UnitSystem unitSystem;
  final int? dailyGoalMl; // null = use calculated value
  final int dayStartHour; // Advanced: when "today" starts for tracking
  final List<CupPreset> cupPresets;

  /// Calculates recommended daily water intake in ml
  int calculateRecommendedGoal() {
    return (weightKg * activityLevel.mlPerKg).round();
  }

  /// Gets the active daily goal (manual override or calculated)
  int get effectiveDailyGoal => dailyGoalMl ?? calculateRecommendedGoal();

  /// Gets awake duration in hours
  double get awakeDurationHours {
    final wakeMinutes = wakeHour * 60 + wakeMinute;
    final sleepMinutes = sleepHour * 60 + sleepMinute;

    final durationMinutes = sleepMinutes > wakeMinutes
        ? sleepMinutes - wakeMinutes
        : (24 * 60 - wakeMinutes) + sleepMinutes;

    return durationMinutes / 60.0;
  }

  UserProfile copyWith({
    double? weightKg,
    ActivityLevel? activityLevel,
    int? wakeHour,
    int? wakeMinute,
    int? sleepHour,
    int? sleepMinute,
    UnitSystem? unitSystem,
    int? dailyGoalMl,
    int? dayStartHour,
    List<CupPreset>? cupPresets,
  }) {
    return UserProfile(
      weightKg: weightKg ?? this.weightKg,
      activityLevel: activityLevel ?? this.activityLevel,
      wakeHour: wakeHour ?? this.wakeHour,
      wakeMinute: wakeMinute ?? this.wakeMinute,
      sleepHour: sleepHour ?? this.sleepHour,
      sleepMinute: sleepMinute ?? this.sleepMinute,
      unitSystem: unitSystem ?? this.unitSystem,
      dailyGoalMl: dailyGoalMl,
      dayStartHour: dayStartHour ?? this.dayStartHour,
      cupPresets: cupPresets ?? this.cupPresets,
    );
  }

  Map<String, dynamic> toJson() => {
        'weightKg': weightKg,
        'activityLevel': activityLevel.name,
        'wakeHour': wakeHour,
        'wakeMinute': wakeMinute,
        'sleepHour': sleepHour,
        'sleepMinute': sleepMinute,
        'unitSystem': unitSystem.name,
        'dailyGoalMl': dailyGoalMl,
        'dayStartHour': dayStartHour,
        'cupPresets': cupPresets.map((c) => c.toJson()).toList(),
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      weightKg: (json['weightKg'] as num).toDouble(),
      activityLevel:
          ActivityLevel.values.byName(json['activityLevel'] as String),
      wakeHour: json['wakeHour'] as int,
      wakeMinute: json['wakeMinute'] as int,
      sleepHour: json['sleepHour'] as int,
      sleepMinute: json['sleepMinute'] as int,
      unitSystem: json['unitSystem'] != null
          ? UnitSystem.values.byName(json['unitSystem'] as String)
          : UnitSystem.metric,
      dailyGoalMl: json['dailyGoalMl'] as int?,
      dayStartHour: json['dayStartHour'] as int? ?? 0,
      cupPresets: (json['cupPresets'] as List?)
              ?.map((c) => CupPreset.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [
        weightKg,
        activityLevel,
        wakeHour,
        wakeMinute,
        sleepHour,
        sleepMinute,
        unitSystem,
        dailyGoalMl,
        dayStartHour,
        cupPresets,
      ];
}
