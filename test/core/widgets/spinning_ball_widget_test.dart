import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/styles/app_colors.dart';
import 'package:mal3abk/core/widgets/spinning_ball_widget.dart';

void main() {
  testWidgets('renders SpinningBallWidget and advances rotation', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SpinningBallWidget(
              size: 32,
              ballColor: AppColors.white,
              patternColor: AppColors.brandRed,
            ),
          ),
        ),
      ),
    );

    expect(find.byType(SpinningBallWidget), findsOneWidget);
    final rotationFinder = find.descendant(
      of: find.byType(SpinningBallWidget),
      matching: find.byType(RotationTransition),
    );
    expect(rotationFinder, findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(SpinningBallWidget),
        matching: find.byType(CustomPaint),
      ),
      findsOneWidget,
    );

    // Verify rotation progresses with animation ticks
    await tester.pump(const Duration(milliseconds: 250));
    final rotationWidget = tester.widget<RotationTransition>(rotationFinder);
    expect(rotationWidget.turns.value, greaterThan(0.0));
  });
}
