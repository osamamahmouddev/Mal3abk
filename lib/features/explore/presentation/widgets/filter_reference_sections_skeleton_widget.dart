import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// The filter chip sections while they load, in the real sections' shape: a
/// title and a row of chip-sized blocks, so nothing jumps once the options
/// arrive.
class FilterReferenceSectionsSkeletonWidget extends StatelessWidget {
  const FilterReferenceSectionsSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final block = BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(8.r),
    );
    final chip = BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(10.r),
    );

    return TurfShimmerWidget(
      child: Column(
        children: [
          for (var section = 0; section < 3; section++)
            Container(
              padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.lightSurface),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 90.w, height: 15.h, decoration: block),
                  hSpace(14),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      for (var i = 0; i < 4; i++)
                        Container(width: 70.w, height: 40.h, decoration: chip),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
