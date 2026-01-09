import 'package:flutter/foundation.dart';
class LoggerService {
  LoggerService({this.maxEntries = 200, bool? debugEnabled})
      : _debugEnabled = debugEnabled ?? !kReleaseMode;

  final int maxEntries;
  final bool _debugEnabled;
  final List<String> _entries = [];

  List<String> get entries => List.unmodifiable(_entries);

  void debug(String message) {
    if (_debugEnabled) {
      _log('DEBUG', message);
    }
  }

  void info(String message) {
    _log('INFO', message);
  }

  void error(String message, {Object? error}) {
    _log('ERROR', '$message${error != null ? ' | $error' : ''}');
  }

  void _log(String level, String message) {
    final entry = '${DateTime.now().toIso8601String()} [$level] $message';
    _entries.add(entry);
    if (_entries.length > maxEntries) {
      _entries.removeAt(0);
    }
    if (_debugEnabled) {
      debugPrint(entry);
    }
  }
}
