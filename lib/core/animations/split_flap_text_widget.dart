import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'app_animations.dart';

/// Text on a stadium split-flap board: when [text] first shows or changes,
/// the top half of the old value folds down and the bottom half of the new
/// one lands, with a thin hinge line across the middle.
///
/// One flip per change ([duration], after [delay]); nothing loops. With
/// reduced motion the new text just shows.
class SplitFlapTextWidget extends StatefulWidget {
  const SplitFlapTextWidget({
    required this.text,
    required this.style,
    required this.tileColor,
    super.key,
    this.delay = Duration.zero,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    this.radius = 8,
  });

  final String text;
  final TextStyle style;
  final Color tileColor;
  final Duration delay;
  final EdgeInsetsGeometry padding;
  final double radius;

  static const Duration duration = Duration(milliseconds: 520);

  @override
  State<SplitFlapTextWidget> createState() => _SplitFlapTextWidgetState();
}

class _SplitFlapTextWidgetState extends State<SplitFlapTextWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flip = AnimationController(
    vsync: this,
    duration: SplitFlapTextWidget.duration,
  );

  /// Shown before the flip: blank on first appearance.
  String _previous = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _start());
  }

  @override
  void didUpdateWidget(SplitFlapTextWidget old) {
    super.didUpdateWidget(old);
    if (old.text != widget.text) {
      _previous = old.text;
      _start();
    }
  }

  Future<void> _start() async {
    if (!mounted) return;
    if (AppAnimations.isReduced(context)) {
      _flip.value = 1;
      return;
    }
    _flip.value = 0;
    if (widget.delay > Duration.zero) {
      await Future<void>.delayed(widget.delay);
      if (!mounted) return;
    }
    await _flip.forward(from: 0);
  }

  @override
  void dispose() {
    _flip.dispose();
    super.dispose();
  }

  Widget _tile(String text) => Container(
    padding: widget.padding,
    decoration: BoxDecoration(
      color: widget.tileColor,
      borderRadius: BorderRadius.circular(widget.radius),
    ),
    child: Text(
      // A blank flap keeps the width of the value it reveals.
      text.isEmpty ? widget.text : text,
      style: text.isEmpty
          ? widget.style.copyWith(color: Colors.transparent)
          : widget.style,
      textAlign: TextAlign.center,
    ),
  );

  /// The top or bottom half of [child].
  static Widget _half(Widget child, {required bool top}) => ClipRect(
    child: Align(
      alignment: top ? Alignment.topCenter : Alignment.bottomCenter,
      heightFactor: 0.5,
      child: child,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _flip,
        builder: (context, _) {
          final t = Curves.easeIn.transform(_flip.value);
          final next = _tile(widget.text);
          if (_flip.value >= 1) return next;
          final old = _tile(_previous);
          // First half: the old top folds down to flat. Second half: the
          // new bottom swings down from flat into place.
          final firstHalf = t < 0.5;
          final angle = firstHalf
              ? -math.pi / 2 * (t / 0.5)
              : math.pi / 2 * (1 - (t - 0.5) / 0.5);
          final flap = Transform(
            alignment: firstHalf ? Alignment.bottomCenter : Alignment.topCenter,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.006)
              ..rotateX(angle),
            child: _half(firstHalf ? old : next, top: firstHalf),
          );
          return Stack(
            alignment: Alignment.center,
            children: [
              // Behind: the new top and the old bottom until the flap lands.
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _half(next, top: true),
                  _half(firstHalf ? old : next, top: false),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: firstHalf
                    ? [flap, Opacity(opacity: 0, child: _half(old, top: false))]
                    : [
                        Opacity(opacity: 0, child: _half(next, top: true)),
                        flap,
                      ],
              ),
              // The hinge.
              Positioned.fill(
                child: Center(
                  child: Container(
                    height: 1,
                    color: Colors.black.withValues(alpha: 0.25),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
