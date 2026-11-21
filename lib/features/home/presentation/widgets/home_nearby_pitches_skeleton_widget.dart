import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// The nearby-pitches row while it loads, in the real cards' shape: a photo,
/// a title line, a distance line and a slot line, so nothing jumps when the
/// venues arrive.
class HomeNearbyPitchesSkeletonWidget extends StatelessWidget {
  const HomeNearbyPitchesSkeletonWidget({
    required this.padding,
    this.itemCount = 3,
    super.key,
  });

  final EdgeInsetsGeometry padding;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final block = BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(8.r),
    );

    return TurfShimmerWidget(
      child: SizedBox(
        height: 187.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: padding,
          clipBehavior: Clip.none,
          itemCount: itemCount,
          separatorBuilder: (_, _) => vSpace(12),
          itemBuilder: (context, index) => Container(
            width: 222.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.borderCard),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(height: 96.h, color: AppColors.lightSurface),
                Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 9.h, 12.w, 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120.w,
                        height: 14.h,
                        decoration: block,
                      ),
                      hSpace(8),
                      Container(width: 90.w, height: 11.h, decoration: block),
                      hSpace(8),
                      Container(
                        width: 100.w,
                        height: 11.h,
                        decoration: block,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
