import 'package:drift/drift.dart';
import 'package:weightvault/data/db/app_database.dart';
import 'package:weightvault/data/repositories/mappers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/repositories/repositories.dart';

class DriftWaterRepository implements WaterRepository {
  DriftWaterRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<WaterEntry>> watchAll(String uid) {
    final query = _db.select(_db.waterEntries)
      ..where((tbl) => tbl.uid.equals(uid) & tbl.isDeleted.equals(false))
      ..orderBy([
        (tbl) => OrderingTerm(expression: tbl.date, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map((row) => row.toDomain()).toList());
  }

  @override
  Stream<List<WaterEntry>> watchByDate(String uid, DateTime date) {
    final dayStart = DateTime.utc(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    final query = _db.select(_db.waterEntries)
      ..where(
        (tbl) =>
            tbl.uid.equals(uid) &
            tbl.isDeleted.equals(false) &
            tbl.date.isBiggerOrEqualValue(dayStart.millisecondsSinceEpoch) &
            tbl.date.isSmallerThanValue(dayEnd.millisecondsSinceEpoch),
      )
      ..orderBy([
        (tbl) => OrderingTerm(expression: tbl.date),
      ]);
    return query.watch().map((rows) => rows.map((row) => row.toDomain()).toList());
  }

  @override
  Future<List<WaterEntry>> getDirtyEntries(String uid) async {
    final query = _db.select(_db.waterEntries)
      ..where((tbl) => tbl.uid.equals(uid) & tbl.isDirty.equals(true));
    final rows = await query.get();
    return rows.map((row) => row.toDomain()).toList();
  }

  @override
  Future<void> upsert(WaterEntry entry, {bool isDirty = true}) async {
    await _db.into(_db.waterEntries).insertOnConflictUpdate(
          waterEntryToCompanion(entry, isDirty: isDirty),
        );
  }

  @override
  Future<void> markSynced(String uid, List<String> ids) async {
    await (_db.update(_db.waterEntries)
          ..where((tbl) => tbl.uid.equals(uid) & tbl.id.isIn(ids)))
        .write(const WaterEntriesCompanion(isDirty: Value(false)));
  }

  @override
  Future<void> softDelete(String uid, String id) async {
    await (_db.update(_db.waterEntries)
          ..where((tbl) => tbl.uid.equals(uid) & tbl.id.equals(id)))
        .write(
      WaterEntriesCompanion(
        isDeleted: const Value(true),
        isDirty: const Value(true),
        lastUpdatedAt: Value(DateTime.now().toUtc().millisecondsSinceEpoch),
      ),
    );
  }

  @override
  Future<void> hardDeleteAll(String uid) async {
    await (_db.delete(_db.waterEntries)..where((tbl) => tbl.uid.equals(uid))).go();
  }
}
