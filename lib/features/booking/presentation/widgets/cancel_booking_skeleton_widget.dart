import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// Cancel-booking while the preview loads, in the real screen's shape: the
/// refund box, the reason label and four selectable tiles, so nothing jumps
/// once the preview arrives.
class CancelBookingSkeletonWidget extends StatelessWidget {
  const CancelBookingSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final block = BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(8.r),
    );

    return TurfShimmerWidget(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 92.h,
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            hSpace(18),
            Container(width: 120.w, height: 15.h, decoration: block),
            hSpace(10),
            for (var i = 0; i < 4; i++) ...[
              Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.borderCard),
                ),
              ),
              hSpace(8),
            ],
          ],
        ),
      ),
    );
  }
}
