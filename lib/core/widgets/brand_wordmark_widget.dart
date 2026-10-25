import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';


class BrandWordmarkWidget extends StatelessWidget {
  const BrandWordmarkWidget({
    required this.titleStyle,
    required this.latinStyle,
    required this.accentColor,
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final TextStyle titleStyle;
  final TextStyle latinStyle;
  final Color accentColor;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text('app.name'.tr(context: context), style: titleStyle),
        Text.rich(
          TextSpan(
            style: latinStyle,
            children: [
              const TextSpan(text: 'Mal'),
              TextSpan(
                text: '3',
                style: latinStyle.copyWith(color: accentColor),
              ),
              const TextSpan(text: 'abak'),
            ],
          ),
          textDirection: TextDirection.ltr,
        ),
      ],
    );
  }
}
