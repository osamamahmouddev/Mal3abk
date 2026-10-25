import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({
    required this.title,
    super.key,
    this.actionText,
    this.onAction,
    this.actionColor = AppColors.brandNavy,
  });

  final String title;
  final String? actionText;
  final VoidCallback? onAction;
  final Color actionColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.font16Bold),
        if (actionText != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionText!,
              style: AppTextStyles.font13SemiBold.copyWith(
                color: actionColor,
                decoration: TextDecoration.underline,
                decorationColor: actionColor,
              ),
            ),
          ),
      ],
    );
  }
}
