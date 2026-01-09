import 'dart:developer' as developer;

/// Logger levels
enum LogLevel {
  debug,
  info,
  warning,
  error,
  fatal,
}

/// Simple logger for the application
class Logger {
  Logger(this.name);

  final String name;

  void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.debug, message, error, stackTrace);
  }

  void info(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.info, message, error, stackTrace);
  }

  void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.warning, message, error, stackTrace);
  }

  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.error, message, error, stackTrace);
  }

  void fatal(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.fatal, message, error, stackTrace);
  }

  void _log(
    LogLevel level,
    String message,
    Object? error,
    StackTrace? stackTrace,
  ) {
    final timestamp = DateTime.now().toIso8601String();
    final levelStr = level.name.toUpperCase().padRight(7);
    final logMessage = '[$timestamp] $levelStr [$name] $message';

    developer.log(
      logMessage,
      name: name,
      error: error,
      stackTrace: stackTrace,
      level: _levelToInt(level),
    );
  }

  int _levelToInt(LogLevel level) => switch (level) {
        LogLevel.debug => 500,
        LogLevel.info => 800,
        LogLevel.warning => 900,
        LogLevel.error => 1000,
        LogLevel.fatal => 1200,
      };
}

/// Factory for creating loggers
class LoggerFactory {
  static final Map<String, Logger> _loggers = {};

  static Logger getLogger(String name) {
    return _loggers.putIfAbsent(name, () => Logger(name));
  }
}
