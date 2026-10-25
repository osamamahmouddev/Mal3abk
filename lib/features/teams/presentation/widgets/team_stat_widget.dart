import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class TeamStatWidget extends StatelessWidget {
  const TeamStatWidget({
    required this.value,
    required this.label,
    super.key,
    this.isRank = false,
  });

  final String value;
  final String label;
  final bool isRank;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.font16Bold.copyWith(
            color: isRank ? AppColors.brandRed : AppColors.textPrimary,
          ),
        ),
        hSpace(2),
        Text(label, style: AppTextStyles.font11Regular),
      ],
    );
  }
}
