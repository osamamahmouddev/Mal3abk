import 'package:flutter/widgets.dart';

import 'app_animations.dart';

/// A number that counts up to [value] when it first appears and glides to the
/// new value when it changes, so statistics feel alive instead of popping in.
///
/// [format] turns the in-between number into the text to show (localized
/// digits, a currency, a suffix), so this widget stays free of locale logic.
class CountUpTextWidget extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value.toDouble()),
      duration: AppAnimations.duration(context, AppAnimations.count),
      curve: AppAnimations.standard,
      builder: (context, current, _) => Text(
        format(current.round()),
        style: style,
        textAlign: textAlign,
        maxLines: 1,
      ),
    );
  }
}
