import 'package:flutter/foundation.dart';

import '../services/crash_reporter.dart';

class AppLogger {
  const AppLogger._();

  static void d(String message) {
    if (kDebugMode) {
      debugPrint('[DEBUG] $message');
    }
  }

  static void i(String message) {
    if (kDebugMode) {
      debugPrint('[INFO] $message');
    }
  }

  static void w(String message) {
    if (kDebugMode) {
      debugPrint('[WARN] $message');
    }
  }

  /// Prints in debug builds and reports to Crashlytics in release builds.
  /// [fatal] marks an error that escaped every handler.
  static void e(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    bool fatal = false,
  }) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
    }
    CrashReporter.recordError(
      error ?? message,
      stackTrace,
      reason: message,
      fatal: fatal,
    );
  }
}
