import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class ProfileStatWidget extends StatelessWidget {
  const ProfileStatWidget({
    required this.value,
    required this.label,
    super.key,
    this.valueColor = AppColors.white,
  });

  final String value;
  final String label;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      decoration: BoxDecoration(
        color: AppColors.white8,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: AppTextStyles.font18Bold.copyWith(color: valueColor),
          ),
          hSpace(2),
          Text(
            label,
            style: AppTextStyles.font11Regular.copyWith(
              color: AppColors.onNavyMuted,
            ),
          ),
        ],
      ),
    );
  }
}
