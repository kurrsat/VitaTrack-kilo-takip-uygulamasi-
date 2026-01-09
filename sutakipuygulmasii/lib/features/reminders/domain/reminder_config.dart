import 'package:equatable/equatable.dart';

/// Days of the week for reminder scheduling
enum DayOfWeek {
  monday(1),
  tuesday(2),
  wednesday(3),
  thursday(4),
  friday(5),
  saturday(6),
  sunday(7);

  const DayOfWeek(this.value);
  final int value;

  static DayOfWeek fromDateTime(DateTime dateTime) {
    return DayOfWeek.values[dateTime.weekday - 1];
  }
}

/// Reminder mode types
enum ReminderMode {
  /// Equal intervals throughout awake window
  interval,

  /// Specific fixed times
  fixedTimes,
}

/// Time range for quiet hours or awake window
class TimeRange extends Equatable {
  const TimeRange({
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
  })  : assert(startHour >= 0 && startHour < 24),
        assert(endHour >= 0 && endHour < 24),
        assert(startMinute >= 0 && startMinute < 60),
        assert(endMinute >= 0 && endMinute < 60);

  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;

  /// Checks if a given time falls within this range
  bool contains(int hour, int minute) {
    final timeInMinutes = hour * 60 + minute;
    final startInMinutes = startHour * 60 + startMinute;
    final endInMinutes = endHour * 60 + endMinute;

    // Handle overnight ranges (e.g., 22:00 - 07:00)
    if (endInMinutes <= startInMinutes) {
      return timeInMinutes >= startInMinutes || timeInMinutes <= endInMinutes;
    }

    return timeInMinutes >= startInMinutes && timeInMinutes <= endInMinutes;
  }

  Map<String, dynamic> toJson() => {
        'startHour': startHour,
        'startMinute': startMinute,
        'endHour': endHour,
        'endMinute': endMinute,
      };

  factory TimeRange.fromJson(Map<String, dynamic> json) => TimeRange(
        startHour: json['startHour'] as int,
        startMinute: json['startMinute'] as int,
        endHour: json['endHour'] as int,
        endMinute: json['endMinute'] as int,
      );

  @override
  List<Object?> get props => [startHour, startMinute, endHour, endMinute];

  @override
  String toString() =>
      'TimeRange($startHour:${startMinute.toString().padLeft(2, '0')} - '
      '$endHour:${endMinute.toString().padLeft(2, '0')})';
}

/// Configuration for water intake reminders
class ReminderConfig extends Equatable {
  const ReminderConfig({
    required this.id,
    required this.mode,
    required this.isEnabled,
    this.intervalMinutes = 60,
    this.fixedTimes = const [],
    this.activeDays = const {
      DayOfWeek.monday,
      DayOfWeek.tuesday,
      DayOfWeek.wednesday,
      DayOfWeek.thursday,
      DayOfWeek.friday,
      DayOfWeek.saturday,
      DayOfWeek.sunday,
    },
    this.awakeWindow = const TimeRange(
      startHour: 7,
      startMinute: 0,
      endHour: 22,
      endMinute: 0,
    ),
    this.quietHours,
    this.defaultCupAmountMl = 200,
  });

  final String id;
  final ReminderMode mode;
  final bool isEnabled;

  /// For interval mode: minutes between reminders
  final int intervalMinutes;

  /// For fixed times mode: specific times (hours and minutes)
  final List<TimeRange> fixedTimes;

  /// Days when reminders are active
  final Set<DayOfWeek> activeDays;

  /// Time window when user is awake (for interval distribution)
  final TimeRange awakeWindow;

  /// Optional quiet hours when no reminders should be sent
  final TimeRange? quietHours;

  /// Default amount when tapping quick action
  final int defaultCupAmountMl;

  bool isActiveOnDay(DayOfWeek day) => activeDays.contains(day);

  bool isActiveToday(DateTime dateTime) =>
      isActiveOnDay(DayOfWeek.fromDateTime(dateTime));

  bool isQuietTime(int hour, int minute) =>
      quietHours?.contains(hour, minute) ?? false;

  ReminderConfig copyWith({
    String? id,
    ReminderMode? mode,
    bool? isEnabled,
    int? intervalMinutes,
    List<TimeRange>? fixedTimes,
    Set<DayOfWeek>? activeDays,
    TimeRange? awakeWindow,
    TimeRange? quietHours,
    int? defaultCupAmountMl,
  }) {
    return ReminderConfig(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      isEnabled: isEnabled ?? this.isEnabled,
      intervalMinutes: intervalMinutes ?? this.intervalMinutes,
      fixedTimes: fixedTimes ?? this.fixedTimes,
      activeDays: activeDays ?? this.activeDays,
      awakeWindow: awakeWindow ?? this.awakeWindow,
      quietHours: quietHours ?? this.quietHours,
      defaultCupAmountMl: defaultCupAmountMl ?? this.defaultCupAmountMl,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'mode': mode.name,
        'isEnabled': isEnabled,
        'intervalMinutes': intervalMinutes,
        'fixedTimes': fixedTimes.map((t) => t.toJson()).toList(),
        'activeDays': activeDays.map((d) => d.name).toList(),
        'awakeWindow': awakeWindow.toJson(),
        'quietHours': quietHours?.toJson(),
        'defaultCupAmountMl': defaultCupAmountMl,
      };

  factory ReminderConfig.fromJson(Map<String, dynamic> json) {
    return ReminderConfig(
      id: json['id'] as String,
      mode: ReminderMode.values.byName(json['mode'] as String),
      isEnabled: json['isEnabled'] as bool,
      intervalMinutes: json['intervalMinutes'] as int? ?? 60,
      fixedTimes: (json['fixedTimes'] as List?)
              ?.map((t) => TimeRange.fromJson(t as Map<String, dynamic>))
              .toList() ??
          [],
      activeDays: (json['activeDays'] as List?)
              ?.map((d) => DayOfWeek.values.byName(d as String))
              .toSet() ??
          DayOfWeek.values.toSet(),
      awakeWindow: TimeRange.fromJson(
        json['awakeWindow'] as Map<String, dynamic>? ??
            {
              'startHour': 7,
              'startMinute': 0,
              'endHour': 22,
              'endMinute': 0,
            },
      ),
      quietHours: json['quietHours'] != null
          ? TimeRange.fromJson(json['quietHours'] as Map<String, dynamic>)
          : null,
      defaultCupAmountMl: json['defaultCupAmountMl'] as int? ?? 200,
    );
  }

  @override
  List<Object?> get props => [
        id,
        mode,
        isEnabled,
        intervalMinutes,
        fixedTimes,
        activeDays,
        awakeWindow,
        quietHours,
        defaultCupAmountMl,
      ];
}
