import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/animations/split_flap_text_widget.dart';
import 'package:mal3abk/core/animations/stretchy_pill_widget.dart';

/// The scoreboard flip and the stretchy nav pill: one short run per change,
/// nothing left running, reduced motion shows the end state at once.
void main() {
  Widget app(Widget child, {bool reduced = false}) => MaterialApp(
    home: Builder(
      builder: (context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: reduced),
        child: Scaffold(body: Center(child: child)),
      ),
    ),
  );

  group('SplitFlapTextWidget', () {
    Widget flap(String text, {bool reduced = false}) => app(
      SplitFlapTextWidget(
        text: text,
        style: const TextStyle(fontSize: 18),
        tileColor: Colors.black,
      ),
      reduced: reduced,
    );

    bool flipping(WidgetTester tester) => find
        .descendant(
          of: find.byType(SplitFlapTextWidget),
          matching: find.byType(Transform),
        )
        .evaluate()
        .isNotEmpty;

    testWidgets('flips in once, then shows the score plainly', (tester) async {
      await tester.pumpWidget(flap('3'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 150));
      expect(flipping(tester), isTrue);

      await tester.pumpAndSettle();
      expect(flipping(tester), isFalse);
      expect(find.text('3'), findsOneWidget);
      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('a new score flips again from the old one', (tester) async {
      await tester.pumpWidget(flap('1'));
      await tester.pumpAndSettle();

      await tester.pumpWidget(flap('2'));
      await tester.pump(const Duration(milliseconds: 100));
      expect(flipping(tester), isTrue);
      expect(find.text('1'), findsWidgets, reason: 'the old top folds away');

      await tester.pumpAndSettle();
      expect(find.text('2'), findsOneWidget);
      expect(find.text('1'), findsNothing);
    });

    testWidgets('reduced motion shows the score without flipping', (
      tester,
    ) async {
      await tester.pumpWidget(flap('4', reduced: true));
      await tester.pump();
      await tester.pump();

      expect(flipping(tester), isFalse);
      expect(find.text('4'), findsOneWidget);
    });
  });

  group('StretchyPillWidget', () {
    Widget bar(int index, {bool reduced = false}) => app(
      SizedBox(
        width: 300,
        height: 50,
        child: Stack(
          children: [
            StretchyPillWidget(
              index: index,
              itemWidth: 100,
              child: const ColoredBox(color: Colors.blue),
            ),
          ],
        ),
      ),
      reduced: reduced,
    );

    Rect pill(WidgetTester tester) =>
        tester.getRect(find.byType(ColoredBox).last);

    testWidgets('stretches across the way, then gathers on the new tab', (
      tester,
    ) async {
      await tester.pumpWidget(bar(0));
      final rest = pill(tester);
      expect(rest.width, 100);

      await tester.pumpWidget(bar(2));
      await tester.pump(const Duration(milliseconds: 150));
      final mid = pill(tester);
      expect(mid.width, greaterThan(100), reason: 'stretched');
      expect(mid.height, lessThan(rest.height), reason: 'thinner while long');

      await tester.pumpAndSettle();
      final end = pill(tester);
      expect(end.width, 100);
      expect(end.height, rest.height);
      expect(end.left - rest.left, 200);
      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('reduced motion jumps straight to the tab', (tester) async {
      await tester.pumpWidget(bar(0, reduced: true));
      final rest = pill(tester);

      await tester.pumpWidget(bar(1, reduced: true));
      await tester.pump();

      expect(pill(tester).left - rest.left, 100);
      expect(tester.hasRunningAnimations, isFalse);
    });
  });
}
