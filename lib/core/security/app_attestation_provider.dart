import 'dart:async';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../config/env_config.dart';
import '../utils/app_logger.dart';

/// Proves to the API that a request comes from the genuine app on a genuine
/// device, through Firebase App Check: Play Integrity on Android, App Attest
/// (DeviceCheck fallback) on iOS. The token goes in [headerName]; the API
/// decides whether to enforce it.
class AppAttestationProvider {
  AppAttestationProvider({required this.envConfig, this.readToken});

  static const String headerName = 'X-Firebase-AppCheck';
  static const String devToken = 'dev-app-integrity-token';

  /// A token request never holds a call back longer than this.
  static const Duration timeout = Duration(seconds: 3);

  final EnvConfig envConfig;

  /// Overrides the App Check token source (tests).
  final Future<String?> Function()? readToken;

  bool _activated = false;

  /// Starts App Check for the prod flavor. The dev flavor keeps [devToken].
  /// Debug builds use the debug providers: their token must be added in the
  /// Firebase console to pass.
  Future<void> activate() async {
    if (envConfig.isDebug || Firebase.apps.isEmpty) return;
    try {
      await FirebaseAppCheck.instance.activate(
        providerAndroid: kDebugMode
            ? const AndroidDebugProvider()
            : const AndroidPlayIntegrityProvider(),
        providerApple: kDebugMode
            ? const AppleDebugProvider()
            : const AppleAppAttestWithDeviceCheckFallbackProvider(),
      );
      _activated = true;
    } catch (error, stackTrace) {
      AppLogger.e(
        'App Check activation failed',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// The current token, or null when App Check is off or unavailable. It
  /// never throws: a missing token must not block the request.
  Future<String?> getAttestationToken() async {
    if (envConfig.isDebug) return devToken;
    final source =
        readToken ??
        (_activated ? () => FirebaseAppCheck.instance.getToken() : null);
    if (source == null) return null;
    try {
      final token = await source().timeout(timeout);
      return token == null || token.isEmpty ? null : token;
    } catch (_) {
      return null;
    }
  }
}
