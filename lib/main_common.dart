import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/config/env_config.dart';
import 'core/di/service_locator.dart';
import 'core/services/push_notification_service.dart';
import 'core/utils/cairo_time.dart';
import 'mal3abk_app.dart';

Future<void> mainCommon(EnvConfig envConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  CairoTime.initialize();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase.initializeApp() note: $e');
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await EasyLocalization.ensureInitialized();
  await setupServiceLocator(envConfig);

  try {
    await sl<PushNotificationService>().initialize();
  } catch (e) {
    debugPrint('PushNotificationService initialize note: $e');
  }

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
