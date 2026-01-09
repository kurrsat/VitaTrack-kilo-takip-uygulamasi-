import 'package:weightvault/domain/models/models.dart';
abstract class UserProfileRepository {
  Future<UserProfile?> getProfile(String uid);
  Stream<UserProfile?> watchProfile(String uid);
  Future<void> upsert(UserProfile profile, {bool isDirty = true});
  Future<void> deleteAll(String uid);
}

abstract class WeightRepository {
  Stream<List<WeightEntry>> watchEntries(String uid, {DateTime? from, DateTime? to});
  Future<List<WeightEntry>> getDirtyEntries(String uid);
  Future<void> upsert(WeightEntry entry, {bool isDirty = true});
  Future<void> markSynced(String uid, List<String> ids);
  Future<void> softDelete(String uid, String id);
  Future<void> hardDeleteAll(String uid);
}

abstract class MeasurementRepository {
  Stream<List<MeasurementEntry>> watchEntries(String uid);
  Future<List<MeasurementEntry>> getDirtyEntries(String uid);
  Future<void> upsert(MeasurementEntry entry, {bool isDirty = true});
  Future<void> markSynced(String uid, List<String> ids);
  Future<void> softDelete(String uid, String id);
  Future<void> hardDeleteAll(String uid);
}

abstract class WaterRepository {
  Stream<List<WaterEntry>> watchAll(String uid);
  Stream<List<WaterEntry>> watchByDate(String uid, DateTime date);
  Future<List<WaterEntry>> getDirtyEntries(String uid);
  Future<void> upsert(WaterEntry entry, {bool isDirty = true});
  Future<void> markSynced(String uid, List<String> ids);
  Future<void> softDelete(String uid, String id);
  Future<void> hardDeleteAll(String uid);
}

abstract class FoodRepository {
  Stream<List<FoodEntry>> watchAll(String uid);
  Stream<List<FoodEntry>> watchByDate(String uid, DateTime date);
  Future<List<FoodEntry>> getDirtyEntries(String uid);
  Future<void> upsert(FoodEntry entry, {bool isDirty = true});
  Future<void> markSynced(String uid, List<String> ids);
  Future<void> softDelete(String uid, String id);
  Future<void> hardDeleteAll(String uid);
}

abstract class CustomFoodRepository {
  Stream<List<CustomFood>> watchAll(String uid);
  Future<List<CustomFood>> getDirtyEntries(String uid);
  Future<void> upsert(CustomFood food, {bool isDirty = true});
  Future<void> markSynced(String uid, List<String> ids);
  Future<void> softDelete(String uid, String id);
  Future<void> hardDeleteAll(String uid);
}

abstract class FastingRepository {
  Stream<List<FastingSession>> watchAll(String uid);
  Future<FastingSession?> getActive(String uid);
  Future<List<FastingSession>> getDirtyEntries(String uid);
  Future<void> upsert(FastingSession session, {bool isDirty = true});
  Future<void> markSynced(String uid, List<String> ids);
  Future<void> softDelete(String uid, String id);
  Future<void> hardDeleteAll(String uid);
}

abstract class ActivityRepository {
  Stream<List<ActivityEntry>> watchAll(String uid);
  Future<List<ActivityEntry>> getDirtyEntries(String uid);
  Future<void> upsert(ActivityEntry entry, {bool isDirty = true});
  Future<void> markSynced(String uid, List<String> ids);
  Future<void> softDelete(String uid, String id);
  Future<void> hardDeleteAll(String uid);
}

abstract class PhotoRepository {
  Stream<List<PhotoEntry>> watchAll(String uid);
  Future<List<PhotoEntry>> getDirtyEntries(String uid);
  Future<void> upsert(PhotoEntry entry, {bool isDirty = true});
  Future<void> markSynced(String uid, List<String> ids);
  Future<void> softDelete(String uid, String id);
  Future<void> hardDeleteAll(String uid);
}

abstract class SyncLogRepository {
  Future<void> addLog(SyncLog log);
  Stream<List<SyncLog>> watchAll(String uid);
  Future<void> deleteAll(String uid);
}
