import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_font_family.dart';
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
    final isZero = value == '٠' || value == '0';
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.font16Bold.copyWith(
            color: isRank ? AppColors.goldDark : AppColors.textPrimary,
            fontFamily: AppFontFamily.fustat,
            fontSize: isZero ? 20.sp : 16.sp,
          ),
        ),
        hSpace(4),
        Text(label, style: AppTextStyles.font11Regular),
      ],
    );
  }
}
