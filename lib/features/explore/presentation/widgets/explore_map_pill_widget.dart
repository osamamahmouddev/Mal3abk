import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

/// Floating rounded label over the map (result count / "search this area").
class ExploreMapPillWidget extends StatelessWidget {
  const ExploreMapPillWidget({
    required this.label,
    super.key,
    this.dark = false,
    this.onTap,
  });

  final String label;
  final bool dark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final height = dark ? 38.0 : 30.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h,
        padding: EdgeInsets.symmetric(horizontal: (dark ? 14 : 10).w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: dark ? AppColors.brandNavy : AppColors.white,
          borderRadius: BorderRadius.circular((height / 2).r),
          boxShadow: [
            BoxShadow(
              color: dark ? AppColors.navyShadow20 : AppColors.navyShadow12,
              offset: Offset(0, 2.h),
              blurRadius: 8.r,
            ),
          ],
        ),
        child: Text(
          label,
          style: dark
              ? AppTextStyles.font13SemiBold.copyWith(color: AppColors.white)
              : AppTextStyles.font12SemiBold,
        ),
      ),
    );
  }
}
