import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/animations/double_tap_heart_widget.dart';
import 'package:mal3abk/core/animations/flying_heart_widget.dart';

void main() {
  testWidgets('a double tap likes once, pops a heart and clears it after', (
    tester,
  ) async {
    var likes = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 300,
            height: 300,
            child: DoubleTapHeartWidget(
              onDoubleTap: () => likes++,
              child: const ColoredBox(color: Colors.green),
            ),
          ),
        ),
      ),
    );

    final center = tester.getCenter(find.byType(ColoredBox).last);
    await tester.tapAt(center);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tapAt(center);
    await tester.pump();

    expect(likes, 1);
    expect(find.byType(FlyingHeartWidget), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(FlyingHeartWidget), findsNothing);
  });
}
