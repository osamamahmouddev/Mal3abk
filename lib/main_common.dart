import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/config/env_config.dart';
import 'core/di/service_locator.dart';
import 'core/utils/cairo_time.dart';
import 'mal3abk_app.dart';

Future<void> mainCommon(EnvConfig envConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  CairoTime.initialize();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await EasyLocalization.ensureInitialized();
  await setupServiceLocator(envConfig);

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
