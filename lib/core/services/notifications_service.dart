import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class NotificationsService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    if (kIsWeb) {
      return;
    }
    tz.initializeTimeZones();
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(settings);
  }

  Future<void> showNotification({required String title, required String body}) {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'general',
        'General',
        channelDescription: 'General reminders',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    return _plugin.show(0, title, body, details);
  }

  Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required DateTime time,
  }) async {
    final scheduleTime = tz.TZDateTime.from(time, tz.local);
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'daily',
        'Daily Reminders',
        channelDescription: 'Daily reminders',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduleTime,
      details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleOneOff({
    required int id,
    required String title,
    required String body,
    required DateTime time,
  }) async {
    final scheduleTime = tz.TZDateTime.from(time, tz.local);
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'one_off',
        'One-off',
        channelDescription: 'One-off reminders',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduleTime,
      details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancel(int id) => _plugin.cancel(id);
  Future<void> cancelAll() => _plugin.cancelAll();
}
