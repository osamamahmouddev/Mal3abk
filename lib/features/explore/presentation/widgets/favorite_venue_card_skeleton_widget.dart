import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// A favorite-venue card while it loads, in the real card's shape: the photo
/// banner, two text lines and the view button, so nothing jumps once the
/// venue arrives.
class FavoriteVenueCardSkeletonWidget extends StatelessWidget {
  const FavoriteVenueCardSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final block = BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(8.r),
    );

    return TurfShimmerWidget(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.borderCard),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 120.h, color: AppColors.lightSurface),
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 150.w, height: 16.h, decoration: block),
                  hSpace(8),
                  Container(width: 110.w, height: 12.h, decoration: block),
                  hSpace(12),
                  Container(
                    height: 46.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.borderInput),
                    ),
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
