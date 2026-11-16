import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Sends errors to Firebase Crashlytics. It stays off until [initialize]
/// turns it on (release builds of the prod flavor), so debug runs and tests
/// never report anything.
///
/// Network errors are reduced to their type, status, method and path: no
/// tokens, phone numbers, OTP codes, bodies or query strings leave the phone.
class CrashReporter {
  const CrashReporter._();

  static bool _enabled = false;

  static bool get isEnabled => _enabled;

  static Future<void> initialize({required bool enabled}) async {
    if (Firebase.apps.isEmpty) return;
    try {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
        enabled,
      );
      _enabled = enabled;
    } catch (_) {
      _enabled = false;
    }
  }

  static void recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
  }) {
    if (!_enabled) return;
    FirebaseCrashlytics.instance
        .recordError(redact(error), stackTrace, reason: reason, fatal: fatal)
        .ignore();
  }

  static void recordFlutterError(FlutterErrorDetails details) {
    if (!_enabled) return;
    FirebaseCrashlytics.instance.recordFlutterError(details).ignore();
  }

  @visibleForTesting
  static Object redact(Object error) {
    if (error is DioException) {
      final options = error.requestOptions;
      return 'DioException(${error.type.name}, '
          '${error.response?.statusCode}, '
          '${options.method} ${options.uri.path})';
    }
    return error;
  }
}
