import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_reminder/core/utils/time_service.dart';
import 'package:water_reminder/features/hydration/domain/intake_log.dart';
import 'package:water_reminder/core/logger/logger.dart';

final _logger = LoggerFactory.getLogger('IntakeLogRepository');

/// Repository for managing water intake logs with Hive persistence
class IntakeLogRepository {
  static const String _boxName = 'intake_logs';
  
  final TimeService _timeService;

  IntakeLogRepository(this._timeService);

  /// Get all logs for today based on dayStartHour
  Future<List<IntakeLog>> getTodayLogs() async {
    final box = await Hive.openBox<Map>(_boxName);
    final range = _timeService.getTodayRange();
    
    final logs = <IntakeLog>[];
    for (var i = 0; i < box.length; i++) {
      try {
        final json = box.getAt(i);
        if (json != null) {
          final log = IntakeLog.fromJson(Map<String, dynamic>.from(json));
          final logTime = log.timestampUtc.toLocal();
          
          if (logTime.isAfter(range.start) && logTime.isBefore(range.end)) {
            logs.add(log);
          }
        }
      } catch (e) {
        _logger.warning('Failed to parse log at index $i: $e');
      }
    }
    
    // Sort by timestamp descending (newest first)
    logs.sort((a, b) => b.timestampUtc.compareTo(a.timestampUtc));
    return logs;
  }

  /// Get logs in a specific date range
  Future<List<IntakeLog>> getLogsInRange(DateTime start, DateTime end) async {
    final box = await Hive.openBox<Map>(_boxName);
    final startUtc = start.toUtc();
    final endUtc = end.toUtc();
    
    final logs = <IntakeLog>[];
    for (var i = 0; i < box.length; i++) {
      try {
        final json = box.getAt(i);
        if (json != null) {
          final log = IntakeLog.fromJson(Map<String, dynamic>.from(json));
          
          if (log.timestampUtc.isAfter(startUtc) && 
              log.timestampUtc.isBefore(endUtc)) {
            logs.add(log);
          }
        }
      } catch (e) {
        _logger.warning('Failed to parse log at index $i: $e');
      }
    }
    
    logs.sort((a, b) => b.timestampUtc.compareTo(a.timestampUtc));
    return logs;
  }

  /// Add a new log
  Future<void> addLog(IntakeLog log) async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.add(log.toJson());
    _logger.info('Added log: ${log.amountMl}ml at ${log.timestampUtc}');
  }

  /// Update an existing log by ID
  Future<void> updateLog(String id, IntakeLog updatedLog) async {
    final box = await Hive.openBox<Map>(_boxName);
    
    for (var i = 0; i < box.length; i++) {
      final json = box.getAt(i);
      if (json != null) {
        final log = IntakeLog.fromJson(Map<String, dynamic>.from(json));
        if (log.id == id) {
          await box.putAt(i, updatedLog.toJson());
          _logger.info('Updated log $id: ${updatedLog.amountMl}ml');
          return;
        }
      }
    }
    
    _logger.warning('Log with id $id not found for update');
  }

  /// Delete a log by ID
  Future<void> deleteLog(String id) async {
    final box = await Hive.openBox<Map>(_boxName);
    
    for (var i = 0; i < box.length; i++) {
      final json = box.getAt(i);
      if (json != null) {
        final log = IntakeLog.fromJson(Map<String, dynamic>.from(json));
        if (log.id == id) {
          await box.deleteAt(i);
          _logger.info('Deleted log $id');
          return;
        }
      }
    }
    
    _logger.warning('Log with id $id not found for deletion');
  }

  /// Get the last log (most recent)
  Future<IntakeLog?> getLastLog() async {
    final box = await Hive.openBox<Map>(_boxName);
    
    if (box.isEmpty) return null;
    
    IntakeLog? lastLog;
    DateTime? lastTimestamp;
    
    for (var i = 0; i < box.length; i++) {
      try {
        final json = box.getAt(i);
        if (json != null) {
          final log = IntakeLog.fromJson(Map<String, dynamic>.from(json));
          
          if (lastTimestamp == null || log.timestampUtc.isAfter(lastTimestamp)) {
            lastLog = log;
            lastTimestamp = log.timestampUtc;
          }
        }
      } catch (e) {
        _logger.warning('Failed to parse log at index $i: $e');
      }
    }
    
    return lastLog;
  }

  /// Calculate today's total EFFECTIVE hydration in ml
  /// Takes into account beverage type multipliers
  Future<int> getTodayTotal() async {
    final logs = await getTodayLogs();
    return logs.fold<int>(0, (sum, log) => sum + log.effectiveHydrationMl);
  }

  /// Get all logs (for stats/history)
  Future<List<IntakeLog>> getAllLogs() async {
    final box = await Hive.openBox<Map>(_boxName);
    
    final logs = <IntakeLog>[];
    for (var i = 0; i < box.length; i++) {
      try {
        final json = box.getAt(i);
        if (json != null) {
          logs.add(IntakeLog.fromJson(Map<String, dynamic>.from(json)));
        }
      } catch (e) {
        _logger.warning('Failed to parse log at index $i: $e');
      }
    }
    
    logs.sort((a, b) => b.timestampUtc.compareTo(a.timestampUtc));
    return logs;
  }

  /// Clear all logs (for testing/reset)
  Future<void> clearAllLogs() async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.clear();
    _logger.info('Cleared all logs');
  }
}
