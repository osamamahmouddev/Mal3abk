import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/animations/animated_check_widget.dart';
import 'package:mal3abk/core/animations/app_animations.dart';
import 'package:mal3abk/core/animations/app_page_transitions_builder.dart';
import 'package:mal3abk/core/animations/count_up_text_widget.dart';
import 'package:mal3abk/core/animations/state_switcher_widget.dart';
import 'package:mal3abk/core/styles/app_assets.dart';
import 'package:mal3abk/core/widgets/custom_bottom_nav_bar_widget.dart';
import 'package:mal3abk/core/widgets/fade_slide_in_widget.dart';

Widget _app(
  Widget body, {
  TextDirection direction = TextDirection.ltr,
  bool disableAnimations = false,
}) => ScreenUtilPlusInit(
  designSize: const Size(390, 844),
  builder: (_, _) => MaterialApp(
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(disableAnimations: disableAnimations),
      child: Directionality(textDirection: direction, child: child!),
    ),
    home: Scaffold(body: body),
  ),
);

double _opacityOf(WidgetTester tester, Finder child) => tester
    .widget<FadeTransition>(
      find.ancestor(of: child, matching: find.byType(FadeTransition)).first,
    )
    .opacity
    .value;

void main() {
  group('AppAnimations', () {
    testWidgets('durations collapse to zero when animations are off', (
      tester,
    ) async {
      late Duration normal;
      late Duration reduced;
      await tester.pumpWidget(
        _app(
          Builder(
            builder: (context) {
              normal = AppAnimations.duration(context, AppAnimations.slow);
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pumpWidget(
        _app(
          Builder(
            builder: (context) {
              reduced = AppAnimations.duration(context, AppAnimations.slow);
              return const SizedBox();
            },
          ),
          disableAnimations: true,
        ),
      );

      expect(normal, AppAnimations.slow);
      expect(reduced, Duration.zero);
    });

    test('stagger delay is capped so long lists do not feel slow', () {
      expect(AppAnimations.staggerDelay(0), Duration.zero);
      expect(
        AppAnimations.staggerDelay(100),
        AppAnimations.staggerStep * AppAnimations.maxStaggerIndex,
      );
    });
  });

  group('FadeSlideInWidget', () {
    testWidgets('starts hidden and fades in', (tester) async {
      await tester.pumpWidget(
        _app(const FadeSlideInWidget(child: Text('hello'))),
      );
      expect(_opacityOf(tester, find.text('hello')), 0);

      await tester.pumpAndSettle();
      expect(_opacityOf(tester, find.text('hello')), 1);
    });

    testWidgets('later siblings start later', (tester) async {
      await tester.pumpWidget(
        _app(
          const Column(
            children: [
              FadeSlideInWidget(child: Text('first')),
              FadeSlideInWidget(index: 3, child: Text('fourth')),
            ],
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 20));
      await tester.pump(const Duration(milliseconds: 100));

      expect(
        _opacityOf(tester, find.text('first')),
        greaterThan(_opacityOf(tester, find.text('fourth'))),
      );
      await tester.pumpAndSettle();
    });

    testWidgets('is fully visible at once when animations are off', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          const FadeSlideInWidget(child: Text('hello')),
          disableAnimations: true,
        ),
      );

      expect(_opacityOf(tester, find.text('hello')), 1);
    });
  });

  group('StateSwitcherWidget', () {
    testWidgets('cross-fades: both states exist mid-switch, one after', (
      tester,
    ) async {
      Widget build(String key, String text) =>
          _app(StateSwitcherWidget(stateKey: key, child: Text(text)));

      await tester.pumpWidget(build('loading', 'loading text'));
      await tester.pumpWidget(build('loaded', 'loaded text'));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('loading text'), findsOneWidget);
      expect(find.text('loaded text'), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.text('loading text'), findsNothing);
      expect(find.text('loaded text'), findsOneWidget);
    });

    testWidgets('a new value in the same state does not re-animate', (
      tester,
    ) async {
      Widget build(String text) =>
          _app(StateSwitcherWidget(stateKey: 'loaded', child: Text(text)));

      await tester.pumpWidget(build('one'));
      await tester.pumpAndSettle();
      await tester.pumpWidget(build('two'));
      await tester.pump(const Duration(milliseconds: 50));

      expect(find.text('one'), findsNothing);
      expect(find.text('two'), findsOneWidget);
    });

    testWidgets('keeps a centered state centered in bounded space', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          const StateSwitcherWidget(
            stateKey: 'empty',
            child: Center(child: Text('empty')),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final screen = tester.getSize(find.byType(Scaffold));
      expect(tester.getCenter(find.text('empty')).dx, screen.width / 2);
      expect(tester.getCenter(find.text('empty')).dy, screen.height / 2);
    });
  });

  group('CountUpTextWidget', () {
    testWidgets('counts up and ends on the value', (tester) async {
      await tester.pumpWidget(
        _app(CountUpTextWidget(value: 40, format: (n) => '$n pitches')),
      );
      expect(find.text('0 pitches'), findsOneWidget);

      await tester.pump(AppAnimations.count ~/ 4);
      final midText = tester
          .widget<Text>(find.byType(Text))
          .data!
          .replaceAll(' pitches', '');
      final mid = int.parse(midText);
      expect(mid, inInclusiveRange(1, 39));

      await tester.pumpAndSettle();
      expect(find.text('40 pitches'), findsOneWidget);
    });

    testWidgets('shows the value at once when animations are off', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          CountUpTextWidget(value: 40, format: (n) => '$n'),
          disableAnimations: true,
        ),
      );
      await tester.pump();

      expect(find.text('40'), findsOneWidget);
    });
  });

  group('AnimatedCheckWidget', () {
    testWidgets('draws and settles without errors', (tester) async {
      await tester.pumpWidget(
        _app(const AnimatedCheckWidget(color: Colors.green)),
      );
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(AnimatedCheckWidget), findsOneWidget);
    });
  });

  group('bottom nav pill', () {
    // The bar is sized for a phone; the default test screen is smaller.
    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    const items = [
      CustomBottomNavBarItem(title: 'a', iconAsset: AppAssets.icNavHome),
      CustomBottomNavBarItem(title: 'b', iconAsset: AppAssets.icNavHome),
      CustomBottomNavBarItem(title: 'c', iconAsset: AppAssets.icNavHome),
    ];

    void phone(WidgetTester tester) {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
    }

    Future<double> pillStart(
      WidgetTester tester, {
      required int index,
      required TextDirection direction,
    }) async {
      await tester.pumpWidget(
        _app(
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavBarWidget(
              currentIndex: index,
              onTap: (_) {},
              items: items,
            ),
          ),
          direction: direction,
        ),
      );
      await tester.pumpAndSettle();
      final pill = tester.widget<AnimatedPositionedDirectional>(
        find.byType(AnimatedPositionedDirectional),
      );
      return pill.start!;
    }

    testWidgets('sits on the selected tab', (tester) async {
      phone(tester);
      final first = await pillStart(
        tester,
        index: 0,
        direction: TextDirection.ltr,
      );
      final last = await pillStart(
        tester,
        index: 2,
        direction: TextDirection.ltr,
      );

      expect(first, 0);
      expect(last, greaterThan(first));
    });

    testWidgets('glides instead of jumping when the tab changes', (
      tester,
    ) async {
      phone(tester);
      Widget bar(int index) => _app(
        Align(
          alignment: Alignment.bottomCenter,
          child: CustomBottomNavBarWidget(
            currentIndex: index,
            onTap: (_) {},
            items: items,
          ),
        ),
      );
      await tester.pumpWidget(bar(0));
      await tester.pumpAndSettle();
      final pill = find.descendant(
        of: find.byType(AnimatedPositionedDirectional),
        matching: find.byType(DecoratedBox),
      );
      final before = tester.getTopLeft(pill).dx;

      await tester.pumpWidget(bar(2));
      await tester.pump(const Duration(milliseconds: 80));
      final during = tester.getTopLeft(pill).dx;
      await tester.pumpAndSettle();
      final after = tester.getTopLeft(pill).dx;

      expect(during, greaterThan(before));
      expect(during, lessThan(after));
    });

    testWidgets('first tab is on the right in Arabic', (tester) async {
      phone(tester);
      await pillStart(tester, index: 0, direction: TextDirection.rtl);
      final screenWidth = tester.getSize(find.byType(Scaffold)).width;
      final pillCenter = tester
          .getCenter(find.byType(AnimatedPositionedDirectional))
          .dx;

      expect(pillCenter, greaterThan(screenWidth / 2));
    });
  });

  group('AppPageTransitionsBuilder', () {
    Future<(double, double)> pushedPageLeft(
      WidgetTester tester,
      TextDirection direction,
    ) async {
      final navigator = GlobalKey<NavigatorState>();
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigator,
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {TargetPlatform.android: AppPageTransitionsBuilder()},
            ),
          ),
          builder: (context, child) =>
              Directionality(textDirection: direction, child: child!),
          home: const Scaffold(body: Text('home')),
        ),
      );
      navigator.currentState!.push(
        MaterialPageRoute<void>(
          builder: (_) => const Scaffold(body: Text('next')),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 60));
      final during = tester.getTopLeft(find.text('next')).dx;
      await tester.pumpAndSettle();
      final after = tester.getTopLeft(find.text('next')).dx;
      return (during, after);
    }

    testWidgets('enters from the right in English', (tester) async {
      final (during, after) = await pushedPageLeft(tester, TextDirection.ltr);

      expect(during, greaterThan(after));
    });

    testWidgets('enters from the left in Arabic', (tester) async {
      final (during, after) = await pushedPageLeft(tester, TextDirection.rtl);

      expect(during, lessThan(after));
    });
  });
}
