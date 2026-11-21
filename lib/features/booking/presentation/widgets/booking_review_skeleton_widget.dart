import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// Booking review while the slot and quote load, in the real screen's
/// shape: the pitch-and-time card, the price card, the hold notice and the
/// policy card, so nothing jumps once they arrive.
class BookingReviewSkeletonWidget extends StatelessWidget {
  const BookingReviewSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final card = BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: AppColors.borderCard),
    );

    return TurfShimmerWidget(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 112.h, decoration: card),
            hSpace(14),
            Container(height: 230.h, decoration: card),
            hSpace(14),
            Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            hSpace(14),
            Container(height: 70.h, decoration: card),
          ],
        ),
      ),
    );
  }
}
