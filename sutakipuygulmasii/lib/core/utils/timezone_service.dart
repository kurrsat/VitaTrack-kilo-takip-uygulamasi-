import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:water_reminder/core/logger/logger.dart';

final _logger = LoggerFactory.getLogger('TimezoneService');

/// Service for managing timezone changes and initialization
class TimezoneService {
  TimezoneService({
    required this.onTimezoneChanged,
  });

  /// Callback when timezone changes and reschedule is needed
  final void Function() onTimezoneChanged;

  String? _lastKnownTimezoneId;
  bool _needsReschedule = false;

  /// Gets the last known timezone ID
  String? get lastKnownTimezoneId => _lastKnownTimezoneId;

  /// Checks if reminders need to be rescheduled
  bool get needsReschedule => _needsReschedule;

  /// Acknowledges that rescheduling has been done
  void acknowledgeReschedule() {
    _needsReschedule = false;
    _logger.info('Reschedule acknowledged, flag cleared');
  }

  /// Initializes timezone database and sets local timezone
  /// Should be called on app start
  Future<void> initialize() async {
    try {
      _logger.info('Initializing timezone database');
      // Initialize timezone database with all timezones
      tz.initializeTimeZones();

      // Get and set the device's current timezone
      await updateTimezone();

      _logger.info('Timezone initialization completed');
    } catch (e, stackTrace) {
      _logger.error('Failed to initialize timezone', e, stackTrace);
      // Fall back to UTC if initialization fails
      tz.setLocalLocation(tz.getLocation('UTC'));
      _lastKnownTimezoneId = 'UTC';
    }
  }

  /// Updates the timezone based on device settings
  /// Should be called on app resume and periodically
  Future<void> updateTimezone() async {
    try {
      // Get current timezone from device
      final currentTimezoneId = await FlutterTimezone.getLocalTimezone();
      _logger.info('Current device timezone: $currentTimezoneId');

      // Check if timezone has changed
      if (_lastKnownTimezoneId != null &&
          _lastKnownTimezoneId != currentTimezoneId) {
        _logger.warning(
          'Timezone changed from $_lastKnownTimezoneId to $currentTimezoneId',
        );

        // Set the flag for rescheduling
        _needsReschedule = true;

        // Notify listeners
        onTimezoneChanged();
      }

      // Update tz.local location
      try {
        final location = tz.getLocation(currentTimezoneId);
        tz.setLocalLocation(location);
        _lastKnownTimezoneId = currentTimezoneId;
        _logger.info('Local timezone updated to: $currentTimezoneId');
      } catch (e) {
        _logger.warning(
          'Failed to set timezone $currentTimezoneId, trying fallback',
        );
        // Try common fallback mappings
        final fallbackLocation = _getFallbackLocation(currentTimezoneId);
        tz.setLocalLocation(fallbackLocation);
        _lastKnownTimezoneId = fallbackLocation.name;
        _logger.info('Using fallback timezone: ${fallbackLocation.name}');
      }
    } catch (e, stackTrace) {
      _logger.error('Failed to update timezone', e, stackTrace);
    }
  }

  /// Gets a fallback timezone location if the exact one is not found
  tz.Location _getFallbackLocation(String timezoneId) {
    // Common fallback mappings for different regions
    final fallbacks = <String, String>{
      // North America
      'America/New_York': 'America/New_York',
      'America/Chicago': 'America/Chicago',
      'America/Denver': 'America/Denver',
      'America/Los_Angeles': 'America/Los_Angeles',

      // Europe
      'Europe/London': 'Europe/London',
      'Europe/Paris': 'Europe/Paris',
      'Europe/Istanbul': 'Europe/Istanbul',
      'Europe/Moscow': 'Europe/Moscow',

      // Asia
      'Asia/Dubai': 'Asia/Dubai',
      'Asia/Kolkata': 'Asia/Kolkata',
      'Asia/Shanghai': 'Asia/Shanghai',
      'Asia/Tokyo': 'Asia/Tokyo',

      // Others
      'Australia/Sydney': 'Australia/Sydney',
    };

    // Try to find a matching fallback
    for (final entry in fallbacks.entries) {
      if (timezoneId.contains(entry.key)) {
        try {
          return tz.getLocation(entry.value);
        } catch (e) {
          continue;
        }
      }
    }

    // Ultimate fallback: UTC
    return tz.getLocation('UTC');
  }

  /// Gets the current timezone offset in hours
  double getCurrentTimezoneOffset() {
    final now = DateTime.now();
    final offset = now.timeZoneOffset;
    return offset.inMinutes / 60.0;
  }

  /// Gets the current timezone name
  String getCurrentTimezoneName() {
    return tz.local.name;
  }

  /// Checks if DST (Daylight Saving Time) is currently active
  bool isDSTActive([DateTime? referenceTime]) {
    final reference = referenceTime ?? DateTime.now();
    final tzDateTime = tz.TZDateTime.from(reference, tz.local);

    // Compare offset at this time vs offset at a known non-DST time (January)
    final januaryDate = tz.TZDateTime(tz.local, tzDateTime.year, 1, 1);

    return tzDateTime.timeZoneOffset != januaryDate.timeZoneOffset;
  }
}
