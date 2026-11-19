import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/animations/animated_check_painter.dart';
import 'package:mal3abk/core/animations/animated_check_widget.dart';
import 'package:mal3abk/core/animations/ball_refresh_indicator.dart';
import 'package:mal3abk/core/animations/turf_shimmer_widget.dart';
import 'package:shimmer/shimmer.dart';

/// The app's football motion: the ball pull-to-refresh, the whistle after a
/// success check and the turf loading shimmer. Each runs only while it has
/// something to show, ends cleanly, and stays still with reduced motion.
void main() {
  Widget app(Widget child, {bool reduced = false}) => MaterialApp(
    home: Builder(
      builder: (context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: reduced),
        child: Scaffold(body: child),
      ),
    ),
  );

  Finder ballPaint() => find.descendant(
    of: find.byType(BallRefreshIndicator),
    matching: find.byWidgetPredicate(
      (w) => w is CustomPaint && w.painter != null,
    ),
  );

  group('BallRefreshIndicator', () {
    Widget list(Completer<void> refresh, {bool reduced = false}) => app(
      BallRefreshIndicator(
        onRefresh: () => refresh.future,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [for (var i = 0; i < 30; i++) ListTile(title: Text('$i'))],
        ),
      ),
      reduced: reduced,
    );

    testWidgets('the ball follows the pull, bounces while reloading, then '
        'leaves and nothing keeps running', (tester) async {
      final refresh = Completer<void>();
      var refreshed = 0;
      await tester.pumpWidget(
        app(
          BallRefreshIndicator(
            onRefresh: () {
              refreshed++;
              return refresh.future;
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                for (var i = 0; i < 30; i++) ListTile(title: Text('$i')),
              ],
            ),
          ),
        ),
      );
      expect(ballPaint(), findsNothing, reason: 'hidden until pulled');

      await tester.fling(find.text('0'), const Offset(0, 300), 1000);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 300));

      expect(refreshed, 1);
      expect(ballPaint(), findsOneWidget);
      expect(tester.hasRunningAnimations, isTrue, reason: 'keepy-up bounce');

      refresh.complete();
      await tester.pumpAndSettle();

      expect(ballPaint(), findsNothing);
      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('with reduced motion the ball does not bounce', (tester) async {
      final refresh = Completer<void>();
      await tester.pumpWidget(list(refresh, reduced: true));

      await tester.fling(find.text('0'), const Offset(0, 300), 1000);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 600));

      final painter = tester.widget<CustomPaint>(ballPaint()).painter!;
      await tester.pump(const Duration(milliseconds: 200));
      expect(
        tester.widget<CustomPaint>(ballPaint()).painter!.shouldRepaint(painter),
        isFalse,
        reason: 'the ball stays still',
      );

      refresh.complete();
      await tester.pumpAndSettle();
    });
  });

  group('AnimatedCheckWidget whistle', () {
    WhistleBurstPainter? burst(WidgetTester tester) {
      final paint = tester.widget<CustomPaint>(
        find.descendant(
          of: find.byType(AnimatedCheckWidget),
          matching: find.byType(CustomPaint),
        ),
      );
      return paint.foregroundPainter as WhistleBurstPainter?;
    }

    testWidgets('the chalk strokes fly out after the check, once', (
      tester,
    ) async {
      await tester.pumpWidget(
        app(const Center(child: AnimatedCheckWidget(color: Colors.green))),
      );

      await tester.pump(const Duration(milliseconds: 300));
      expect(burst(tester)!.progress, 0, reason: 'the check draws first');

      await tester.pump(const Duration(milliseconds: 400));
      expect(burst(tester)!.progress, inExclusiveRange(0, 1));

      await tester.pumpAndSettle();
      expect(burst(tester)!.progress, 1);
      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('a small "ready" mark has no whistle', (tester) async {
      await tester.pumpWidget(
        app(
          const Center(
            child: AnimatedCheckWidget(color: Colors.green, burst: false),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(burst(tester), isNull);
    });
  });

  group('TurfShimmerWidget', () {
    testWidgets('mower stripes move, and stop with reduced motion', (
      tester,
    ) async {
      await tester.pumpWidget(
        app(const TurfShimmerWidget(child: SizedBox(width: 200, height: 40))),
      );
      expect(tester.widget<Shimmer>(find.byType(Shimmer)).enabled, isTrue);

      await tester.pumpWidget(
        app(
          const TurfShimmerWidget(child: SizedBox(width: 200, height: 40)),
          reduced: true,
        ),
      );
      expect(tester.widget<Shimmer>(find.byType(Shimmer)).enabled, isFalse);
    });
  });
}
