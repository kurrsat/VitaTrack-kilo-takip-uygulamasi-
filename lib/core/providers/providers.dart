import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health/health.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weightvault/core/logger/logger_service.dart';
import 'package:weightvault/core/services/analytics_service.dart';
import 'package:weightvault/core/services/auth_service.dart';
import 'package:weightvault/core/services/biometric_service.dart';
import 'package:weightvault/core/services/crashlytics_service.dart';
import 'package:weightvault/core/services/database_encryption_service.dart';
import 'package:weightvault/core/services/debug_bundle_service.dart';
import 'package:weightvault/core/services/export_import_service.dart';
import 'package:weightvault/core/services/feature_flag_service.dart';
import 'package:weightvault/core/services/feedback_service.dart';
import 'package:weightvault/core/services/health_service.dart';
import 'package:weightvault/core/services/messaging_service.dart';
import 'package:weightvault/core/services/notifications_service.dart';
import 'package:weightvault/core/services/open_food_facts_service.dart';
import 'package:weightvault/core/services/preferences_service.dart';
import 'package:weightvault/core/services/premium_service.dart';
import 'package:weightvault/core/services/privacy_screen_service.dart';
import 'package:weightvault/core/services/quick_actions_service.dart';
import 'package:weightvault/core/services/secure_storage_service.dart';
import 'package:weightvault/core/services/storage_service.dart';
import 'package:weightvault/core/services/sync_scheduler.dart';
import 'package:weightvault/core/services/usda_food_service.dart';
import 'package:weightvault/core/services/widget_service.dart';
import 'package:weightvault/core/utils/units_service.dart';
import 'package:weightvault/data/db/database_service.dart';
import 'package:weightvault/data/remote/firebase_client.dart';
import 'package:weightvault/domain/services/adaptive_goal_service.dart';
import 'package:weightvault/domain/services/sync_resolver.dart';
import 'package:weightvault/domain/services/trend_service.dart';
final loggerProvider = Provider<LoggerService>((ref) => LoggerService());

final crashlyticsProvider = Provider<CrashlyticsService>(
  (ref) => CrashlyticsService(
    Firebase.apps.isNotEmpty ? FirebaseCrashlytics.instance : null,
  ),
);

final analyticsProvider = Provider<AnalyticsService>(
  (ref) => AnalyticsService(Firebase.apps.isNotEmpty ? FirebaseAnalytics.instance : null),
);

final featureFlagServiceProvider = Provider<FeatureFlagService>(
  (ref) => FeatureFlagService(
    Firebase.apps.isNotEmpty ? FirebaseRemoteConfig.instance : null,
  ),
);

final firebaseReadyProvider = Provider<bool>((ref) => Firebase.apps.isNotEmpty);

final preferencesProvider = FutureProvider<PreferencesService>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return PreferencesService(prefs);
});

final databaseServiceProvider = Provider<DatabaseService>((ref) => DatabaseService());

final secureStorageProvider = Provider<SecureStorageService>(
  (ref) => SecureStorageService(),
);

final databaseEncryptionProvider = FutureProvider<DatabaseEncryptionService>((ref) async {
  final prefs = await ref.watch(preferencesProvider.future);
  return DatabaseEncryptionService(prefs, ref.watch(secureStorageProvider));
});

final authServiceProvider = Provider<AuthService>(
  (ref) {
    final auth = Firebase.apps.isNotEmpty ? FirebaseAuth.instance : null;
    return AuthService(auth, GoogleSignIn());
  },
);

final premiumServiceProvider = Provider<PremiumService>((ref) => PremiumService());

final notificationsServiceProvider = Provider<NotificationsService>(
  (ref) => NotificationsService(),
);

final messagingServiceProvider = Provider<MessagingService>(
  (ref) => MessagingService(FirebaseMessaging.instance, ref.watch(notificationsServiceProvider)),
);

final quickActionsServiceProvider = Provider<QuickActionsService>((ref) {
  final service = QuickActionsService();
  ref.onDispose(service.dispose);
  return service;
});

final quickActionStreamProvider = StreamProvider<QuickActionType>((ref) {
  return ref.watch(quickActionsServiceProvider).actions;
});

final healthServiceProvider = Provider<HealthService>(
  (ref) => HealthService(health: Health()),
);

final storageServiceProvider = Provider<StorageService>(
  (ref) => StorageService(FirebaseStorage.instance),
);

final firebaseClientProvider = Provider<FirebaseClient>(
  (ref) => FirebaseClient(FirebaseFirestore.instance),
);

final exportImportServiceProvider = Provider<ExportImportService>((ref) => ExportImportService());

final feedbackServiceProvider = Provider<FeedbackService>((ref) => FeedbackService());

final openFoodFactsServiceProvider = Provider<OpenFoodFactsService>(
  (ref) => OpenFoodFactsService(),
);

final usdaFoodServiceProvider = Provider<UsdaFoodService>(
  (ref) => UsdaFoodService(),
);

final debugBundleServiceProvider = Provider<DebugBundleService>(
  (ref) => DebugBundleService(ref.watch(loggerProvider), ref.watch(featureFlagServiceProvider)),
);

final biometricServiceProvider = Provider<BiometricService>((ref) => BiometricService());

final privacyScreenServiceProvider = Provider<PrivacyScreenService>((ref) => PrivacyScreenService());

final unitsServiceProvider = Provider<UnitsService>((ref) => const UnitsService());

final trendServiceProvider = Provider<TrendService>((ref) => TrendService());

final adaptiveGoalServiceProvider = Provider<AdaptiveGoalService>(
  (ref) => AdaptiveGoalService(),
);

final syncResolverProvider = Provider<SyncResolver>((ref) => const SyncResolver());

final widgetServiceProvider = Provider<WidgetService>((ref) => WidgetService());

final syncSchedulerProvider = Provider<SyncScheduler>((ref) => SyncScheduler());
