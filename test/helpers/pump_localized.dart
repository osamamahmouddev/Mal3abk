import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps [child] inside the app's Arabic localization and screen sizing, and
/// waits for the translations to load. Long Arabic rows overflow with the
/// test font (every glyph is a square), so only overflow errors are ignored.
Future<void> pumpLocalized(WidgetTester tester, Widget child) async {
  final reportError = FlutterError.onError;
  FlutterError.onError = (details) {
    if (!details.exceptionAsString().contains('overflowed')) {
      reportError?.call(details);
    }
  };
  addTearDown(() => FlutterError.onError = reportError);
  tester.view.physicalSize = const Size(390, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    EasyLocalization(
      supportedLocales: const [Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      useOnlyLangCode: true,
      child: ScreenUtilPlusInit(
        designSize: const Size(390, 844),
        builder: (context, _) => MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: Scaffold(body: child),
        ),
      ),
    ),
  );
  for (var i = 0; i < 20 && find.byWidget(child).evaluate().isEmpty; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 50)),
    );
    await tester.pump(const Duration(milliseconds: 50));
  }
  await tester.pumpAndSettle();
}
