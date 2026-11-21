import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// The upcoming-booking card while it loads, in the real card's shape: a
/// thumbnail, two text lines and a status badge, so nothing jumps when the
/// booking arrives.
class HomeUpcomingBookingSkeletonWidget extends StatelessWidget {
  const HomeUpcomingBookingSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final block = BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(8.r),
    );

    return TurfShimmerWidget(
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.borderCard),
        ),
        child: Row(
          children: [
            Container(
              width: 56.r,
              height: 56.r,
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            vSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 140.w, height: 14.h, decoration: block),
                  hSpace(8),
                  Container(width: 90.w, height: 11.h, decoration: block),
                ],
              ),
            ),
            Container(
              width: 56.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(13.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
