import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/animations/count_up_text_widget.dart';
import 'package:mal3abk/core/widgets/state_illustration_widget.dart';

/// The small touches: the empty-state dots run one lap and settle, and a
/// counted number ticks once when it lands. Both end cleanly and stay still
/// with reduced motion.
void main() {
  Widget app(Widget child, {bool reduced = false}) => ScreenUtilPlusInit(
    designSize: const Size(390, 844),
    builder: (context, _) => MaterialApp(
      home: Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: reduced),
          child: Scaffold(body: Center(child: child)),
        ),
      ),
    ),
  );

  List<double> dotAngles(WidgetTester tester) => [
    for (final t in tester.widgetList<Transform>(
      find.descendant(
        of: find.byType(StateIllustrationWidget),
        matching: find.byType(Transform),
      ),
    ))
      // Rotation about z, read back from the matrix.
      t.transform.getRotation().entry(1, 0),
  ];

  group('StateIllustrationWidget', () {
    testWidgets('the dots run one lap, then rest where they belong', (
      tester,
    ) async {
      await tester.pumpWidget(
        app(const StateIllustrationWidget(icon: Icon(Icons.search))),
      );
      await tester.pump(const Duration(milliseconds: 300));
      expect(dotAngles(tester), hasLength(2));
      expect(
        dotAngles(tester).any((sin) => sin.abs() > 0.05),
        isTrue,
        reason: 'mid-lap',
      );

      await tester.pumpAndSettle();
      for (final sin in dotAngles(tester)) {
        expect(sin.abs(), lessThan(1e-6), reason: 'back at rest');
      }
      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('reduced motion keeps the dots still', (tester) async {
      await tester.pumpWidget(
        app(
          const StateIllustrationWidget(icon: Icon(Icons.search)),
          reduced: true,
        ),
      );
      await tester.pump();

      for (final sin in dotAngles(tester)) {
        expect(sin.abs(), lessThan(1e-6));
      }
      expect(tester.hasRunningAnimations, isFalse);
    });
  });

  group('CountUpTextWidget tick', () {
    double? tickScale(WidgetTester tester) {
      final scales = tester.widgetList<Transform>(
        find.descendant(
          of: find.byType(CountUpTextWidget),
          matching: find.byType(Transform),
        ),
      );
      return scales.isEmpty ? null : scales.first.transform.getMaxScaleOnAxis();
    }

    testWidgets('counts up, ticks once on arrival, then settles', (
      tester,
    ) async {
      await tester.pumpWidget(
        app(CountUpTextWidget(value: 12, format: (n) => '$n')),
      );
      await tester.pump(const Duration(milliseconds: 300));
      expect(tickScale(tester), isNull, reason: 'no tick while counting');

      // The count lands, the tick starts on the next frame.
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 90));
      expect(tickScale(tester), greaterThan(1));

      await tester.pumpAndSettle();
      expect(find.text('12'), findsOneWidget);
      expect(tickScale(tester), closeTo(1, 1e-6));
      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('zero and reduced motion do not tick', (tester) async {
      await tester.pumpWidget(
        app(CountUpTextWidget(value: 0, format: (n) => '$n')),
      );
      await tester.pumpAndSettle();
      expect(tickScale(tester), isNull);

      await tester.pumpWidget(
        app(CountUpTextWidget(value: 7, format: (n) => '$n'), reduced: true),
      );
      await tester.pumpAndSettle();
      expect(find.text('7'), findsOneWidget);
      expect(tickScale(tester), isNull);
    });
  });
}
