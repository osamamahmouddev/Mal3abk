import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/env_config.dart';
import 'core/di/service_locator.dart';
import 'core/services/crash_reporter.dart';
import 'core/services/push_notification_service.dart';
import 'core/styles/app_colors.dart';
import 'core/utils/app_bloc_observer.dart';
import 'core/utils/app_logger.dart';
import 'core/utils/cairo_time.dart';
import 'mal3abk_app.dart';

Future<void> mainCommon(EnvConfig envConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  CairoTime.initialize();

  // A release build must never send tokens, phone numbers or OTP codes in
  // clear text. Fail at startup instead of shipping an insecure build.
  if (!envConfig.isDebug && !envConfig.baseUrl.startsWith('https://')) {
    throw StateError('Release builds need an HTTPS API address.');
  }

  // Global uncaught error hooks: printed in debug, sent to Crashlytics in
  // release.
  Bloc.observer = const AppBlocObserver();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    CrashReporter.recordFlutterError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.e('Uncaught error', error: error, stackTrace: stack, fatal: true);
    return true;
  };

  if (!envConfig.isDebug) {
    ErrorWidget.builder = (details) {
      var message = 'common.unexpected_error';
      try {
        message = message.tr();
      } catch (_) {
        // Translations not loaded yet: the key is still better than a crash.
      }
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: AppColors.brandRed,
                  size: 36,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 8),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    // No ScreenUtil here: this must render even when the
                    // failure happened before it was set up.
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    };
  }

  try {
    await Firebase.initializeApp();
  } on Exception catch (e) {
    AppLogger.w('Firebase is not available: ${e.runtimeType}');
  }
  await CrashReporter.initialize(enabled: !envConfig.isDebug && !kDebugMode);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await EasyLocalization.ensureInitialized();
  await setupServiceLocator(envConfig);

  // Push setup asks for permission and talks to the network; it must not
  // hold the first frame back. It reports its own failures.
  unawaited(sl<PushNotificationService>().initialize());

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      child: const Mal3abkApp(),
    ),
  );
}
