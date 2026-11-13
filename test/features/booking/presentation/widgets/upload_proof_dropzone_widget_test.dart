import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mal3abk/features/booking/presentation/widgets/upload_proof_dropzone_widget.dart';
import 'package:mal3abk/features/booking/presentation/widgets/upload_proof_empty_dropzone_widget.dart';
import 'package:mal3abk/features/booking/presentation/widgets/upload_proof_ready_receipt_widget.dart';

Widget _app(Uint8List? bytes, VoidCallback onTap) => EasyLocalization(
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
      home: Scaffold(
        body: UploadProofDropzoneWidget(fileBytes: bytes, onTap: onTap),
      ),
    ),
  ),
);

/// easy_localization loads its translations asynchronously, so real time has to pass before the screen appears.
Future<void> _pump(WidgetTester tester, Widget app) async {
  // The box is sized for a phone; the default test screen is smaller.
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(app);
  for (var i = 0; i < 20 && find.byType(Scaffold).evaluate().isEmpty; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 50)),
    );
    await tester.pump(const Duration(milliseconds: 50));
  }
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  final photo = Uint8List.fromList(
    img.encodePng(img.Image(width: 20, height: 20)),
  );

  // One test for the whole life of the box: easy_localization keeps global state, so separate tests would race it.
  testWidgets(
    'invites a photo, shows the chosen photo as ready, and picks again on tap',
    (tester) async {
      var taps = 0;
      await _pump(tester, _app(null, () => taps++));

      expect(find.byType(UploadProofEmptyDropzoneWidget), findsOneWidget);
      expect(find.byType(UploadProofReadyReceiptWidget), findsNothing);

      await tester.pumpWidget(_app(photo, () => taps++));
      await tester.pumpAndSettle();

      expect(find.byType(UploadProofReadyReceiptWidget), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(UploadProofEmptyDropzoneWidget), findsNothing);

      await tester.tap(find.byType(UploadProofReadyReceiptWidget));
      expect(taps, 1);

      await tester.pumpWidget(_app(null, () => taps++));
      await tester.pumpAndSettle();
      expect(find.byType(UploadProofEmptyDropzoneWidget), findsOneWidget);
    },
  );
}
