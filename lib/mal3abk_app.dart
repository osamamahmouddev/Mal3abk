import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'core/app/app_locale.dart';
import 'core/routes/app_router.dart';
import 'core/routes/navigation_logger_observer.dart';
import 'core/routes/routes.dart';
import 'core/theme/app_theme.dart';

class Mal3abkApp extends StatelessWidget {
  const Mal3abkApp({super.key});

  static final NavigationLoggerObserver _navigationLoggerObserver =
      NavigationLoggerObserver();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    AppLocale.update(context.locale.languageCode);

    return ScreenUtilPlusInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'app.name'.tr(),
        theme: AppTheme.light,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
        navigatorObservers: [_navigationLoggerObserver],
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
      ),
    );
  }
}
