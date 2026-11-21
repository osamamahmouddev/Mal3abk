import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../animations/turf_shimmer_widget.dart';
import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import 'custom_card_widget.dart';

/// A pitch card while it loads, in [PitchCardWidget]'s real shape: the
/// thumbnail, two text lines, the price line and the slot chips, so nothing
/// jumps once the venue arrives.
class PitchCardSkeletonWidget extends StatelessWidget {
  const PitchCardSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final block = BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(8.r),
    );

    return TurfShimmerWidget(
      child: CustomCardWidget(
        padding: EdgeInsets.all(12.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 88.r,
              height: 88.r,
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 140.w, height: 16.h, decoration: block),
                  hSpace(8),
                  Container(width: 100.w, height: 12.h, decoration: block),
                  hSpace(10),
                  Container(width: 90.w, height: 16.h, decoration: block),
                  hSpace(12),
                  Row(
                    children: [
                      Container(width: 64.w, height: 34.h, decoration: block),
                      vSpace(8),
                      Container(width: 64.w, height: 34.h, decoration: block),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
