import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:water_reminder/core/logger/logger.dart';
import 'package:water_reminder/core/result/result.dart';
import 'package:water_reminder/core/errors/app_error.dart';

final _logger = LoggerFactory.getLogger('ExportRestoreService');

/// Current schema version for backup data
const int currentSchemaVersion = 1;

/// Service for exporting and restoring app data
class ExportRestoreService {
  /// Exports all app data to a JSON file and shares it
  Future<Result<String>> exportData() async {
    try {
      _logger.info('Starting data export');

      // Collect all data from Hive boxes
      final exportData = await _collectAllData();

      // Convert to JSON
      final jsonString = const JsonEncoder.withIndent('  ').convert(exportData);

      // Write to temporary file
      final directory = await getApplicationDocumentsDirectory();
      final timestamp =
          DateTime.now().toIso8601String().replaceAll(':', '-').split('.')[0];
      final fileName = 'water_reminder_backup_$timestamp.json';
      final file = File('${directory.path}/$fileName');

      await file.writeAsString(jsonString);

      _logger.info('Data exported to: ${file.path}');

      // Share the file
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Su Hatirlatici Yedegi',
        text:
            'Yedek icerigi: profil, ayarlar, bardaklar, kayitlar, hatirlaticilar ve rozetler',
      );

      return Success('Disa aktarma basarili: $fileName');
    } catch (e, stackTrace) {
      _logger.error('Export failed', e, stackTrace);
      return Failure(
        UnexpectedError('Veri disa aktarilamadi: ${e.toString()}'),
      );
    }
  }

  /// Collects all data from Hive boxes
  Future<Map<String, dynamic>> _collectAllData() async {
    final data = <String, dynamic>{
      'schemaVersion': currentSchemaVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'data': <String, dynamic>{},
    };

    // User profile
    try {
      final profileBox = await Hive.openBox('user_profile');
      final profile = profileBox.get('profile');
      if (profile != null) {
        data['data']['userProfile'] = profile;
      }
    } catch (e) {
      _logger.warning('Could not export user profile: $e');
    }

    // App state
    try {
      final appStateBox = await Hive.openBox('app_state');
      data['data']['appState'] = appStateBox.toMap();
    } catch (e) {
      _logger.warning('Could not export app state: $e');
    }

    // Intake logs
    try {
      final logsBox = await Hive.openBox('intake_logs');
      data['data']['intakeLogs'] = logsBox.values.toList();
    } catch (e) {
      _logger.warning('Could not export intake logs: $e');
    }

    // Achievements
    try {
      final achievementsBox = await Hive.openBox('achievements');
      data['data']['achievements'] = achievementsBox.values.toList();
    } catch (e) {
      _logger.warning('Could not export achievements: $e');
    }

    // Reminders (future)
    try {
      final remindersBox = await Hive.openBox('reminders');
      data['data']['reminders'] = remindersBox.values.toList();
    } catch (e) {
      _logger.warning('Could not export reminders: $e');
    }

    return data;
  }

  /// Imports data from a JSON backup file
  Future<Result<String>> importData() async {
    try {
      _logger.info('Starting data import');

      // Pick file
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.isEmpty) {
        return Failure(
          ValidationError('Dosya secilmedi'),
        );
      }

      final filePath = result.files.first.path;
      if (filePath == null) {
        return Failure(
          ValidationError('Gecersiz dosya yolu'),
        );
      }

      // Read file
      final file = File(filePath);
      final jsonString = await file.readAsString();

      // Parse JSON
      final Map<String, dynamic> importData;
      try {
        importData = json.decode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        return Failure(
          ValidationError('Gecersiz JSON formati: ${e.toString()}'),
        );
      }

      // Validate schema
      final validationResult = validateBackup(importData);
      if (validationResult.isFailure) {
        return Failure(validationResult.error);
      }

      // Migrate if needed
      final migratedData = await migrateData(importData);

      // Restore data to Hive
      await _restoreData(migratedData);

      _logger.info('Data import completed successfully');

      return Success('Ice aktarma basarili. Lutfen uygulamayi yeniden baslatin.');
    } catch (e, stackTrace) {
      _logger.error('Import failed', e, stackTrace);
      return Failure(
        UnexpectedError('Veri ice aktarilamadi: ${e.toString()}'),
      );
    }
  }

  /// Validates backup data structure and schema version
  @visibleForTesting
  Result<void> validateBackup(Map<String, dynamic> data) {
    // Check required fields
    if (!data.containsKey('schemaVersion')) {
      return Failure(
        ValidationError(
            'Sema surumu eksik. Bu gecerli bir yedek olmayabilir.'),
      );
    }

    if (!data.containsKey('data')) {
      return Failure(
        ValidationError(
            'Veri bolumu eksik. Bu gecerli bir yedek olmayabilir.'),
      );
    }

    // Check schema version
    final schemaVersionValue = data['schemaVersion'];
    if (schemaVersionValue is! int) {
      return Failure(
        ValidationError('Gecersiz sema surumu'),
      );
    }
    final schemaVersion = schemaVersionValue;

    if (schemaVersion > currentSchemaVersion) {
      return Failure(
        ValidationError(
          'Yedek daha yeni bir surumden (sema v$schemaVersion). '
          'Bu yedegi geri yuklemek icin uygulamayi guncelleyin.',
        ),
      );
    }

    return Success(null);
  }

  /// Migrates data from older schema versions to current
  @visibleForTesting
  Future<Map<String, dynamic>> migrateData(Map<String, dynamic> data) async {
    final schemaVersion = data['schemaVersion'] as int;

    if (schemaVersion == currentSchemaVersion) {
      // No migration needed
      return data;
    }

    _logger.info(
        'Migrating data from schema v$schemaVersion to v$currentSchemaVersion');

    var migratedData = Map<String, dynamic>.from(data);

    // Apply migrations sequentially
    for (var version = schemaVersion;
        version < currentSchemaVersion;
        version++) {
      migratedData = await _applyMigration(migratedData, version, version + 1);
    }

    migratedData['schemaVersion'] = currentSchemaVersion;
    return migratedData;
  }

  /// Applies a single migration from one version to the next
  Future<Map<String, dynamic>> _applyMigration(
    Map<String, dynamic> data,
    int fromVersion,
    int toVersion,
  ) async {
    _logger.info('Applying migration: v$fromVersion -> v$toVersion');

    // Example migration logic (add more as schema evolves)
    switch (fromVersion) {
      case 0: // Hypothetical: v0 -> v1
        // Add new fields, transform data, etc.
        final migratedData = Map<String, dynamic>.from(data);
        // Migration logic here
        return migratedData;

      default:
        // No migration defined, return as-is
        return data;
    }
  }

  /// Restores data to Hive boxes
  Future<void> _restoreData(Map<String, dynamic> importData) async {
    final data = importData['data'] as Map<String, dynamic>;

    // Restore user profile
    if (data.containsKey('userProfile')) {
      final profileBox = await Hive.openBox('user_profile');
      await profileBox.put('profile', data['userProfile']);
      _logger.info('Restored user profile');
    }

    // Restore app state
    if (data.containsKey('appState')) {
      final appStateBox = await Hive.openBox('app_state');
      await appStateBox.clear();
      final appState = data['appState'] as Map<dynamic, dynamic>;
      for (final entry in appState.entries) {
        await appStateBox.put(entry.key, entry.value);
      }
      _logger.info('Restored app state');
    }

    // Restore intake logs
    if (data.containsKey('intakeLogs')) {
      final logsBox = await Hive.openBox('intake_logs');
      await logsBox.clear();
      final logs = data['intakeLogs'] as List;
      for (var i = 0; i < logs.length; i++) {
        await logsBox.add(logs[i]);
      }
      _logger.info('Restored ${logs.length} intake logs');
    }

    // Restore achievements
    if (data.containsKey('achievements')) {
      final achievementsBox = await Hive.openBox('achievements');
      await achievementsBox.clear();
      final achievements = data['achievements'] as List;
      for (var i = 0; i < achievements.length; i++) {
        await achievementsBox.add(achievements[i]);
      }
      _logger.info('Restored ${achievements.length} achievements');
    }

    // Restore reminders
    if (data.containsKey('reminders')) {
      final remindersBox = await Hive.openBox('reminders');
      await remindersBox.clear();
      final reminders = data['reminders'] as List;
      for (var i = 0; i < reminders.length; i++) {
        await remindersBox.add(reminders[i]);
      }
      _logger.info('Restored ${reminders.length} reminders');
    }
  }

  /// Gets a summary of what's in a backup file without importing
  Future<Result<BackupSummary>> getBackupSummary(String filePath) async {
    try {
      final file = File(filePath);
      final jsonString = await file.readAsString();
      final data = json.decode(jsonString) as Map<String, dynamic>;

      final schemaVersion = data['schemaVersion'] as int?;
      final exportedAt = data['exportedAt'] as String?;
      final backupData = data['data'] as Map<String, dynamic>?;

      final summary = BackupSummary(
        schemaVersion: schemaVersion ?? 0,
        exportedAt: exportedAt != null ? DateTime.parse(exportedAt) : null,
        hasProfile: backupData?.containsKey('userProfile') ?? false,
        hasSettings: backupData?.containsKey('appState') ?? false,
        logCount: (backupData?['intakeLogs'] as List?)?.length ?? 0,
        achievementCount: (backupData?['achievements'] as List?)?.length ?? 0,
        reminderCount: (backupData?['reminders'] as List?)?.length ?? 0,
      );

      return Success(summary);
    } catch (e) {
      return Failure(
        ValidationError('Yedek dosya okunamadi: ${e.toString()}'),
      );
    }
  }
}

/// Summary of backup contents
class BackupSummary {
  const BackupSummary({
    required this.schemaVersion,
    required this.exportedAt,
    required this.hasProfile,
    required this.hasSettings,
    required this.logCount,
    required this.achievementCount,
    required this.reminderCount,
  });

  final int schemaVersion;
  final DateTime? exportedAt;
  final bool hasProfile;
  final bool hasSettings;
  final int logCount;
  final int achievementCount;
  final int reminderCount;

  String get description {
    final parts = <String>[];
    if (hasProfile) parts.add('profil');
    if (hasSettings) parts.add('ayarlar');
    if (logCount > 0) parts.add('$logCount kayit');
    if (achievementCount > 0) parts.add('$achievementCount rozet');
    if (reminderCount > 0) parts.add('$reminderCount hatirlatici');
    return 'Yedek icerigi: ${parts.join(', ')}';
  }
}
