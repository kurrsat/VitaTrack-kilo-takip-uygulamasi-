import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:weightvault/data/db/converters.dart';
import 'package:weightvault/data/db/platform_db.dart';
import 'package:weightvault/data/db/tables.dart';
import 'package:weightvault/domain/models/models.dart';

part 'app_database.g.dart';
@DriftDatabase(
  tables: [
    UserProfiles,
    WeightEntries,
    MeasurementEntries,
    WaterEntries,
    FoodEntries,
    CustomFoods,
    FastingSessions,
    ActivityEntries,
    PhotoEntries,
    SyncLogs,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor, {this.encryptionKey});

  final String? encryptionKey;

  static Future<AppDatabase> open({String? encryptionKey}) async {
    return AppDatabase(
      await openConnection(encryptionKey: encryptionKey),
      encryptionKey: encryptionKey,
    );
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _createIndexes();
        },
        beforeOpen: (details) async {
          if (!kIsWeb && encryptionKey != null && encryptionKey!.isNotEmpty) {
            await customStatement("PRAGMA key = '${encryptionKey!}';");
          }
        },
      );

  Future<void> _createIndexes() async {
    await customStatement(
      'CREATE INDEX IF NOT EXISTS weight_entries_uid_date_idx ON weight_entries(uid, date_time)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS measurement_entries_uid_date_idx ON measurement_entries(uid, date_time)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS water_entries_uid_date_idx ON water_entries(uid, date)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS food_entries_uid_date_idx ON food_entries(uid, date_time)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS fasting_sessions_uid_date_idx ON fasting_sessions(uid, start)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS activity_entries_uid_date_idx ON activity_entries(uid, date_time)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS photo_entries_uid_date_idx ON photo_entries(uid, date)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS custom_foods_uid_name_idx ON custom_foods(uid, name_tr)',
    );
  }
}
