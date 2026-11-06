import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

/// A titled settings card whose rows are separated by dividers.
class SettingsSectionCardWidget extends StatelessWidget {
  const SettingsSectionCardWidget({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: AppTextStyles.font15Bold),
        hSpace(8),
        CustomCardWidget(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (final (i, child) in children.indexed) ...[
                if (i > 0) const Divider(height: 1, color: AppColors.border),
                child,
              ],
            ],
          ),
        ),
      ],
    );
  }
}
