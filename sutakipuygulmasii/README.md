# Water Reminder App 💧

A Flutter application for tracking water intake with reminders, built using Clean Architecture and Material 3 design.

## Tech Stack

- **Flutter SDK**: ^3.5.3
- **State Management**: flutter_riverpod ^2.5.1
- **Navigation**: go_router ^14.2.0
- **Database**: Hive ^2.2.3 (with hive_flutter ^1.1.0)
- **Notifications**: flutter_local_notifications ^17.2.2
- **Timezone**: timezone ^0.9.4, flutter_timezone ^1.0.8
- **Charts**: fl_chart ^0.69.0
- **File Operations**: path_provider ^2.1.4, share_plus ^10.1.3, file_picker ^8.1.6

## Architecture

This project follows **Clean Architecture** principles with a **feature-first** folder structure:

```
lib/
├── app/                  # App-level configurations
│   ├── router.dart       # GoRouter configuration
│   └── theme.dart        # Material 3 theme
├── core/                 # Core utilities and shared code
│   ├── constants/        # App-wide constants
│   ├── errors/           # Error handling
│   ├── logger/           # Logging utility
│   ├── result/           # Result/Either types
│   └── utils/            # Utility functions
└── features/             # Feature modules
    ├── onboarding/       # App introduction
    ├── hydration/        # Water intake tracking
    ├── reminders/        # Notification management
    ├── stats/            # Statistics and charts
    ├── settings/         # App settings
    └── premium/          # Premium features

Each feature follows the Clean Architecture layers:
    ├── data/             # Data sources, repositories
    ├── domain/           # Business logic, entities, use cases
    └── presentation/     # UI, widgets, providers
```

## Database Choice

**Hive** was chosen for local storage due to:
- Fast performance
- Simple setup
- No native dependencies
- Type-safe box operations
- Great for mobile apps

## Setup & Run

### Prerequisites

- Flutter SDK (3.5.3 or higher)
- Dart SDK (included with Flutter)
- Android Studio / VS Code with Flutter extensions
- iOS: Xcode (for iOS development)
- Android: Android SDK

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd water_reminder
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate localization files**
   ```bash
   flutter gen-l10n
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Running on Specific Platforms

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web
flutter run -d chrome

# Windows
flutter run -d windows
```

## Notification Setup

### Android Configuration

For notifications to work properly on Android, you need to:

1. **Add permissions** to `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
   <uses-permission android:name="android.permission.VIBRATE" />
   <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
   <uses-permission android:name="android.permission.USE_EXACT_ALARM" />
   <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
   ```

2. **Configure notification icon** (optional):
   - Place a white icon PNG in `android/app/src/main/res/drawable/`
   - Update `@mipmap/ic_launcher` in `NotificationService` if using custom icon

3. **Exact Alarm Permission** (Android 12+):
   - Required for precise notification scheduling
   - User must grant "Alarms & Reminders" permission in settings
   - The app will request this permission automatically

4. **Battery Optimization**:
   - Users may need to disable battery optimization for the app
   - This ensures notifications fire on time
   - Path: Settings → Apps → Water Reminder → Battery → Unrestricted

### iOS Configuration

For notifications to work on iOS:

1. **Notification Permission**:
   - Requested automatically on first launch
   - User can enable/disable in iOS Settings → Water Reminder → Notifications

2. **Add notification category** to `ios/Runner/AppDelegate.swift`:
   ```swift
   import UIKit
   import Flutter

   @UIApplicationMain
   @objc class AppDelegate: FlutterAppDelegate {
     override func application(
       _ application: UIApplication,
       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
     ) -> Bool {
       // Register notification categories
       if #available(iOS 10.0, *) {
         UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
         
         let drinkWaterAction = UNNotificationAction(
           identifier: "DRINK_WATER",
           title: "💧 +200 ml",
           options: []
         )
         
         let snoozeAction = UNNotificationAction(
           identifier: "SNOOZE",
           title: "⏰ Snooze 15m",
           options: []
         )
         
         let category = UNNotificationCategory(
           identifier: "water_reminder_category",
           actions: [drinkWaterAction, snoozeAction],
           intentIdentifiers: [],
           options: []
         )
         
         UNUserNotificationCenter.current().setNotificationCategories([category])
       }
       
       GeneratedPluginRegistrant.register(with: self)
       return super.application(application, didFinishLaunchingWithOptions: launchOptions)
     }
   }
   ```

## Export & Restore Data

### Exporting Your Data

1. Open **Settings** → **Data Management**
2. Tap **Export Data**
3. Wait for the share dialog to appear
4. Choose where to save or share the backup file

**What's Included in Backup:**
- ✅ User profile (weight, activity, wake/sleep times)
- ✅ App settings (goal, units, onboarding status)
-  Cup presets
- ✅ All water intake logs (with UTC timestamps)
- ✅ Achievements and badges
- ✅ Reminder configurations (future)

**Backup File Format:**
- JSON file: `water_reminder_backup_YYYY-MM-DD...json`
- Schema version: v1 (for future compatibility)
- Human-readable for debugging

### Restoring Data

1. Open **Settings** → **Data Management**
2. Tap **Restore Data**
3. Select your backup JSON file
4. Wait for import to complete
5. Navigate to home screen (data will refresh)

**Important Notes:**
- ⚠️ Restore will **overwrite** all existing data
- ✅ Schema version compatibility is checked
- ✅ Older backups are migrated automatically
-  Backups from newer app versions show an error
- ✅ Invalid JSON files are rejected with clear errors

**Error Handling:**
- "Missing schema version" → Not a valid backup file
- "Backup is from a newer version" → Update the app first
- "Invalid JSON format" → File corruption or wrong file

## Premium Features

### Current Implementation

The app includes a **Premium feature stub** with a complete paywall UI and feature gating system.

**⚠️ Important: Payment Integration Pending**

The current implementation uses a `FakePurchaseService` for testing purposes. Real payment integration needs to be implemented using:
- **iOS/Android**: `in_app_purchase` package or `revenue_cat`
- **Web**: Stripe or similar payment gateway

### Premium Features

1. **Unlimited Cups** (Free: 3 cups, Premium: 20 cups)
   - Add as many custom cup sizes as needed
   - Feature gated via `PremiumFeatures.canAddCup()`

2. **Heatmap View** (Premium Only - Stub)
   - Visualize hydration habits over months
   - Feature gated via `PremiumFeatures.hasHeatmap()`

3. **Streak Protect** (Premium Only - Stub)
   - Save your streak when you miss a day
   - Feature gated via `PremiumFeatures.hasStreakProtect()`

4. **No Ads** 
   - Ad-free experience (note: no ads in free version either currently)

5. **Priority Support**
   - Faster support for premium users

### Testing Premium Features

**Toggle Premium Status (Debug/Testing):**

1. Open `Settings` → `Premium`
2. Purchase any plan (Monthly/Yearly/Lifetime)
3. Premium status is stored in Hive (`premium_status` box)
4. All premium features unlock immediately

**Check Feature Gating:**
```dart
final  isPremium = await ref.watch(isPremiumProvider.future);

// Cups limit
final canAdd = PremiumFeatures.canAddCup(isPremium, currentCupCount);

// Heatmap
final hasHeatmap = PremiumFeatures.hasHeatmap(isPremium);

// Streak protect
final hasProtect = PremiumFeatures.hasStreakProtect(isPremium);
```

### Implementation Checklist for Real Payments

- [ ] Choose payment provider (in_app_purchase or revenue_cat)
- [ ] Set up App Store Connect / Google Play Console products
- [ ] Implement `RealPurchaseService extends PurchaseService`
- [ ] Add receipt validation (server-side recommended)
- [ ] Handle subscription renewals and cancellations
- [ ] Implement restore purchases properly
- [ ] Add subscription management UI
- [ ] Test on real devices with sandbox accounts
- [ ] Update privacy policy with payment terms

## Testing & Troubleshootingfications

1. Navigate to **Settings → Test Notifications** in the app
2. Tap **"Send Test Notification (10s)"** button
3. Wait 10 seconds for the notification to appear
4. Test notification actions:
   - Tap "💧 +200 ml" to simulate water intake logging
   - Tap "⏰ Snooze 15m" to postpone the reminder

**Note**: Notifications will not appear while the app is in the foreground on iOS.

## Development

### Code Quality

The project uses `flutter_lints` for maintaining code quality:

```bash
# Run static analysis
flutter analyze

# Run tests
flutter test
```

### Localization

The app supports:
- 🇬🇧 English (EN)
- 🇹🇷 Turkish (TR)

Localization files are located in `lib/l10n/`:
- `app_en.arb` - English translations
- `app_tr.arb` - Turkish translations

## Features (Planned)

- [ ] Onboarding flow
- [ ] Daily water intake tracking
- [ ] Smart reminders
- [ ] Statistics and charts
- [ ] Settings customization
- [ ] Premium features
  - [ ] Unlimited custom reminders
  - [ ] Advanced statistics
  - [ ] Data export
  - [ ] Custom themes

## License

This project is private and not licensed for public use.
