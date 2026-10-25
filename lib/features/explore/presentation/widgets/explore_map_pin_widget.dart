import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';

enum ExploreMapPinType { normal, selected, booked }

class ExploreMapPinWidget extends StatelessWidget {
  const ExploreMapPinWidget({
    required this.label,
    super.key,
    this.type = ExploreMapPinType.normal,
    this.onTap,
  });

  final String label;
  final ExploreMapPinType type;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = type == ExploreMapPinType.selected;
    final isBooked = type == ExploreMapPinType.booked;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: (isSelected ? 38 : 34).h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: switch (type) {
            ExploreMapPinType.selected => AppColors.brandRed,
            ExploreMapPinType.booked => AppColors.lightSurface,
            ExploreMapPinType.normal => AppColors.brandNavy,
          },
          borderRadius: BorderRadius.circular(19.r),
          border: Border.all(
            color: isBooked ? AppColors.borderInput : AppColors.white,
            width: isBooked ? 1 : 2,
          ),
          boxShadow: isSelected
              ? AppShadows.redGlow
              : [
                  BoxShadow(
                    color: AppColors.navyShadow20,
                    offset: Offset(0, 2.h),
                    blurRadius: 6.r,
                  ),
                ],
        ),
        child: Text(
          label,
          style: AppTextStyles.font13Bold.copyWith(
            color: isBooked ? AppColors.textSecondary : AppColors.white,
          ),
        ),
      ),
    );
  }
}
