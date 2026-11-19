import 'package:flutter/widgets.dart';

import 'app_animations.dart';

/// The selected-tab pill, moving like a drop of liquid: its leading edge
/// reaches the new tab first while the trailing edge follows a beat later,
/// so the pill stretches across the way and gathers back into the new tab,
/// thinning a little while stretched.
///
/// Place it directly in the bar's [Stack]. A tap during the move retargets
/// from wherever the pill is. One short run per tab change; reduced motion
/// jumps straight to the tab.
class StretchyPillWidget extends StatefulWidget {
  const StretchyPillWidget({
    required this.index,
    required this.itemWidth,
    required this.child,
    super.key,
  });

  final int index;
  final double itemWidth;
  final Widget child;

  static const Duration duration = Duration(milliseconds: 420);

  /// The thickest the pill gets while stretched, in logical pixels lost at
  /// the top and the bottom.
  static const double maxThinning = 2.5;

  @override
  State<StretchyPillWidget> createState() => _StretchyPillWidgetState();
}

class _StretchyPillWidgetState extends State<StretchyPillWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _move = AnimationController(
    vsync: this,
    duration: StretchyPillWidget.duration,
  )..value = 1;

  late double _fromStart = _targetStart;
  late double _fromEnd = _targetEnd;
  bool _forward = true;

  double get _targetStart => widget.index * widget.itemWidth;
  double get _targetEnd => _targetStart + widget.itemWidth;

  static const Curve _lead = Interval(0, 0.75, curve: Curves.easeOutCubic);
  static const Curve _trail = Interval(0.2, 1, curve: Curves.easeInOutCubic);

  (double, double) get _edges {
    final t = _move.value;
    final leading = _lead.transform(t);
    final trailing = _trail.transform(t);
    final start = _lerp(
      _fromStart,
      _targetStart,
      _forward ? trailing : leading,
    );
    final end = _lerp(_fromEnd, _targetEnd, _forward ? leading : trailing);
    return (start, end);
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;

  @override
  void didUpdateWidget(StretchyPillWidget old) {
    super.didUpdateWidget(old);
    if (old.index == widget.index && old.itemWidth == widget.itemWidth) {
      return;
    }
    if (old.itemWidth != widget.itemWidth || AppAnimations.isReduced(context)) {
      _fromStart = _targetStart;
      _fromEnd = _targetEnd;
      _move.value = 1;
      return;
    }
    // Retarget from where the pill is now, mid-move included.
    final (start, end) = _move.isAnimating
        ? _edges
        : (old.index * old.itemWidth, (old.index + 1) * old.itemWidth);
    _fromStart = start;
    _fromEnd = end;
    _forward = widget.index > old.index;
    _move.forward(from: 0);
  }

  @override
  void dispose() {
    _move.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _move,
      builder: (context, child) {
        final (start, end) = _move.value >= 1
            ? (_targetStart, _targetEnd)
            : _edges;
        final stretch = ((end - start) / widget.itemWidth - 1).clamp(0.0, 1.0);
        final thin = StretchyPillWidget.maxThinning * stretch;
        return PositionedDirectional(
          start: start,
          width: end - start,
          top: thin,
          bottom: thin,
          child: child!,
        );
      },
      child: RepaintBoundary(child: widget.child),
    );
  }
}
