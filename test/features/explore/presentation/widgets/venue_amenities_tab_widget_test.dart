import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/explore/data/models/localized_item_model.dart';
import 'package:mal3abk/features/explore/presentation/widgets/venue_amenities_tab_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _buildTestApp(List<LocalizedItemModel> facilities) => EasyLocalization(
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
        body: SingleChildScrollView(
          child: VenueAmenitiesTabWidget(facilities: facilities),
        ),
      ),
    ),
  ),
);

Future<void> _pump(WidgetTester tester, Widget app) async {
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
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('renders amenities tab correctly', (tester) async {
    // 1. Empty state
    await _pump(tester, _buildTestApp([]));
    expect(find.text('الملعب ماضافش مرافق لسه.'), findsOneWidget);

    // 2. Facilities list
    final facilities = [
      const LocalizedItemModel(
        code: 'lighting',
        nameAr: 'إضاءة ليلية',
        nameEn: 'Floodlights',
      ),
      const LocalizedItemModel(
        code: 'parking',
        nameAr: 'موقف سيارات',
        nameEn: 'Parking',
      ),
      const LocalizedItemModel(
        code: 'wifi',
        nameAr: 'واي فاي',
        nameEn: 'Wi-Fi',
      ),
    ];

    await _pump(tester, _buildTestApp(facilities));

    // Summary banner
    expect(find.text('المرافق والخدمات'), findsOneWidget);
    expect(find.text('3 مرافق متوفرة بالمنشأة'), findsOneWidget);

    // Items in grid
    expect(find.text('إضاءة ليلية'), findsOneWidget);
    expect(find.text('موقف سيارات'), findsOneWidget);
    expect(find.text('واي فاي'), findsOneWidget);

    // Dedicated icons
    expect(find.byIcon(Icons.lightbulb_rounded), findsOneWidget);
    expect(find.byIcon(Icons.local_parking_rounded), findsOneWidget);
    expect(find.byIcon(Icons.wifi_rounded), findsOneWidget);
  });
}
