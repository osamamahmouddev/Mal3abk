import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class AttendanceChipWidget extends StatelessWidget {
  const AttendanceChipWidget({
    required this.name,
    required this.isComing,
    super.key,
  });

  final String name;
  final bool isComing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isComing ? AppColors.successLight : AppColors.redLight,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        name,
        style: AppTextStyles.font11Bold.copyWith(
          color: isComing ? AppColors.successGreen : AppColors.redText,
        ),
      ),
    );
  }
}
