import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// The venue profile while it loads, in the real screen's shape: the photo
/// hero, the name and address, the tab bar and a couple of pitch cards, so
/// nothing jumps when the venue arrives.
class VenueProfileSkeletonWidget extends StatelessWidget {
  const VenueProfileSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final block = BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(8.r),
    );

    return TurfShimmerWidget(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 230.h, color: AppColors.lightSurface),
            Container(
              color: AppColors.white,
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 180.w, height: 20.h, decoration: block),
                  hSpace(12),
                  Container(width: 140.w, height: 13.h, decoration: block),
                ],
              ),
            ),
            Container(
              height: 48.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              color: AppColors.white,
              child: Row(
                children: [
                  for (var i = 0; i < 3; i++) ...[
                    if (i > 0) vSpace(24),
                    Container(width: 70.w, height: 14.h, decoration: block),
                  ],
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
              child: Column(
                children: [
                  for (var i = 0; i < 2; i++) ...[
                    if (i > 0) hSpace(14),
                    Container(
                      height: 140.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(color: AppColors.borderCard),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
