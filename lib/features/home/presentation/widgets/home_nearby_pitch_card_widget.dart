import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class HomeNearbyPitchCardWidget extends StatelessWidget {
  const HomeNearbyPitchCardWidget({
    required this.name,
    required this.rating,
    required this.dist,
    required this.slot,
    required this.onTap,
    super.key,
  });

  final String name;
  final String rating;
  final String dist;
  final String slot;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: 210.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.borderCard, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90.h,
              decoration: BoxDecoration(
                color: AppColors.pitchGreen,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Icon(Icons.sports_soccer_rounded, size: 36.sp, color: AppColors.white),
              ),
            ),
            hSpace(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(name, style: AppTextStyles.font14Bold, maxLines: 1)),
                Row(
                  children: [
                    Icon(Icons.star_rounded, size: 14.sp, color: AppColors.goldDark),
                    vSpace(2),
                    Text(rating, style: AppTextStyles.font12Bold.copyWith(color: AppColors.goldDark)),
                  ],
                ),
              ],
            ),
            hSpace(4),
            Text(dist, style: AppTextStyles.font12Regular),
            hSpace(6),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(slot, style: AppTextStyles.font11Bold.copyWith(color: AppColors.successGreen)),
            ),
          ],
        ),
      ),
    );
  }
}
