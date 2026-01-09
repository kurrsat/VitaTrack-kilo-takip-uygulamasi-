import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:water_reminder/core/utils/time_service.dart';

void main() {
  setUpAll(() {
    // Initialize timezone database for testing
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/New_York'));
  });

  group('TimeService - dayStartHour boundary tests', () {
    test('default dayStartHour is midnight (0)', () {
      final timeService = TimeService();
      expect(timeService.dayStartHour, 0);
    });

    test('dayStartHour must be between 0 and 23', () {
      expect(() => TimeService(dayStartHour: -1), throwsAssertionError);
      expect(() => TimeService(dayStartHour: 24), throwsAssertionError);
      expect(() => TimeService(dayStartHour: 0), returnsNormally);
      expect(() => TimeService(dayStartHour: 23), returnsNormally);
    });

    test('getTodayRange with dayStartHour=0 (midnight)', () {
      final timeService = TimeService(dayStartHour: 0);

      // Test at 10:00 AM
      final referenceTime = tz.TZDateTime(tz.local, 2024, 1, 15, 10, 0);
      final range = timeService.getTodayRange(referenceTime);

      expect(range.start, tz.TZDateTime(tz.local, 2024, 1, 15, 0, 0));
      expect(range.end, tz.TZDateTime(tz.local, 2024, 1, 16, 0, 0));
    });

    test('getTodayRange with dayStartHour=4, time after 4 AM', () {
      final timeService = TimeService(dayStartHour: 4);

      // Test at 10:00 AM - should be in today's range
      final referenceTime = tz.TZDateTime(tz.local, 2024, 1, 15, 10, 0);
      final range = timeService.getTodayRange(referenceTime);

      expect(range.start, tz.TZDateTime(tz.local, 2024, 1, 15, 4, 0));
      expect(range.end, tz.TZDateTime(tz.local, 2024, 1, 16, 4, 0));
    });

    test('getTodayRange with dayStartHour=4, time before 4 AM', () {
      final timeService = TimeService(dayStartHour: 4);

      // Test at 3:00 AM - should still be in yesterday's range
      final referenceTime = tz.TZDateTime(tz.local, 2024, 1, 15, 3, 0);
      final range = timeService.getTodayRange(referenceTime);

      expect(range.start, tz.TZDateTime(tz.local, 2024, 1, 14, 4, 0));
      expect(range.end, tz.TZDateTime(tz.local, 2024, 1, 15, 4, 0));
    });

    test('getTodayRange with dayStartHour=4, exactly at 4 AM', () {
      final timeService = TimeService(dayStartHour: 4);

      // Test at exactly 4:00 AM - should be start of today
      final referenceTime = tz.TZDateTime(tz.local, 2024, 1, 15, 4, 0);
      final range = timeService.getTodayRange(referenceTime);

      expect(range.start, tz.TZDateTime(tz.local, 2024, 1, 15, 4, 0));
      expect(range.end, tz.TZDateTime(tz.local, 2024, 1, 16, 4, 0));
    });

    test('getTodayRange with dayStartHour=23', () {
      final timeService = TimeService(dayStartHour: 23);

      // Test at 22:00 (10 PM) - should still be in yesterday's range
      final referenceTime = tz.TZDateTime(tz.local, 2024, 1, 15, 22, 0);
      final range = timeService.getTodayRange(referenceTime);

      expect(range.start, tz.TZDateTime(tz.local, 2024, 1, 14, 23, 0));
      expect(range.end, tz.TZDateTime(tz.local, 2024, 1, 15, 23, 0));
    });

    test('isToday correctly identifies times in today range', () {
      final timeService = TimeService(dayStartHour: 4);
      final referenceTime = tz.TZDateTime(tz.local, 2024, 1, 15, 10, 0);

      // Set up service with reference time
      final range = timeService.getTodayRange(referenceTime);

      // Times within today's range (4 AM Jan 15 to 4 AM Jan 16)
      final timeInRange = tz.TZDateTime(tz.local, 2024, 1, 15, 12, 0);
      expect(range.contains(timeInRange), true);

      // Time before today's range
      final timeBeforeRange = tz.TZDateTime(tz.local, 2024, 1, 15, 3, 0);
      expect(range.contains(timeBeforeRange), false);

      // Time after today's range
      final timeAfterRange = tz.TZDateTime(tz.local, 2024, 1, 16, 5, 0);
      expect(range.contains(timeAfterRange), false);
    });

    test('TodayRange contains start time', () {
      final timeService = TimeService(dayStartHour: 4);
      final referenceTime = tz.TZDateTime(tz.local, 2024, 1, 15, 10, 0);
      final range = timeService.getTodayRange(referenceTime);

      // Start time should be included
      expect(range.contains(range.start), true);
    });

    test('TodayRange does not contain end time', () {
      final timeService = TimeService(dayStartHour: 4);
      final referenceTime = tz.TZDateTime(tz.local, 2024, 1, 15, 10, 0);
      final range = timeService.getTodayRange(referenceTime);

      // End time should not be included
      expect(range.contains(range.end), false);
    });
  });

  group('TimeService - DST safety tests', () {
    test('createScheduleTime generates TZDateTime (DST-safe)', () {
      final timeService = TimeService();
      final scheduleTime = timeService.createScheduleTime(
        hour: 14,
        minute: 30,
      );

      expect(scheduleTime, isA<tz.TZDateTime>());
      expect(scheduleTime.hour, 14);
      expect(scheduleTime.minute, 30);
    });

    test('createDailySchedule generates multiple TZDateTime instances', () {
      final timeService = TimeService();
      final schedules = timeService.createDailySchedule(
        hours: [8, 12, 16, 20],
        minute: 0,
      );

      expect(schedules.length, 4);
      expect(schedules[0].hour, 8);
      expect(schedules[1].hour, 12);
      expect(schedules[2].hour, 16);
      expect(schedules[3].hour, 20);

      for (final schedule in schedules) {
        expect(schedule, isA<tz.TZDateTime>());
      }
    });

    test('getNextOccurrence returns future time when time has passed', () {
      final timeService = TimeService();

      // Reference time: 3:00 PM
      final referenceTime = tz.TZDateTime(tz.local, 2024, 1, 15, 15, 0);

      // Schedule for 2:00 PM (already passed)
      final nextOccurrence = timeService.getNextOccurrence(
        hour: 14,
        minute: 0,
        referenceTime: referenceTime,
      );

      // Should return tomorrow at 2:00 PM
      expect(nextOccurrence.day, 16);
      expect(nextOccurrence.hour, 14);
      expect(nextOccurrence.minute, 0);
      expect(nextOccurrence.isAfter(referenceTime), true);
    });

    test('getNextOccurrence returns today when time has not passed', () {
      final timeService = TimeService();

      // Reference time: 1:00 PM
      final referenceTime = tz.TZDateTime(tz.local, 2024, 1, 15, 13, 0);

      // Schedule for 2:00 PM (has not passed)
      final nextOccurrence = timeService.getNextOccurrence(
        hour: 14,
        minute: 0,
        referenceTime: referenceTime,
      );

      // Should return today at 2:00 PM
      expect(nextOccurrence.day, 15);
      expect(nextOccurrence.hour, 14);
      expect(nextOccurrence.minute, 0);
      expect(nextOccurrence.isAfter(referenceTime), true);
    });
  });

  group('TimeService - UTC conversion tests', () {
    test('utcToLocal converts UTC DateTime to local TZDateTime', () {
      final timeService = TimeService();
      final utcTime = DateTime.utc(2024, 1, 15, 12, 0, 0);

      final localTime = timeService.utcToLocal(utcTime);

      expect(localTime, isA<tz.TZDateTime>());
      expect(localTime.location, tz.local);
    });

    test('localToUtc converts local TZDateTime to UTC DateTime', () {
      final timeService = TimeService();
      final localTime = tz.TZDateTime(tz.local, 2024, 1, 15, 12, 0, 0);

      final utcTime = timeService.localToUtc(localTime);

      expect(utcTime.isUtc, true);
    });

    test('round-trip conversion preserves time moment', () {
      final timeService = TimeService();
      final originalUtc = DateTime.utc(2024, 1, 15, 12, 0, 0);

      final local = timeService.utcToLocal(originalUtc);
      final backToUtc = timeService.localToUtc(local);

      expect(backToUtc.isAtSameMomentAs(originalUtc), true);
    });
  });

  group('TimeService - helper methods', () {
    test('getStartOfDay returns correct start with dayStartHour=0', () {
      final timeService = TimeService(dayStartHour: 0);
      final referenceTime = tz.TZDateTime(tz.local, 2024, 1, 15, 10, 0);

      final startOfDay = timeService.getStartOfDay(referenceTime);

      expect(startOfDay, tz.TZDateTime(tz.local, 2024, 1, 15, 0, 0));
    });

    test('getStartOfDay returns correct start with dayStartHour=4', () {
      final timeService = TimeService(dayStartHour: 4);
      final referenceTime = tz.TZDateTime(tz.local, 2024, 1, 15, 10, 0);

      final startOfDay = timeService.getStartOfDay(referenceTime);

      expect(startOfDay, tz.TZDateTime(tz.local, 2024, 1, 15, 4, 0));
    });

    test('getEndOfDay returns correct end with dayStartHour=4', () {
      final timeService = TimeService(dayStartHour: 4);
      final referenceTime = tz.TZDateTime(tz.local, 2024, 1, 15, 10, 0);

      final endOfDay = timeService.getEndOfDay(referenceTime);

      expect(endOfDay, tz.TZDateTime(tz.local, 2024, 1, 16, 4, 0));
    });
  });
}
