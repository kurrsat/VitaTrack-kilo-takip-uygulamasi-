import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/data/remote/sync_service.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
final syncServiceProvider = FutureProvider<SyncService>((ref) async {
  final prefs = await ref.watch(preferencesProvider.future);
  return SyncService(
    client: ref.watch(firebaseClientProvider),
    crashlytics: ref.watch(crashlyticsProvider),
    resolver: ref.watch(syncResolverProvider),
    prefs: prefs,
    userProfiles: ref.watch(userProfileRepositoryProvider),
    weights: ref.watch(weightRepositoryProvider),
    measurements: ref.watch(measurementRepositoryProvider),
    waters: ref.watch(waterRepositoryProvider),
    foods: ref.watch(foodRepositoryProvider),
    customFoods: ref.watch(customFoodRepositoryProvider),
    fastings: ref.watch(fastingRepositoryProvider),
    activities: ref.watch(activityRepositoryProvider),
    photos: ref.watch(photoRepositoryProvider),
    syncLogs: ref.watch(syncLogRepositoryProvider),
  );
});
