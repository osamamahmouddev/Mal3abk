import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/animations/fade_indexed_stack_widget.dart';

void main() {
  Widget app(int index) => MaterialApp(
    home: Scaffold(
      body: FadeIndexedStackWidget(
        index: index,
        children: const [Text('first'), Text('second')],
      ),
    ),
  );

  /// The opacity actually painted for [text] (not just the target value).
  double paintedOpacity(WidgetTester tester, String text) => tester
      .renderObject<RenderAnimatedOpacity>(
        find.ancestor(
          of: find.text(text),
          matching: find.byType(AnimatedOpacity),
        ),
      )
      .opacity
      .value;

  testWidgets('only the selected child is visible at first', (tester) async {
    await tester.pumpWidget(app(0));
    await tester.pumpAndSettle();
    expect(paintedOpacity(tester, 'first'), 1);
    expect(paintedOpacity(tester, 'second'), 0);
  });

  testWidgets('the child left behind fades out completely', (tester) async {
    await tester.pumpWidget(app(0));
    await tester.pumpAndSettle();
    await tester.pumpWidget(app(1));
    await tester.pumpAndSettle();

    expect(paintedOpacity(tester, 'second'), 1);
    expect(
      paintedOpacity(tester, 'first'),
      0,
      reason: 'the old tab must not show through the new one',
    );
  });

  testWidgets('switching back and forth leaves one child visible', (
    tester,
  ) async {
    await tester.pumpWidget(app(0));
    await tester.pumpAndSettle();
    await tester.pumpWidget(app(1));
    await tester.pumpAndSettle();
    await tester.pumpWidget(app(0));
    await tester.pumpAndSettle();

    expect(paintedOpacity(tester, 'first'), 1);
    expect(paintedOpacity(tester, 'second'), 0);
  });

  testWidgets('the hidden child ignores taps', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FadeIndexedStackWidget(
            index: 1,
            children: [
              Center(
                child: TextButton(
                  onPressed: () => taps++,
                  child: const Text('hidden'),
                ),
              ),
              const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('hidden'), warnIfMissed: false);
    expect(taps, 0);
  });

  testWidgets('both children keep their state', (tester) async {
    await tester.pumpWidget(app(0));
    await tester.pumpWidget(app(1));
    await tester.pumpAndSettle();
    expect(find.text('first'), findsOneWidget);
    expect(find.text('second'), findsOneWidget);
  });
}
