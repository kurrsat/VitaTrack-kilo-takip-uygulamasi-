import 'package:weightvault/data/db/app_database.dart';
import 'package:weightvault/data/repositories/mappers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/repositories/repositories.dart';
class DriftUserProfileRepository implements UserProfileRepository {
  DriftUserProfileRepository(this._db);

  final AppDatabase _db;

  @override
  Future<UserProfile?> getProfile(String uid) async {
    final query = _db.select(_db.userProfiles)..where((tbl) => tbl.uid.equals(uid));
    final row = await query.getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Stream<UserProfile?> watchProfile(String uid) {
    final query = _db.select(_db.userProfiles)..where((tbl) => tbl.uid.equals(uid));
    return query.watchSingleOrNull().map((row) => row?.toDomain());
  }

  @override
  Future<void> upsert(UserProfile profile, {bool isDirty = true}) async {
    await _db.into(_db.userProfiles).insertOnConflictUpdate(
          userProfileToCompanion(profile, isDirty: isDirty),
        );
  }

  @override
  Future<void> deleteAll(String uid) async {
    await (_db.delete(_db.userProfiles)..where((tbl) => tbl.uid.equals(uid))).go();
  }
}
