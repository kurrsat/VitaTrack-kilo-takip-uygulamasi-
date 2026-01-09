import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/config/env.dart';
import 'package:weightvault/core/constants/app_constants.dart';
import 'package:weightvault/core/logger/logger_service.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/data/local/demo_seed_service.dart';
import 'package:weightvault/data/local/seed_food_service.dart';
import 'package:weightvault/data/remote/sync_provider.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/firebase_options.dart';

class AppInitState {
  const AppInitState({
    required this.onboardingComplete,
    required this.modeSelected,
    required this.demoMode,
    required this.authenticated,
  });

  final bool onboardingComplete;
  final bool modeSelected;
  final bool demoMode;
  final bool authenticated;
}

final appInitProvider = FutureProvider<AppInitState>((ref) async {
  final logger = ref.read(loggerProvider);
  final prefs = await ref.watch(preferencesProvider.future);
  final encryptionService = await ref.watch(databaseEncryptionProvider.future);
  final encryptionKey = await encryptionService.getActiveKey();

  await ref.read(databaseServiceProvider).init(encryptionKey: encryptionKey);
  final firebaseReady = await _initFirebase(logger);

  if (firebaseReady) {
    FlutterError.onError = (FlutterErrorDetails details) {
      ref.read(crashlyticsProvider).recordFlutterError(details);
    };
  }

  await ref.read(featureFlagServiceProvider).init();
  await ref.read(notificationsServiceProvider).init();
  if (firebaseReady) {
    await ref.read(messagingServiceProvider).init();
  }
  await ref.read(quickActionsServiceProvider).init();

  final demoModeAllowed = ref.read(featureFlagServiceProvider).demoModeEnabled;
  var demoMode = prefs.demoMode;
  if (demoMode && !demoModeAllowed) {
    demoMode = false;
    await prefs.setDemoMode(value: false);
  }
  if (!firebaseReady) {
    logger.error('Firebase is not configured; using demo mode only.');
  }
  final effectiveDemoMode = demoMode || !firebaseReady;

  final authUser = firebaseReady ? FirebaseAuth.instance.currentUser : null;
  final authenticated = authUser != null;
  if (!effectiveDemoMode && authUser != null) {
    try {
      final apiKey = Env.revenueCatApiKey;
      if (apiKey != null && apiKey.isNotEmpty) {
        await ref.read(premiumServiceProvider).init(
              apiKey: apiKey,
              appUserId: authUser.uid,
            );
      } else {
        logger.info('RevenueCat key missing; premium disabled.');
      }
      final syncService = await ref.read(syncServiceProvider.future);
      // Add timeout to prevent infinite loading on network issues
      await syncService.syncAll(authUser.uid).timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          logger.info('Initial sync timed out, continuing anyway.');
        },
      );
      await SeedFoodService(ref.read(customFoodRepositoryProvider)).ensureSeedFoods(authUser.uid);
      ref.read(syncSchedulerProvider).start(sync: () => syncService.syncAll(authUser.uid));
    } catch (error, stack) {
      logger.info('Sync failed during app init, continuing anyway.');
      await ref.read(crashlyticsProvider).recordError(error, stack);
      // Don't rethrow - continue with app initialization even if sync fails
    }
  }

  if (effectiveDemoMode) {
    final demoSeed = DemoSeedService(
      prefs: prefs,
      userProfiles: ref.read(userProfileRepositoryProvider),
      weights: ref.read(weightRepositoryProvider),
      measurements: ref.read(measurementRepositoryProvider),
      waters: ref.read(waterRepositoryProvider),
      fastings: ref.read(fastingRepositoryProvider),
      customFoods: ref.read(customFoodRepositoryProvider),
    );
    await demoSeed.seedIfNeeded();
  }

  logger.info('App init complete');
  return AppInitState(
    onboardingComplete: true, // Always skip onboarding
    modeSelected: true,       // Always skip mode selection
    demoMode: effectiveDemoMode,
    authenticated: authenticated,
  );
});

final currentUserIdProvider = Provider<String?>((ref) {
  final authUser = Firebase.apps.isNotEmpty ? FirebaseAuth.instance.currentUser : null;
  final prefsAsync = ref.watch(preferencesProvider);
  final demoMode = prefsAsync.maybeWhen(
    data: (prefs) => prefs.demoMode,
    orElse: () => false,
  );
  if (demoMode) {
    return AppConstants.demoUserId;
  }
  return authUser?.uid;
});

Future<bool> _initFirebase(LoggerService logger) async {
  if (Firebase.apps.isNotEmpty) {
    return true;
  }
  try {
    if (kIsWeb) {
      final options = DefaultFirebaseOptions.currentPlatform;
      if (options == null) {
        logger.error(
          'Missing Firebase web options. Set FIREBASE_* values in .env before running web.',
        );
        return false;
      }
      await Firebase.initializeApp(options: options);
    } else {
      final options = DefaultFirebaseOptions.currentPlatform;
      if (options != null) {
        await Firebase.initializeApp(options: options);
      } else {
        await Firebase.initializeApp();
      }
    }
    final emulatorHost = Env.firebaseEmulatorHost;
    if (emulatorHost != null && emulatorHost.isNotEmpty) {
      await FirebaseAuth.instance.useAuthEmulator(emulatorHost, Env.firebaseAuthEmulatorPort);
      FirebaseFirestore.instance
          .useFirestoreEmulator(emulatorHost, Env.firebaseFirestoreEmulatorPort);
      await FirebaseStorage.instance
          .useStorageEmulator(emulatorHost, Env.firebaseStorageEmulatorPort);
    }
    return true;
  } catch (error) {
    logger.error('Firebase init failed', error: error);
    return false;
  }
}
