import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/explore/data/models/public_deposit_policy_model.dart';
import 'package:mal3abk/features/explore/presentation/widgets/venue_policies_tab_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _buildTestApp(PublicDepositPolicyModel? policy) => EasyLocalization(
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
          child: VenuePoliciesTabWidget(policy: policy),
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

  testWidgets('renders policies tab correctly', (tester) async {
    // 1. Null policy fallback
    await _pump(tester, _buildTestApp(null));
    expect(
      find.text('الملعب بيطبّق السياسة الافتراضية للحجز والإلغاء.'),
      findsOneWidget,
    );

    // 2. Concrete policy with custom terms
    const policy = PublicDepositPolicyModel(
      depositType: 'FixedAmount',
      depositValue: 50,
      proofSubmissionWindowMinutes: 15,
      cancellationDeadlineHours: 6,
      refundEligibility: 'FullRefund',
      refundPercentage: 100,
      noShowRule: 'ForfeitDeposit',
      lateArrivalGraceMinutes: 15,
      allowReschedule: true,
      rescheduleDeadlineHours: 24,
      terms: 'برجاء ارتداء الحذاء الرياضي المناسب للأرضية النجيل الصناعي.',
    );

    await _pump(tester, _buildTestApp(policy));

    // Policy title
    expect(find.text('شروط الحجز والإلغاء'), findsOneWidget);

    // Items
    expect(find.text('العربون ٥٠ ج.م'), findsOneWidget);
    expect(find.text('ترفع إيصال التحويل خلال ١٥ دقيقة'), findsOneWidget);
    expect(
      find.text('استرداد كامل للعربون لو لغيت قبل الميعاد بـ ٦ ساعة'),
      findsOneWidget,
    );
    expect(find.text('مسموح بالتأخير ١٥ دقيقة'), findsOneWidget);
    expect(find.text('لو ماحضرتش بتخسر العربون'), findsOneWidget);
    expect(find.text('تقدر تغيّر الميعاد قبله بـ ٢٤ ساعة'), findsOneWidget);

    // Terms
    expect(
      find.text('برجاء ارتداء الحذاء الرياضي المناسب للأرضية النجيل الصناعي.'),
      findsOneWidget,
    );

    // Icons
    expect(find.byIcon(Icons.shield_outlined), findsOneWidget);
    expect(find.byIcon(Icons.payments_outlined), findsOneWidget);
    expect(find.byIcon(Icons.timer_outlined), findsOneWidget);
    expect(find.byIcon(Icons.published_with_changes_rounded), findsOneWidget);
    expect(find.byIcon(Icons.schedule_rounded), findsOneWidget);
    expect(find.byIcon(Icons.person_off_outlined), findsOneWidget);
    expect(find.byIcon(Icons.edit_calendar_rounded), findsOneWidget);
    expect(find.byIcon(Icons.info_outline_rounded), findsOneWidget);
  });
}
