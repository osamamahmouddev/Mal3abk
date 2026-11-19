import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import 'app_animations.dart';

/// Pull to refresh with a football instead of a spinner: the ball rolls
/// down with the finger, turning as it comes, and while the screen reloads
/// it keeps a light keepy-up bounce over its shadow.
///
/// The pulling itself is Flutter's [RefreshIndicator] (so it behaves like
/// every other list); only the picture is ours. The ball sits on its own
/// layer and rebuilds alone, the list never does, and nothing runs once
/// the refresh is over. With reduced motion the ball shows without moving.
class BallRefreshIndicator extends StatefulWidget {
  const BallRefreshIndicator({
    required this.onRefresh,
    required this.child,
    super.key,
  });

  final RefreshCallback onRefresh;
  final Widget child;

  /// How far to pull, in logical pixels, for the ball to be fully in.
  static const double pullExtent = 90;

  /// Where the ball rests while the screen reloads.
  static const double restTop = 18;

  static const double ballSize = 26;

  @override
  State<BallRefreshIndicator> createState() => _BallRefreshIndicatorState();
}

class _BallRefreshIndicatorState extends State<BallRefreshIndicator>
    with TickerProviderStateMixin {
  /// 0 hidden, 1 fully pulled in (the indicator is armed past it).
  final ValueNotifier<double> _pull = ValueNotifier(0);
  double _overscroll = 0;
  RefreshIndicatorStatus? _status;

  late final AnimationController _bounce = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 560),
  );
  late final AnimationController _exit = AnimationController(
    vsync: this,
    duration: AppAnimations.base,
  );

  bool get _reloading =>
      _status == RefreshIndicatorStatus.snap ||
      _status == RefreshIndicatorStatus.refresh;

  @override
  void dispose() {
    _pull.dispose();
    _bounce.dispose();
    _exit.dispose();
    super.dispose();
  }

  /// Follows the pull past the top of the list, for bouncing lists
  /// (negative pixels) and clamping ones (overscroll) alike.
  bool _onScroll(ScrollNotification n) {
    if (n.depth != 0 || n.metrics.axis != Axis.vertical || _reloading) {
      return false;
    }
    if (n is OverscrollNotification && n.overscroll < 0) {
      _overscroll -= n.overscroll;
    } else if (n is ScrollUpdateNotification) {
      final past = n.metrics.minScrollExtent - n.metrics.pixels;
      if (past > 0) {
        _overscroll = past;
      } else if (_overscroll > 0 && (n.scrollDelta ?? 0) > 0) {
        _overscroll = math.max(0, _overscroll - n.scrollDelta!);
      }
    } else if (n is ScrollEndNotification) {
      _overscroll = 0;
    }
    _pull.value = (_overscroll / BallRefreshIndicator.pullExtent).clamp(0, 1.4);
    return false;
  }

  void _onStatus(RefreshIndicatorStatus? status) {
    _status = status;
    final reduced = AppAnimations.isReduced(context);
    switch (status) {
      case RefreshIndicatorStatus.snap || RefreshIndicatorStatus.refresh:
        _exit.value = 0;
        _pull.value = 1;
        if (!reduced && !_bounce.isAnimating) _bounce.repeat();
      case RefreshIndicatorStatus.done || RefreshIndicatorStatus.canceled:
        _bounce.stop();
        _overscroll = 0;
        _exit.forward(from: 0).whenComplete(() {
          if (!mounted) return;
          _pull.value = 0;
          _exit.value = 0;
          _bounce.value = 0;
        });
      case RefreshIndicatorStatus.drag || RefreshIndicatorStatus.armed:
        _exit.value = 0;
      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator.noSpinner(
          onRefresh: widget.onRefresh,
          onStatusChange: _onStatus,
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: widget.child,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: RepaintBoundary(
              child: AnimatedBuilder(
                animation: Listenable.merge([_pull, _bounce, _exit]),
                builder: (context, _) => _ball(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _ball() {
    final pull = _pull.value;
    if (pull <= 0) return const SizedBox.shrink();
    const size = BallRefreshIndicator.ballSize;
    final shown = pull.clamp(0.0, 1.0);
    final fade = 1 - _exit.value;

    // Rolling in: down from above the list, one and a half turns.
    var top = -size + (BallRefreshIndicator.restTop + size) * shown;
    var turn = pull * math.pi * 3;
    var squash = 1.0;
    var shadow = shown;

    if (_bounce.isAnimating) {
      // Keepy-up: a hop, a quick squash on touch, the shadow tightening as
      // the ball rises.
      final t = _bounce.value;
      final height = math.sin(math.pi * t);
      top -= 14 * height;
      turn += t * math.pi * 2;
      squash = 1 - 0.12 * math.pow(1 - height, 6);
      shadow = 1 - 0.45 * height;
    }

    return SizedBox(
      height: BallRefreshIndicator.restTop + size + 14,
      child: Opacity(
        opacity: (shown * 2).clamp(0.0, 1.0) * fade,
        child: Transform.scale(
          scale: 0.6 + 0.4 * fade,
          alignment: Alignment.topCenter,
          child: CustomPaint(
            painter: _BallPainter(
              top: top,
              size: size,
              turn: turn,
              squash: squash,
              shadow: shadow,
              armed: pull >= 1 && !_bounce.isAnimating,
            ),
          ),
        ),
      ),
    );
  }
}

/// A small classic football (white with navy patches) and its shadow.
class _BallPainter extends CustomPainter {
  const _BallPainter({
    required this.top,
    required this.size,
    required this.turn,
    required this.squash,
    required this.shadow,
    required this.armed,
  });

  final double top;
  final double size;
  final double turn;
  final double squash;
  final double shadow;
  final bool armed;

  @override
  void paint(Canvas canvas, Size area) {
    final r = size / 2;
    final cx = area.width / 2;
    final ground = BallRefreshIndicator.restTop + size + 4;

    // Shadow on the "grass" under the resting point.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, ground),
        width: size * 0.9 * shadow,
        height: 4 * shadow,
      ),
      Paint()..color = AppColors.brandNavy.withValues(alpha: 0.12 * shadow),
    );

    canvas
      ..save()
      ..translate(cx, top + r)
      ..scale(1 + (1 - squash) * 0.6, squash)
      ..rotate(turn);

    final outline = Paint()
      ..color = AppColors.brandNavy
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawCircle(
      Offset.zero,
      r,
      Paint()..color = armed ? AppColors.successLight : AppColors.white,
    );

    // Centre pentagon and the seams leaving its corners.
    final patch = Path();
    final seams = Path();
    for (var i = 0; i < 5; i++) {
      final a = -math.pi / 2 + i * 2 * math.pi / 5;
      final corner = Offset(math.cos(a), math.sin(a)) * (r * 0.38);
      if (i == 0) {
        patch.moveTo(corner.dx, corner.dy);
      } else {
        patch.lineTo(corner.dx, corner.dy);
      }
      final edge = Offset(math.cos(a), math.sin(a)) * (r * 0.92);
      seams
        ..moveTo(corner.dx, corner.dy)
        ..lineTo(edge.dx, edge.dy);
    }
    patch.close();
    canvas
      ..drawPath(patch, Paint()..color = AppColors.brandNavy)
      ..drawPath(seams, outline..strokeWidth = 1)
      ..drawCircle(Offset.zero, r, outline..strokeWidth = 1.4)
      ..restore();
  }

  @override
  bool shouldRepaint(_BallPainter old) =>
      old.top != top ||
      old.turn != turn ||
      old.squash != squash ||
      old.shadow != shadow ||
      old.armed != armed;
}
