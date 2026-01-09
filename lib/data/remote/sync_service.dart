import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weightvault/core/services/crashlytics_service.dart';
import 'package:weightvault/core/services/preferences_service.dart';
import 'package:weightvault/data/remote/firebase_client.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/repositories/repositories.dart';
import 'package:weightvault/domain/services/sync_resolver.dart';

class SyncService {
  SyncService({
    required this.client,
    required this.crashlytics,
    required this.resolver,
    required this.prefs,
    required this.userProfiles,
    required this.weights,
    required this.measurements,
    required this.waters,
    required this.foods,
    required this.customFoods,
    required this.fastings,
    required this.activities,
    required this.photos,
    required this.syncLogs,
  });

  final FirebaseClient client;
  final CrashlyticsService crashlytics;
  final SyncResolver resolver;
  final PreferencesService prefs;
  final UserProfileRepository userProfiles;
  final WeightRepository weights;
  final MeasurementRepository measurements;
  final WaterRepository waters;
  final FoodRepository foods;
  final CustomFoodRepository customFoods;
  final FastingRepository fastings;
  final ActivityRepository activities;
  final PhotoRepository photos;
  final SyncLogRepository syncLogs;

  Future<void> syncAll(String uid) async {
    final lastSync = prefs.lastSyncAt ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
    await crashlytics.log('sync_start');
    await _syncProfile(uid);
    await _syncEntity<WeightEntry>(
      uid: uid,
      collection: 'weights',
      lastSync: lastSync,
      dirtyEntries: () => weights.getDirtyEntries(uid),
      toJson: (entry) => entry.toJson(),
      fromJson: WeightEntry.fromJson,
      upsertLocal: (entry) => weights.upsert(entry, isDirty: false),
      markSynced: (ids) => weights.markSynced(uid, ids),
    );

    await _syncEntity<MeasurementEntry>(
      uid: uid,
      collection: 'measurements',
      lastSync: lastSync,
      dirtyEntries: () => measurements.getDirtyEntries(uid),
      toJson: (entry) => entry.toJson(),
      fromJson: MeasurementEntry.fromJson,
      upsertLocal: (entry) => measurements.upsert(entry, isDirty: false),
      markSynced: (ids) => measurements.markSynced(uid, ids),
    );

    await _syncEntity<WaterEntry>(
      uid: uid,
      collection: 'water',
      lastSync: lastSync,
      dirtyEntries: () => waters.getDirtyEntries(uid),
      toJson: (entry) => entry.toJson(),
      fromJson: WaterEntry.fromJson,
      upsertLocal: (entry) => waters.upsert(entry, isDirty: false),
      markSynced: (ids) => waters.markSynced(uid, ids),
    );

    await _syncEntity<FoodEntry>(
      uid: uid,
      collection: 'foods',
      lastSync: lastSync,
      dirtyEntries: () => foods.getDirtyEntries(uid),
      toJson: (entry) => entry.toJson(),
      fromJson: FoodEntry.fromJson,
      upsertLocal: (entry) => foods.upsert(entry, isDirty: false),
      markSynced: (ids) => foods.markSynced(uid, ids),
    );

    await _syncEntity<CustomFood>(
      uid: uid,
      collection: 'custom_foods',
      lastSync: lastSync,
      dirtyEntries: () => customFoods.getDirtyEntries(uid),
      toJson: (entry) => entry.toJson(),
      fromJson: CustomFood.fromJson,
      upsertLocal: (entry) => customFoods.upsert(entry, isDirty: false),
      markSynced: (ids) => customFoods.markSynced(uid, ids),
    );

    await _syncEntity<FastingSession>(
      uid: uid,
      collection: 'fasting',
      lastSync: lastSync,
      dirtyEntries: () => fastings.getDirtyEntries(uid),
      toJson: (entry) => entry.toJson(),
      fromJson: FastingSession.fromJson,
      upsertLocal: (entry) => fastings.upsert(entry, isDirty: false),
      markSynced: (ids) => fastings.markSynced(uid, ids),
    );

    await _syncEntity<ActivityEntry>(
      uid: uid,
      collection: 'activities',
      lastSync: lastSync,
      dirtyEntries: () => activities.getDirtyEntries(uid),
      toJson: (entry) => entry.toJson(),
      fromJson: ActivityEntry.fromJson,
      upsertLocal: (entry) => activities.upsert(entry, isDirty: false),
      markSynced: (ids) => activities.markSynced(uid, ids),
    );

    await _syncEntity<PhotoEntry>(
      uid: uid,
      collection: 'photos',
      lastSync: lastSync,
      dirtyEntries: () => photos.getDirtyEntries(uid),
      toJson: (entry) => entry.toJson(),
      fromJson: PhotoEntry.fromJson,
      upsertLocal: (entry) => photos.upsert(entry, isDirty: false),
      markSynced: (ids) => photos.markSynced(uid, ids),
    );

    await prefs.setLastSyncAt(DateTime.now().toUtc());
    await crashlytics.log('sync_end');
  }

  Future<void> _syncProfile(String uid) async {
    final localProfile = await userProfiles.getProfile(uid);
    if (localProfile != null) {
      await client.userDoc(uid).set(localProfile.toJson(), SetOptions(merge: true));
      await userProfiles.upsert(localProfile, isDirty: false);
    }
    final remoteDoc = await client.userDoc(uid).get();
    if (remoteDoc.exists) {
      final remoteProfile = UserProfile.fromJson(remoteDoc.data()!);
      if (localProfile == null ||
          remoteProfile.lastUpdatedAt.isAfter(localProfile.lastUpdatedAt)) {
        await userProfiles.upsert(remoteProfile, isDirty: false);
      }
    }
  }

  Future<void> _syncEntity<T>({
    required String uid,
    required String collection,
    required DateTime lastSync,
    required Future<List<T>> Function() dirtyEntries,
    required Map<String, dynamic> Function(T entry) toJson,
    required T Function(Map<String, dynamic> json) fromJson,
    required Future<void> Function(T entry) upsertLocal,
    required Future<void> Function(List<String> ids) markSynced,
  }) async {
    final dirty = await dirtyEntries();
    final dirtyMap = <String, DateTime>{};
    for (final entry in dirty) {
      final json = toJson(entry);
      final id = json['id'] as String;
      final lastUpdated = DateTime.fromMillisecondsSinceEpoch(
        (json['lastUpdatedAt'] as num).toInt(),
        isUtc: true,
      );
      dirtyMap[id] = lastUpdated;
      await client.userCollection(uid, collection).doc(id).set(json, SetOptions(merge: true));
    }
    if (dirty.isNotEmpty) {
      await markSynced(dirtyMap.keys.toList());
    }

    final query = client
        .userCollection(uid, collection)
        .where('lastUpdatedAt', isGreaterThan: lastSync.millisecondsSinceEpoch);
    final snapshots = await query.get();
    for (final doc in snapshots.docs) {
      final json = doc.data();
      final entry = fromJson(json);
      final remoteUpdated = DateTime.fromMillisecondsSinceEpoch(
        (json['lastUpdatedAt'] as num).toInt(),
        isUtc: true,
      );
      final localUpdated = dirtyMap[json['id'] as String];
      if (localUpdated != null && resolver.shouldUseRemote(localUpdated, remoteUpdated)) {
        await syncLogs.addLog(
          SyncLog(
            id: 'conflict_${doc.id}_${remoteUpdated.millisecondsSinceEpoch}',
            uid: uid,
            entityType: collection,
            entityId: doc.id,
            conflictInfo: 'Remote updated after local dirty entry',
            createdAt: DateTime.now().toUtc(),
          ),
        );
      }
      if (localUpdated == null || resolver.shouldUseRemote(localUpdated, remoteUpdated)) {
        await upsertLocal(entry);
      }
    }
  }
}
