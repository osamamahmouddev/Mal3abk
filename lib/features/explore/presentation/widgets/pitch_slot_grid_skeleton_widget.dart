import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/styles/app_colors.dart';

/// The slot grid while a day or pitch loads: the same three columns and tile
/// shape as the real slots.
class PitchSlotGridSkeletonWidget extends StatelessWidget {
  const PitchSlotGridSkeletonWidget({
    this.rows = 4,
    this.shimmer = true,
    super.key,
  });

  final int rows;

  /// False inside a skeleton that already shimmers.
  final bool shimmer;

  @override
  Widget build(BuildContext context) {
    final grid = GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 1.8,
      ),
      itemCount: rows * 3,
      itemBuilder: (_, _) => DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
    return shimmer ? TurfShimmerWidget(child: grid) : grid;
  }
}
