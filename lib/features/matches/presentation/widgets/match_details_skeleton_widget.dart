import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// Match details while it loads, in the real screen's shape: the matchup
/// header, the status banner and the details card, so nothing jumps once
/// the match arrives.
class MatchDetailsSkeletonWidget extends StatelessWidget {
  const MatchDetailsSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final card = BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(18.r),
      border: Border.all(color: AppColors.borderCard),
    );

    return TurfShimmerWidget(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 140.h,
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            hSpace(14),
            Container(
              height: 56.h,
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            hSpace(14),
            Container(height: 96.h, decoration: card),
          ],
        ),
      ),
    );
  }
}
