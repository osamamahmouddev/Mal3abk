import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// The team-activity card while it loads, in the real card's shape: a round
/// avatar and two text lines, so nothing jumps when the activity arrives.
class HomeTeamActivitySkeletonWidget extends StatelessWidget {
  const HomeTeamActivitySkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final block = BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(8.r),
    );

    return TurfShimmerWidget(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.borderCard),
        ),
        child: Row(
          children: [
            Container(
              width: 36.r,
              height: 36.r,
              decoration: const BoxDecoration(
                color: AppColors.lightSurface,
                shape: BoxShape.circle,
              ),
            ),
            vSpace(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 160.w, height: 14.h, decoration: block),
                  hSpace(6),
                  Container(width: 110.w, height: 11.h, decoration: block),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
