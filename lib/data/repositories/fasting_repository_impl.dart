import 'package:drift/drift.dart';
import 'package:weightvault/data/db/app_database.dart';
import 'package:weightvault/data/repositories/mappers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/repositories/repositories.dart';

class DriftFastingRepository implements FastingRepository {
  DriftFastingRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<FastingSession>> watchAll(String uid) {
    final query = _db.select(_db.fastingSessions)
      ..where((tbl) => tbl.uid.equals(uid) & tbl.isDeleted.equals(false))
      ..orderBy([
        (tbl) => OrderingTerm(expression: tbl.start, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map((row) => row.toDomain()).toList());
  }

  @override
  Future<FastingSession?> getActive(String uid) async {
    final query = _db.select(_db.fastingSessions)
      ..where(
        (tbl) =>
            tbl.uid.equals(uid) & tbl.isDeleted.equals(false) & tbl.end.isNull(),
      );
    final row = await query.getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Future<List<FastingSession>> getDirtyEntries(String uid) async {
    final query = _db.select(_db.fastingSessions)
      ..where((tbl) => tbl.uid.equals(uid) & tbl.isDirty.equals(true));
    final rows = await query.get();
    return rows.map((row) => row.toDomain()).toList();
  }

  @override
  Future<void> upsert(FastingSession session, {bool isDirty = true}) async {
    await _db.into(_db.fastingSessions).insertOnConflictUpdate(
          fastingSessionToCompanion(session, isDirty: isDirty),
        );
  }

  @override
  Future<void> markSynced(String uid, List<String> ids) async {
    await (_db.update(_db.fastingSessions)
          ..where((tbl) => tbl.uid.equals(uid) & tbl.id.isIn(ids)))
        .write(const FastingSessionsCompanion(isDirty: Value(false)));
  }

  @override
  Future<void> softDelete(String uid, String id) async {
    await (_db.update(_db.fastingSessions)
          ..where((tbl) => tbl.uid.equals(uid) & tbl.id.equals(id)))
        .write(
      FastingSessionsCompanion(
        isDeleted: const Value(true),
        isDirty: const Value(true),
        lastUpdatedAt: Value(DateTime.now().toUtc().millisecondsSinceEpoch),
      ),
    );
  }

  @override
  Future<void> hardDeleteAll(String uid) async {
    await (_db.delete(_db.fastingSessions)..where((tbl) => tbl.uid.equals(uid))).go();
  }
}
