import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_reminder/core/logger/logger.dart';
import 'package:water_reminder/core/services/notification_service.dart';
import 'package:water_reminder/core/utils/time_service.dart';
import 'package:water_reminder/core/utils/timezone_service.dart';

final _logger = LoggerFactory.getLogger('CoreProviders');

/// Provider for TimeService with configurable day start hour
final timeServiceProvider = Provider<TimeService>((ref) {
  // In the future, this can read dayStartHour from settings
  const dayStartHour = 0; // Midnight by default
  return TimeService(dayStartHour: dayStartHour);
});

/// Provider for TimezoneService
final timezoneServiceProvider = Provider<TimezoneService>((ref) {
  return TimezoneService(
    onTimezoneChanged: () {
      _logger.warning('Timezone changed - reminders need rescheduling');
      // The needsReschedule flag is tracked within TimezoneService itself
      // UI can watch timezoneService.needsReschedule via a separate provider
    },
  );
});

/// Provider to track if reschedule is needed
final needsRescheduleProvider = Provider<bool>((ref) {
  final timezoneService = ref.watch(timezoneServiceProvider);
  return timezoneService.needsReschedule;
});

/// Provider for NotificationService
final notificationServiceProvider = Provider<NotificationService>((ref) {
  final timeService = ref.watch(timeServiceProvider);

  return NotificationService(
    timeService: timeService,
    onNotificationTap: (payload) {
      _logger.info('Notification tapped with payload: $payload');
      // TODO: Navigate to hydration page
    },
    onActionTap: (action, payload) {
      _logger.info('Action tapped: $action, payload: $payload');
      // TODO: Handle actions (add water, snooze)
    },
  );
});
