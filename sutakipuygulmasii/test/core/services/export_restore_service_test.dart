import 'package:flutter_test/flutter_test.dart';
import 'package:water_reminder/core/errors/app_error.dart';
import 'package:water_reminder/core/result/result.dart';
import 'package:water_reminder/core/services/export_restore_service.dart';

void main() {
  group('ExportRestoreService - Schema Versioning', () {
    late ExportRestoreService service;

    setUp(() {
      service = ExportRestoreService();
    });

    group('validateBackup', () {
      test('accepts valid backup with current schema version', () {
        final backup = {
          'schemaVersion': currentSchemaVersion,
          'data': {},
        };

        final result = service.validateBackup(backup);

        expect(result.isSuccess, true);
      });

      test('accepts valid backup with older schema version', () {
        final backup = {
          'schemaVersion': currentSchemaVersion - 1,
          'data': {},
        };

        final result = service.validateBackup(backup);

        expect(result.isSuccess, true);
      });

      test('rejects backup with newer schema version', () {
        final backup = {
          'schemaVersion': currentSchemaVersion + 1,
          'data': {},
        };

        final result = service.validateBackup(backup);

        expect(result.isFailure, true);
        final error = result.errorOrNull as AppError?;
        expect(
          error?.message,
          contains('newer version'),
        );
      });

      test('rejects backup without schema version', () {
        final backup = {
          'data': {},
        };

        final result = service.validateBackup(backup);

        expect(result.isFailure, true);
        final error = result.errorOrNull as AppError?;
        expect(
          error?.message,
          contains('Missing schema version'),
        );
      });

      test('rejects backup without data section', () {
        final backup = {
          'schemaVersion': currentSchemaVersion,
        };

        final result = service.validateBackup(backup);

        expect(result.isFailure, true);
        final error = result.errorOrNull as AppError?;
        expect(
          error?.message,
          contains('Missing data section'),
        );
      });

      test('rejects backup with invalid schema version type', () {
        final backup = {
          'schemaVersion': 'invalid',
          'data': {},
        };

        final result = service.validateBackup(backup);

        expect(result.isFailure, true);
      });
    });

    group('Schema Migration', () {
      test('no migration needed for current schema version', () async {
        final backup = {
          'schemaVersion': currentSchemaVersion,
          'exportedAt': DateTime.now().toIso8601String(),
          'data': {'test': 'value'},
        };

        final migrated = await service.migrateData(backup);

        expect(migrated['schemaVersion'], currentSchemaVersion);
        expect(migrated['data'], equals(backup['data']));
      });

      test('updates schema version after migration', () async {
        final oldVersion = currentSchemaVersion - 1;
        final backup = {
          'schemaVersion': oldVersion,
          'exportedAt': DateTime.now().toIso8601String(),
          'data': {'test': 'value'},
        };

        final migrated = await service.migrateData(backup);

        expect(migrated['schemaVersion'], currentSchemaVersion);
      });

      test('applies migrations sequentially', () async {
        // Test that migration can handle multiple version jumps
        final oldVersion = 0; // Hypothetical old version
        final backup = {
          'schemaVersion': oldVersion,
          'exportedAt': DateTime.now().toIso8601String(),
          'data': {'test': 'value'},
        };

        final migrated = await service.migrateData(backup);

        expect(migrated['schemaVersion'], currentSchemaVersion);
      });
    });

    group('BackupSummary', () {
      test('generates correct description for full backup', () {
        final summary = BackupSummary(
          schemaVersion: 1,
          exportedAt: DateTime.now(),
          hasProfile: true,
          hasSettings: true,
          logCount: 50,
          achievementCount: 3,
          reminderCount: 2,
        );

        expect(summary.description, contains('profile'));
        expect(summary.description, contains('settings'));
        expect(summary.description, contains('50 logs'));
        expect(summary.description, contains('3 achievements'));
        expect(summary.description, contains('2 reminders'));
      });

      test('generates correct description for partial backup', () {
        final summary = BackupSummary(
          schemaVersion: 1,
          exportedAt: DateTime.now(),
          hasProfile: true,
          hasSettings: false,
          logCount: 0,
          achievementCount: 0,
          reminderCount: 0,
        );

        expect(summary.description, contains('profile'));
        expect(summary.description, isNot(contains('settings')));
        expect(summary.description, isNot(contains('logs')));
      });

      test('handles empty backup', () {
        final summary = BackupSummary(
          schemaVersion: 1,
          exportedAt: DateTime.now(),
          hasProfile: false,
          hasSettings: false,
          logCount: 0,
          achievementCount: 0,
          reminderCount: 0,
        );

        expect(summary.description, equals('Backup contains: '));
      });
    });
  });
}
