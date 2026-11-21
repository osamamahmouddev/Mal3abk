import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// Upload proof while the booking loads, in the real form's shape: the
/// booking summary card, the photo dropzone and the sender field, so
/// nothing jumps once the form appears.
class UploadProofSkeletonWidget extends StatelessWidget {
  const UploadProofSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final block = BoxDecoration(
      color: AppColors.lightSurface,
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
            Container(height: 72.h, decoration: card),
            hSpace(14),
            Container(
              height: 160.h,
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            hSpace(14),
            Container(width: 120.w, height: 14.h, decoration: block),
            hSpace(12),
            Container(
              height: 52.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.borderInput),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
