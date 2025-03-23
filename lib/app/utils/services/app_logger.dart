import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';


class AppLogger {
  static final Map<String, Logger> _loggers = {};

  static void init() {
    Logger.root.level = kDebugMode ? Level.ALL : Level.WARNING;

    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        print('${record.time} [${record.level.name}] ${record.loggerName}: ${record.message}');
        if (record.error != null) {
          print('ERROR: ${record.error}');
        }

        if (record.stackTrace != null) {
          print('STACK: ${record.stackTrace}');
        }
      }
    });
  }

  static Logger getLogger(String name) {
    if (!_loggers.containsKey(name)) {
      _loggers[name] = Logger(name);
    }
    return _loggers[name]!;
  }

  static void fine(String loggerName, String message) {
    getLogger(loggerName).fine(message);
  }

  static void info(String loggerName, String message) {
    getLogger(loggerName).info(message);
  }

  static void warning(String loggerName, String message, [Object? error, StackTrace? stackTrace]) {
    getLogger(loggerName).warning(message, error, stackTrace);
  }

  static void severe(String loggerName, String message, [Object? error, StackTrace? stackTrace]) {
    getLogger(loggerName).severe(message, error, stackTrace);
  }

  static void debug(String loggerName, String message) {
    if (kDebugMode) {
      getLogger(loggerName).fine(message);
    }
  }
}