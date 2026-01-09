import 'package:drift/drift.dart';
import 'package:weightvault/data/db/app_database.dart';
import 'package:weightvault/data/repositories/mappers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/repositories/repositories.dart';

class DriftCustomFoodRepository implements CustomFoodRepository {
  DriftCustomFoodRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<CustomFood>> watchAll(String uid) {
    final query = _db.select(_db.customFoods)
      ..where((tbl) => tbl.uid.equals(uid) & tbl.isDeleted.equals(false))
      ..orderBy([
        (tbl) => OrderingTerm(expression: tbl.nameTr),
      ]);
    return query.watch().map((rows) => rows.map((row) => row.toDomain()).toList());
  }

  @override
  Future<List<CustomFood>> getDirtyEntries(String uid) async {
    final query = _db.select(_db.customFoods)
      ..where((tbl) => tbl.uid.equals(uid) & tbl.isDirty.equals(true));
    final rows = await query.get();
    return rows.map((row) => row.toDomain()).toList();
  }

  @override
  Future<void> upsert(CustomFood food, {bool isDirty = true}) async {
    await _db.into(_db.customFoods).insertOnConflictUpdate(
          customFoodToCompanion(food, isDirty: isDirty),
        );
  }

  @override
  Future<void> markSynced(String uid, List<String> ids) async {
    await (_db.update(_db.customFoods)
          ..where((tbl) => tbl.uid.equals(uid) & tbl.id.isIn(ids)))
        .write(const CustomFoodsCompanion(isDirty: Value(false)));
  }

  @override
  Future<void> softDelete(String uid, String id) async {
    await (_db.update(_db.customFoods)
          ..where((tbl) => tbl.uid.equals(uid) & tbl.id.equals(id)))
        .write(
      CustomFoodsCompanion(
        isDeleted: const Value(true),
        isDirty: const Value(true),
        lastUpdatedAt: Value(DateTime.now().toUtc().millisecondsSinceEpoch),
      ),
    );
  }

  @override
  Future<void> hardDeleteAll(String uid) async {
    await (_db.delete(_db.customFoods)..where((tbl) => tbl.uid.equals(uid))).go();
  }
}
