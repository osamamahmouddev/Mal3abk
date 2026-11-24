import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mal3abk/core/location/location_service.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/routes/routes.dart';
import 'package:mal3abk/core/services/push_notification_service.dart';
import 'package:mal3abk/features/onboarding/presentation/cubit/onboarding_consent_cubit.dart';
import 'package:mal3abk/features/onboarding/presentation/screens/location_permission_screen.dart';
import 'package:mal3abk/features/onboarding/presentation/screens/notifications_permission_screen.dart';
import 'package:mal3abk/features/settings/data/models/consents_model.dart';
import 'package:mal3abk/features/settings/data/models/record_consent_request_body.dart';
import 'package:mal3abk/features/settings/domain/repos/account_repo.dart';

class MockAccountRepo extends Mock implements AccountRepo {}
class MockLocationService extends Mock implements LocationService {}
class MockPushNotificationService extends Mock implements PushNotificationService {}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    registerFallbackValue(ConsentType.location);
  });

  late MockAccountRepo mockRepo;
  late MockLocationService mockLocation;
  late MockPushNotificationService mockPush;
  late OnboardingConsentCubit cubit;

  setUp(() {
    mockRepo = MockAccountRepo();
    mockLocation = MockLocationService();
    mockPush = MockPushNotificationService();
    cubit = OnboardingConsentCubit(
      accountRepo: mockRepo,
      locationService: mockLocation,
      pushNotificationService: mockPush,
    );

    when(() => mockRepo.recordConsent(any(), granted: any(named: 'granted')))
        .thenAnswer((_) async => const ApiResult.success(ConsentsModel()));
  });

  tearDown(() {
    cubit.close();
  });

  Widget buildTestApp({
    required Widget child,
    Locale locale = const Locale('ar'),
    Size screenSize = const Size(390, 844),
  }) {
    return EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: locale,
      useOnlyLangCode: true,
      child: ScreenUtilPlusInit(
        designSize: screenSize,
        builder: (context, _) => BlocProvider<OnboardingConsentCubit>.value(
          value: cubit,
          child: MaterialApp(
            key: UniqueKey(),
            locale: context.locale,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            routes: {
              AppRoutes.notificationsPermission: (_) => const Scaffold(body: Text('NotificationsScreen')),
              AppRoutes.main: (_) => const Scaffold(body: Text('MainShellScreen')),
            },
            home: child,
          ),
        ),
      ),
    );
  }

  Future<void> pumpAndReady(
    WidgetTester tester,
    Widget app, {
    Size? physicalSize,
    String expectedText = 'متابعة',
  }) async {
    if (physicalSize != null) {
      tester.view.physicalSize = physicalSize;
      addTearDown(tester.view.resetPhysicalSize);
    }
    await tester.pumpWidget(app);
    for (var i = 0; i < 50; i++) {
      if (find.byType(Scaffold).evaluate().isNotEmpty) {
        if (find.text(expectedText).evaluate().isNotEmpty) {
          break;
        }
      }
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
      await tester.pump(const Duration(milliseconds: 50));
    }
    await tester.pumpAndSettle();
  }

  testWidgets('complies with Apple Guideline 5.1.1(iv) across all permission screens and scenarios', (tester) async {
    // 1. Location screen on iPhone (Arabic)
    await pumpAndReady(
      tester,
      buildTestApp(child: const LocationPermissionScreen()),
      physicalSize: const Size(390 * 3, 844 * 3),
      expectedText: 'متابعة',
    );

    expect(find.text('متابعة'), findsOneWidget);
    expect(find.text('مش دلوقتي'), findsOneWidget);
    expect(find.textContaining('Allow', findRichText: true), findsNothing);
    expect(find.textContaining('Enable', findRichText: true), findsNothing);
    expect(find.textContaining('Grant', findRichText: true), findsNothing);
    expect(find.textContaining('اسمح', findRichText: true), findsNothing);

    // 2. iPad compatibility size
    tester.view.physicalSize = const Size(810 * 2, 1080 * 2);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('متابعة'), findsOneWidget);
    expect(find.text('مش دلوقتي'), findsOneWidget);

    // 3. Tapping Not now (مش دلوقتي) skips requestPermission and advances
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    await tester.pumpAndSettle();
    await tester.tap(find.text('مش دلوقتي'));
    await tester.pumpAndSettle();

    verifyNever(() => mockLocation.requestPermission());
    verify(() => mockRepo.recordConsent(ConsentType.location, granted: false)).called(1);
    expect(find.text('NotificationsScreen'), findsOneWidget);

    // 4. Reset & pump Location screen for Continue tap
    when(() => mockLocation.requestPermission()).thenAnswer((_) async => true);
    await pumpAndReady(
      tester,
      buildTestApp(child: const LocationPermissionScreen()),
      expectedText: 'متابعة',
    );

    await tester.tap(find.text('متابعة'));
    await tester.pumpAndSettle();

    verify(() => mockLocation.requestPermission()).called(1);
    verify(() => mockRepo.recordConsent(ConsentType.location, granted: true)).called(1);
    expect(find.text('NotificationsScreen'), findsOneWidget);

    // 5. Notifications screen verification (Arabic)
    when(() => mockPush.requestPermission()).thenAnswer((_) async => true);
    await pumpAndReady(
      tester,
      buildTestApp(child: const NotificationsPermissionScreen()),
      expectedText: 'متابعة',
    );

    expect(find.text('متابعة'), findsOneWidget);
    expect(find.text('مش دلوقتي'), findsOneWidget);
    expect(find.textContaining('Allow', findRichText: true), findsNothing);
    expect(find.textContaining('Enable', findRichText: true), findsNothing);
    expect(find.textContaining('Grant', findRichText: true), findsNothing);
    expect(find.textContaining('اسمح', findRichText: true), findsNothing);

    // Tapping Continue on Notifications screen
    await tester.tap(find.text('متابعة'));
    await tester.pumpAndSettle();

    verify(() => mockPush.requestPermission()).called(1);
    verify(() => mockRepo.recordConsent(ConsentType.notifications, granted: true)).called(1);
    expect(find.text('MainShellScreen'), findsOneWidget);
  });

  group('Apple Guideline 5.1.1(iv) Translation Dictionary Verification', () {
    test('en.json and ar.json do not contain forbidden words for permission buttons', () {
      final enString = File('assets/translations/en.json').readAsStringSync();
      final arString = File('assets/translations/ar.json').readAsStringSync();

      final en = jsonDecode(enString) as Map<String, dynamic>;
      final ar = jsonDecode(arString) as Map<String, dynamic>;

      // Verify English
      final enLocation = en['onboarding']['location'] as Map<String, dynamic>;
      final enNotifications = en['onboarding']['notifications'] as Map<String, dynamic>;

      expect(enLocation['allow'], equals('Continue'));
      expect(enLocation['manual'], equals('Not now'));
      expect(enNotifications['enable'], equals('Continue'));
      expect(enNotifications['not_now'], equals('Not now'));

      // Verify Arabic
      final arLocation = ar['onboarding']['location'] as Map<String, dynamic>;
      final arNotifications = ar['onboarding']['notifications'] as Map<String, dynamic>;

      expect(arLocation['allow'], equals('متابعة'));
      expect(arLocation['manual'], equals('مش دلوقتي'));
      expect(arNotifications['enable'], equals('متابعة'));
      expect(arNotifications['not_now'], equals('مش دلوقتي'));
    });
  });
}
