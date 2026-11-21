import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// Booking details while it loads, in the real pass's shape: the navy hero,
/// the QR/actions card and the payment card, so nothing jumps when the
/// booking arrives.
class BookingDetailsSkeletonWidget extends StatelessWidget {
  const BookingDetailsSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final onDark = BoxDecoration(
      color: AppColors.white18,
      borderRadius: BorderRadius.circular(8.r),
    );
    final card = BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(18.r),
      border: Border.all(color: AppColors.borderCard),
    );

    return TurfShimmerWidget(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.brandNavy,
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 100.w, height: 20.h, decoration: onDark),
                  hSpace(14),
                  Container(width: 180.w, height: 16.h, decoration: onDark),
                  hSpace(10),
                  Container(width: 130.w, height: 13.h, decoration: onDark),
                  hSpace(20),
                  Container(height: 44.h, decoration: onDark),
                ],
              ),
            ),
            hSpace(12),
            Container(height: 180.h, decoration: card),
            hSpace(12),
            Container(height: 56.h, decoration: card),
            hSpace(12),
            Container(height: 120.h, decoration: card),
          ],
        ),
      ),
    );
  }
}
