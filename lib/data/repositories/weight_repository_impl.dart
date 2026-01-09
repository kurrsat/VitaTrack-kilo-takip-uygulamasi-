import 'package:drift/drift.dart';
import 'package:weightvault/data/db/app_database.dart';
import 'package:weightvault/data/repositories/mappers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/repositories/repositories.dart';

class DriftWeightRepository implements WeightRepository {
  DriftWeightRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<WeightEntry>> watchEntries(String uid, {DateTime? from, DateTime? to}) {
    final query = _db.select(_db.weightEntries)
      ..where((tbl) => tbl.uid.equals(uid) & tbl.isDeleted.equals(false));
    if (from != null) {
      query.where(
        (tbl) => tbl.recordedAt.isBiggerOrEqualValue(from.toUtc().millisecondsSinceEpoch),
      );
    }
    if (to != null) {
      query.where(
        (tbl) => tbl.recordedAt.isSmallerOrEqualValue(to.toUtc().millisecondsSinceEpoch),
      );
    }
    query.orderBy([
      (tbl) => OrderingTerm(expression: tbl.recordedAt),
    ]);
    return query.watch().map((rows) => rows.map((row) => row.toDomain()).toList());
  }

  @override
  Future<List<WeightEntry>> getDirtyEntries(String uid) async {
    final query = _db.select(_db.weightEntries)
      ..where((tbl) => tbl.uid.equals(uid) & tbl.isDirty.equals(true));
    final rows = await query.get();
    return rows.map((row) => row.toDomain()).toList();
  }

  @override
  Future<void> upsert(WeightEntry entry, {bool isDirty = true}) async {
    await _db.into(_db.weightEntries).insertOnConflictUpdate(
          weightEntryToCompanion(entry, isDirty: isDirty),
        );
  }

  @override
  Future<void> markSynced(String uid, List<String> ids) async {
    await (_db.update(_db.weightEntries)
          ..where((tbl) => tbl.uid.equals(uid) & tbl.id.isIn(ids)))
        .write(const WeightEntriesCompanion(isDirty: Value(false)));
  }

  @override
  Future<void> softDelete(String uid, String id) async {
    await (_db.update(_db.weightEntries)
          ..where((tbl) => tbl.uid.equals(uid) & tbl.id.equals(id)))
        .write(
      WeightEntriesCompanion(
        isDeleted: const Value(true),
        isDirty: const Value(true),
        lastUpdatedAt: Value(DateTime.now().toUtc().millisecondsSinceEpoch),
      ),
    );
  }

  @override
  Future<void> hardDeleteAll(String uid) async {
    await (_db.delete(_db.weightEntries)..where((tbl) => tbl.uid.equals(uid))).go();
  }
}
