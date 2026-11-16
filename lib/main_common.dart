import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/env_config.dart';
import 'core/di/service_locator.dart';
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

  // Global uncaught error hooks for production safety
  Bloc.observer = const AppBlocObserver();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    AppLogger.e('FlutterError', error: details.exception, stackTrace: details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.e('PlatformDispatcherError', error: error, stackTrace: stack);
    return true;
  };

  if (!envConfig.isDebug) {
    ErrorWidget.builder = (details) => const Material(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: AppColors.brandRed, size: 36),
              SizedBox(height: 8),
              Text(
                'حدث خطأ غير متوقع',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  try {
    await Firebase.initializeApp();
  } on Exception catch (e) {
    AppLogger.w('Firebase is not available: ${e.runtimeType}');
  }

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
