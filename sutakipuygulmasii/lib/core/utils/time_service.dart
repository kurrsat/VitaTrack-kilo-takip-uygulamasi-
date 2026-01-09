import 'package:timezone/timezone.dart' as tz;

/// Represents a date range for "today" based on custom day start hour
class TodayRange {
  const TodayRange({
    required this.start,
    required this.end,
  });

  final tz.TZDateTime start;
  final tz.TZDateTime end;

  bool contains(tz.TZDateTime dateTime) {
    return dateTime.isAfter(start) && dateTime.isBefore(end) ||
        dateTime.isAtSameMomentAs(start);
  }

  @override
  String toString() => 'TodayRange(start: $start, end: $end)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodayRange &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}

/// Service for time-related operations
class TimeService {
  TimeService({
    this.dayStartHour = 0,
  }) : assert(dayStartHour >= 0 && dayStartHour < 24,
            'dayStartHour must be between 0 and 23');

  /// The hour (0-23) when a new "day" starts for tracking purposes
  /// Default is 0 (midnight), but can be customized
  /// Example: if set to 4, then 3:59 AM is still "yesterday"
  final int dayStartHour;

  /// Gets the current time in the local timezone
  tz.TZDateTime now() {
    return tz.TZDateTime.now(tz.local);
  }

  /// Gets UTC time as TZDateTime
  tz.TZDateTime nowUtc() {
    return tz.TZDateTime.now(tz.UTC);
  }

  /// Converts a UTC DateTime to local TZDateTime
  tz.TZDateTime utcToLocal(DateTime utcDateTime) {
    final utcTz = tz.TZDateTime.from(utcDateTime, tz.UTC);
    return tz.TZDateTime.from(utcTz, tz.local);
  }

  /// Converts local TZDateTime to UTC DateTime
  DateTime localToUtc(tz.TZDateTime localDateTime) {
    return localDateTime.toUtc();
  }

  /// Calculates the "today" range based on dayStartHour
  ///
  /// Example: if dayStartHour = 4 and now is 2024-01-15 10:00:
  /// - start: 2024-01-15 04:00:00
  /// - end: 2024-01-16 04:00:00
  ///
  /// Example: if dayStartHour = 4 and now is 2024-01-15 03:00:
  /// - start: 2024-01-14 04:00:00
  /// - end: 2024-01-15 04:00:00
  TodayRange getTodayRange([tz.TZDateTime? referenceTime]) {
    final reference = referenceTime ?? now();

    // Get the start of the current calendar day
    final calendarDayStart = tz.TZDateTime(
      tz.local,
      reference.year,
      reference.month,
      reference.day,
      dayStartHour,
    );

    // If current time is before dayStartHour, "today" started yesterday
    final todayStart = reference.hour < dayStartHour
        ? calendarDayStart.subtract(const Duration(days: 1))
        : calendarDayStart;

    // "Today" ends at dayStartHour tomorrow
    final todayEnd = todayStart.add(const Duration(days: 1));

    return TodayRange(start: todayStart, end: todayEnd);
  }

  /// Gets the start of the current day based on dayStartHour
  tz.TZDateTime getStartOfDay([tz.TZDateTime? referenceTime]) {
    return getTodayRange(referenceTime).start;
  }

  /// Gets the end of the current day based on dayStartHour
  tz.TZDateTime getEndOfDay([tz.TZDateTime? referenceTime]) {
    return getTodayRange(referenceTime).end;
  }

  /// Checks if a given time is "today" based on dayStartHour
  bool isToday(tz.TZDateTime dateTime) {
    return getTodayRange().contains(dateTime);
  }

  /// Creates a schedule time for a given hour and minute today
  /// This is DST-safe as it uses TZDateTime
  tz.TZDateTime createScheduleTime({
    required int hour,
    required int minute,
    tz.TZDateTime? referenceDate,
  }) {
    final reference = referenceDate ?? now();

    return tz.TZDateTime(
      tz.local,
      reference.year,
      reference.month,
      reference.day,
      hour,
      minute,
    );
  }

  /// Creates schedule times for multiple hours throughout the day
  /// Returns a list of TZDateTime instances that are DST-safe
  List<tz.TZDateTime> createDailySchedule({
    required List<int> hours,
    int minute = 0,
    tz.TZDateTime? referenceDate,
  }) {
    return hours.map((hour) {
      return createScheduleTime(
        hour: hour,
        minute: minute,
        referenceDate: referenceDate,
      );
    }).toList();
  }

  /// Calculates the next occurrence of a specific time
  /// If the time has already passed today, returns tomorrow's occurrence
  tz.TZDateTime getNextOccurrence({
    required int hour,
    required int minute,
    tz.TZDateTime? referenceTime,
  }) {
    final reference = referenceTime ?? now();
    var nextTime = tz.TZDateTime(
      tz.local,
      reference.year,
      reference.month,
      reference.day,
      hour,
      minute,
    );

    // If the time has already passed, schedule for tomorrow
    if (nextTime.isBefore(reference) || nextTime.isAtSameMomentAs(reference)) {
      nextTime = nextTime.add(const Duration(days: 1));
    }

    return nextTime;
  }
}
