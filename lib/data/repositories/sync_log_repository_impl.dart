import 'package:drift/drift.dart';
import 'package:weightvault/data/db/app_database.dart';
import 'package:weightvault/data/repositories/mappers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/repositories/repositories.dart';
class DriftSyncLogRepository implements SyncLogRepository {
  DriftSyncLogRepository(this._db);

  final AppDatabase _db;

  @override
  Future<void> addLog(SyncLog log) async {
    await _db.into(_db.syncLogs).insert(syncLogToCompanion(log));
  }

  @override
  Stream<List<SyncLog>> watchAll(String uid) {
    final query = _db.select(_db.syncLogs)
      ..where((tbl) => tbl.uid.equals(uid))
      ..orderBy([
        (tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map((row) => row.toDomain()).toList());
  }

  @override
  Future<void> deleteAll(String uid) async {
    await (_db.delete(_db.syncLogs)..where((tbl) => tbl.uid.equals(uid))).go();
  }
}
