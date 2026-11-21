import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import 'pitch_slot_grid_skeleton_widget.dart';

/// The pitch-and-time screen while it loads, in its real shape: the day
/// strip, the section title and the three-column slot grid, so nothing jumps
/// when the slots arrive.
class PitchAndTimeSkeletonWidget extends StatelessWidget {
  const PitchAndTimeSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final block = BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(14.r),
    );
    return TurfShimmerWidget(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                for (var i = 0; i < 6; i++) ...[
                  if (i > 0) vSpace(6),
                  Container(width: 52.w, height: 64.h, decoration: block),
                ],
              ],
            ),
            hSpace(16),
            Container(width: 130.w, height: 16.h, decoration: block),
            hSpace(14),
            const PitchSlotGridSkeletonWidget(shimmer: false),
          ],
        ),
      ),
    );
  }
}
