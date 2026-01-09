/// Application-wide constants
class AppConstants {
  AppConstants._();

  /// App metadata
  static const String appName = 'Su Hatirlatici';
  static const String appVersion = '1.0.0';

  /// Default values
  static const int defaultDailyGoalMl = 2000;
  static const int defaultReminderIntervalMinutes = 60;
  static const int defaultWaterAmountMl = 250;

  /// Notification
  static const String notificationChannelId = 'water_reminder_channel';
  static const String notificationChannelName = 'Su Hatirlaticilari';
  static const String notificationChannelDescription =
      'Su icme hatirlatma bildirimleri';

  /// Database
  static const String hiveBoxName = 'water_reminder_box';
  static const String hiveIntakeBoxName = 'water_intake_box';
  static const String hiveSettingsBoxName = 'settings_box';

  /// Premium
  static const List<String> premiumFeatures = [
    'Sinirsiz ozel hatirlatici',
    'Gelismis istatistikler',
    'Veri disa aktarimi',
    'Ozel temalar',
    'Reklamsiz deneyim',
  ];
}
