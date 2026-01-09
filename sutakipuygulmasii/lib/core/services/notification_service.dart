import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:water_reminder/core/logger/logger.dart';
import 'package:water_reminder/core/utils/time_service.dart';
import 'package:water_reminder/features/reminders/domain/reminder_config.dart';

final _logger = LoggerFactory.getLogger('NotificationService');

/// Service for managing water reminder notifications
class NotificationService {
  NotificationService({
    required this.timeService,
    required this.onNotificationTap,
    required this.onActionTap,
  });

  final TimeService timeService;
  final void Function(String? payload) onNotificationTap;
  final void Function(String action, String? payload) onActionTap;

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = 'water_reminder_channel';
  static const String _channelName = 'Su Hatirlaticilari';
  static const String _channelDescription =
      'Su icmeyi hatirlatan bildirimler';

  // Notification action IDs
  static const String actionDrinkWater = 'DRINK_WATER';
  static const String actionSnooze = 'SNOOZE';

  // Today off tracking
  DateTime? _todayOffDate;

  bool _isInitialized = false;

  bool get _supportsNotifications => !kIsWeb;

  /// Initialize notification system
  ///
  /// Sets up Android notification channels and iOS request permissions
  Future<void> initialize() async {
    // Skip initialization on web
    if (kIsWeb) {
      _logger.info('Skipping notification initialization on web platform');
      return;
    }

    if (_isInitialized) {
      _logger.info('Already initialized');
      return;
    }

    _logger.info('Initializing notification service');

    // The original `_supportsNotifications` check is now redundant with the `kIsWeb` check above,
    // but keeping it for faithfulness to the original structure if `_supportsNotifications`
    // was intended for more than just `kIsWeb`.
    if (!_supportsNotifications) {
      _logger.info('Notifications are not supported on web');
      _isInitialized = true;
      return;
    }

    // Android initialization
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization with categories and actions
    final iosPlatformChannelSpecifics = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosPlatformChannelSpecifics,
    );

    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final actionId = details.actionId;
        final payload = details.payload;

        if (actionId != null) {
          _logger.info('Action tapped: $actionId, payload: $payload');
          onActionTap(actionId, payload);
        } else {
          _logger.info('Notification tapped, payload: $payload');
          onNotificationTap(payload);
        }
      },
    );

    // Android setup
    if (defaultTargetPlatform == TargetPlatform.android) {
      await _createAndroidChannel();
    }

    // iOS setup - request permissions
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _requestIOSPermissions();
    }

    _isInitialized = true;
    _logger.info('Notification service initialized successfully');
  }

  /// Creates Android notification channel
  Future<void> _createAndroidChannel() async {
    const androidChannel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    _logger.info('Android notification channel created');
  }

  /// Requests iOS notification permissions
  Future<bool> _requestIOSPermissions() async {
    final result = await _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    _logger.info('iOS permissions requested: $result');
    return result ?? false;
  }

  /// Checks if notifications are permitted
  Future<bool> areNotificationsEnabled() async {
    if (!_supportsNotifications) {
      return false;
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      final result = await _notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled();
      return result ?? false;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      // iOS permissions are checked during initialization
      return true;
    }
    return false;
  }

  /// Schedules all notifications based on reminder config
  Future<void> scheduleReminders(ReminderConfig config) async {
    if (!_supportsNotifications) {
      _logger.info('Notifications are not supported on web');
      return;
    }
    if (!config.isEnabled) {
      _logger.info('Reminder disabled, skipping scheduling');
      return;
    }

    // Check "Today off" status
    if (isTodayOff()) {
      _logger.info('Today is off, skipping scheduling');
      return;
    }

    _logger.info('Scheduling reminders with config: ${config.id}');

    // Cancel existing reminders first
    await cancelAllReminders();

    final now = timeService.now();
    final today = DayOfWeek.fromDateTime(now);

    // Check if today is an active day
    if (!config.isActiveOnDay(today)) {
      _logger.info('Today ($today) is not an active day');
      return;
    }

    // Schedule based on mode
    switch (config.mode) {
      case ReminderMode.interval:
        await _scheduleIntervalReminders(config);
        break;
      case ReminderMode.fixedTimes:
        await _scheduleFixedTimeReminders(config);
        break;
    }
  }

  /// Schedules reminders at equal intervals
  Future<void> _scheduleIntervalReminders(ReminderConfig config) async {
    final awakeWindow = config.awakeWindow;
    final startMinutes = awakeWindow.startHour * 60 + awakeWindow.startMinute;
    final endMinutes = awakeWindow.endHour * 60 + awakeWindow.endMinute;

    // Calculate duration (handle overnight windows)
    final durationMinutes = endMinutes > startMinutes
        ? endMinutes - startMinutes
        : (24 * 60 - startMinutes) + endMinutes;

    // Calculate number of reminders (ensure at least 1)
    final reminderCount = (durationMinutes / config.intervalMinutes).floor();
    if (reminderCount <= 0) {
      _logger.warning('No reminders to schedule (duration too short)');
      return;
    }

    // Distribute reminders equally (spam prevention)
    final actualInterval = durationMinutes / reminderCount;

    _logger.info(
      'Scheduling $reminderCount interval reminders '
      '(interval: ${actualInterval.toStringAsFixed(1)} min)',
    );

    final scheduledTimes = <tz.TZDateTime>[];

    for (var i = 0; i < reminderCount; i++) {
      final offsetMinutes = (i * actualInterval).round();
      var hour = awakeWindow.startHour + (offsetMinutes ~/ 60);
      var minute = awakeWindow.startMinute + (offsetMinutes % 60);

      // Handle minute overflow
      if (minute >= 60) {
        hour += 1;
        minute -= 60;
      }

      // Handle hour overflow
      if (hour >= 24) {
        hour -= 24;
      }

      // Skip if in quiet hours
      if (config.isQuietTime(hour, minute)) {
        _logger.debug('Skipping $hour:$minute (quiet hours)');
        continue;
      }

      final scheduleTime = timeService.getNextOccurrence(
        hour: hour,
        minute: minute,
      );

      scheduledTimes.add(scheduleTime);
    }

    // Schedule the notifications
    for (var i = 0; i < scheduledTimes.length; i++) {
      await _scheduleNotification(
        id: i,
        scheduleTime: scheduledTimes[i],
        defaultCupAmount: config.defaultCupAmountMl,
      );
    }

    _logger.info('Scheduled ${scheduledTimes.length} interval reminders');
  }

  /// Schedules reminders at fixed times
  Future<void> _scheduleFixedTimeReminders(ReminderConfig config) async {
    if (config.fixedTimes.isEmpty) {
      _logger.warning('No fixed times configured');
      return;
    }

    _logger.info('Scheduling ${config.fixedTimes.length} fixed time reminders');

    var scheduledCount = 0;

    for (var i = 0; i < config.fixedTimes.length; i++) {
      final timeRange = config.fixedTimes[i];
      final hour = timeRange.startHour;
      final minute = timeRange.startMinute;

      // Skip if in quiet hours
      if (config.isQuietTime(hour, minute)) {
        _logger.debug('Skipping $hour:$minute (quiet hours)');
        continue;
      }

      final scheduleTime = timeService.getNextOccurrence(
        hour: hour,
        minute: minute,
      );

      await _scheduleNotification(
        id: i,
        scheduleTime: scheduleTime,
        defaultCupAmount: config.defaultCupAmountMl,
      );

      scheduledCount++;
    }

    _logger.info('Scheduled $scheduledCount fixed time reminders');
  }

  /// Schedules a single notification
  Future<void> _scheduleNotification({
    required int id,
    required tz.TZDateTime scheduleTime,
    required int defaultCupAmount,
  }) async {
    if (!_supportsNotifications) {
      _logger.info('Notifications are not supported on web');
      return;
    }
    try {
      final androidDetails = AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.high,
        priority: Priority.high,
        color: const Color(0xFF2196F3),
        icon: '@mipmap/ic_launcher',
        actions: [
          AndroidNotificationAction(
            actionDrinkWater,
            '+$defaultCupAmount ml ic',
            showsUserInterface: false,
          ),
          AndroidNotificationAction(
            actionSnooze,
            '15 dk ertele',
            showsUserInterface: false,
          ),
        ],
      );

      final iosDetails = DarwinNotificationDetails(
        categoryIdentifier: 'water_reminder_category',
      );

      final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.zonedSchedule(
        id,
        'Su Icme Zamani!',
        'Saglikli ve zinde kalmak icin su ic',
        scheduleTime,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      _logger.debug('Scheduled notification $id at $scheduleTime');
    } catch (e, stackTrace) {
      _logger.error('Failed to schedule notification $id', e, stackTrace);
    }
  }

  /// Cancels all scheduled reminders
  Future<void> cancelAllReminders() async {
    if (!_supportsNotifications) {
      _logger.info('Notifications are not supported on web');
      return;
    }
    await _notifications.cancelAll();
    _logger.info('Cancelled all reminders');
  }

  /// Cancels a specific reminder
  Future<void> cancelReminder(int id) async {
    if (!_supportsNotifications) {
      _logger.info('Notifications are not supported on web');
      return;
    }
    await _notifications.cancel(id);
    _logger.info('Cancelled reminder $id');
  }

  /// Shows a test notification (10 seconds from now)
  Future<void> showTestNotification({int defaultCupAmount = 200}) async {
    if (!_supportsNotifications) {
      _logger.info('Notifications are not supported on web');
      return;
    }
    _logger.info('Scheduling test notification');

    final scheduleTime = timeService.now().add(const Duration(seconds: 10));

    await _scheduleNotification(
      id: 999, // Special ID for test notifications
      scheduleTime: scheduleTime,
      defaultCupAmount: defaultCupAmount,
    );

    _logger.info('Test notification scheduled for $scheduleTime');
  }

  /// Sets "Today off" - only affects today, resets tomorrow
  void setTodayOff() {
    final today = timeService.now();
    _todayOffDate = DateTime(today.year, today.month, today.day);
    _logger.info('Today off set for $_todayOffDate');

    // Cancel today's reminders
    cancelAllReminders();
  }

  /// Clears "Today off"
  void clearTodayOff() {
    _todayOffDate = null;
    _logger.info('Today off cleared');
  }

  /// Checks if today is marked as off
  bool isTodayOff() {
    if (_todayOffDate == null) return false;

    final now = timeService.now();
    final today = DateTime(now.year, now.month, now.day);

    // Auto-clear if date has changed
    if (today.isAfter(_todayOffDate!)) {
      clearTodayOff();
      return false;
    }

    return today == _todayOffDate;
  }

  /// Snoozes the next reminder by 15 minutes
  Future<void> snoozeReminder({int defaultCupAmount = 200}) async {
    if (!_supportsNotifications) {
      _logger.info('Notifications are not supported on web');
      return;
    }
    _logger.info('Snoozing reminder for 15 minutes');

    final scheduleTime = timeService.now().add(const Duration(minutes: 15));

    await _scheduleNotification(
      id: 998, // Special ID for snoozed notifications
      scheduleTime: scheduleTime,
      defaultCupAmount: defaultCupAmount,
    );
  }

  /// Gets list of pending notifications (for debugging)
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    if (!_supportsNotifications) {
      return [];
    }
    try {
      return await _notifications.pendingNotificationRequests();
    } catch (e) {
      _logger.error('Error getting pending notifications: $e');
      return [];
    }
  }
}
