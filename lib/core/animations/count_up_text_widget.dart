import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'app_animations.dart';

/// A number that counts up to [value] when it first appears and glides to the
/// new value when it changes, so statistics feel alive instead of popping in.
/// When it arrives it gives one small tick, like a match clock rolling over.
///
/// [format] turns the in-between number into the text to show (localized
/// digits, a currency, a suffix), so this widget stays free of locale logic.
class CountUpTextWidget extends StatefulWidget {
  const CountUpTextWidget({
    required this.value,
    required this.format,
    this.style,
    this.textAlign,
    super.key,
  });

  final num value;
  final String Function(int current) format;
  final TextStyle? style;
  final TextAlign? textAlign;

  static const Duration tickDuration = Duration(milliseconds: 180);

  @override
  State<CountUpTextWidget> createState() => _CountUpTextWidgetState();
}

class _CountUpTextWidgetState extends State<CountUpTextWidget> {
  /// Bumped when a count lands; each bump plays the tick once.
  int _ticks = 0;

  @override
  Widget build(BuildContext context) {
    final reduced = AppAnimations.isReduced(context);
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: widget.value.toDouble()),
      duration: AppAnimations.duration(context, AppAnimations.count),
      curve: AppAnimations.standard,
      onEnd: reduced || widget.value == 0
          ? null
          : () => setState(() => _ticks++),
      builder: (context, current, _) {
        final text = Text(
          widget.format(current.round()),
          style: widget.style,
          textAlign: widget.textAlign,
          maxLines: 1,
        );
        if (_ticks == 0) return text;
        return TweenAnimationBuilder<double>(
          key: ValueKey(_ticks),
          tween: Tween<double>(begin: 0, end: 1),
          duration: CountUpTextWidget.tickDuration,
          builder: (context, t, child) => Transform.scale(
            scale: 1 + 0.07 * math.sin(math.pi * t),
            child: child,
          ),
          child: text,
        );
      },
    );
  }
}
