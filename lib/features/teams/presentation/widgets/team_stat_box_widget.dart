import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class TeamStatBoxWidget extends StatelessWidget {
  const TeamStatBoxWidget({
    required this.value,
    required this.label,
    super.key,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.font20Bold.copyWith(color: AppColors.brandNavy),
        ),
        hSpace(2),
        Text(label, style: AppTextStyles.font11Regular),
      ],
    );
  }
}
