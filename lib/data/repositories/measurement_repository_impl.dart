import 'package:drift/drift.dart';
import 'package:weightvault/data/db/app_database.dart';
import 'package:weightvault/data/repositories/mappers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/repositories/repositories.dart';
class DriftMeasurementRepository implements MeasurementRepository {
  DriftMeasurementRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<MeasurementEntry>> watchEntries(String uid) {
    final query = _db.select(_db.measurementEntries)
      ..where((tbl) => tbl.uid.equals(uid) & tbl.isDeleted.equals(false))
      ..orderBy([
        (tbl) => OrderingTerm(expression: tbl.recordedAt, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map((row) => row.toDomain()).toList());
  }

  @override
  Future<List<MeasurementEntry>> getDirtyEntries(String uid) async {
    final query = _db.select(_db.measurementEntries)
      ..where((tbl) => tbl.uid.equals(uid) & tbl.isDirty.equals(true));
    final rows = await query.get();
    return rows.map((row) => row.toDomain()).toList();
  }

  @override
  Future<void> upsert(MeasurementEntry entry, {bool isDirty = true}) async {
    await _db.into(_db.measurementEntries).insertOnConflictUpdate(
          measurementEntryToCompanion(entry, isDirty: isDirty),
        );
  }

  @override
  Future<void> markSynced(String uid, List<String> ids) async {
    await (_db.update(_db.measurementEntries)
          ..where((tbl) => tbl.uid.equals(uid) & tbl.id.isIn(ids)))
        .write(const MeasurementEntriesCompanion(isDirty: Value(false)));
  }

  @override
  Future<void> softDelete(String uid, String id) async {
    await (_db.update(_db.measurementEntries)
          ..where((tbl) => tbl.uid.equals(uid) & tbl.id.equals(id)))
        .write(
      MeasurementEntriesCompanion(
        isDeleted: const Value(true),
        isDirty: const Value(true),
        lastUpdatedAt: Value(DateTime.now().toUtc().millisecondsSinceEpoch),
      ),
    );
  }

  @override
  Future<void> hardDeleteAll(String uid) async {
    await (_db.delete(_db.measurementEntries)..where((tbl) => tbl.uid.equals(uid))).go();
  }
}
