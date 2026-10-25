import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import 'explore_map_shape_widget.dart';

/// Static illustrated map (parks, roads, street labels, user location).
class ExploreMapBackdropWidget extends StatelessWidget {
  const ExploreMapBackdropWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final labelStyle = AppTextStyles.font11Regular.copyWith(
      color: AppColors.mapLabel,
    );

    return RepaintBoundary(
      child: Container(
        color: AppColors.mapBackground,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              left: 30.w,
              top: 300.h,
              child: Container(
                width: 150.w,
                height: 120.h,
                decoration: BoxDecoration(
                  color: AppColors.mapPark,
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
            ),
            Positioned(
              left: 250.w,
              top: 560.h,
              child: Container(
                width: 120.w,
                height: 90.h,
                decoration: BoxDecoration(
                  color: AppColors.mapPark,
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),
            const ExploreMapShapeWidget(
              centerX: 220,
              centerY: 259,
              width: 520,
              height: 18,
              degrees: -12,
              color: AppColors.white,
            ),
            const ExploreMapShapeWidget(
              centerX: 220,
              centerY: 533,
              width: 520,
              height: 26,
              degrees: 8,
              color: AppColors.white,
            ),
            const ExploreMapShapeWidget(
              centerX: 158,
              centerY: 500,
              width: 16,
              height: 760,
              degrees: 14,
              color: AppColors.white,
            ),
            const ExploreMapShapeWidget(
              centerX: 276,
              centerY: 480,
              width: 12,
              height: 760,
              degrees: -6,
              color: AppColors.white,
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 420.h,
              child: Container(height: 10.h, color: AppColors.white),
            ),
            ExploreMapShapeWidget(
              centerX: 233,
              centerY: 508,
              width: 90,
              height: 17,
              degrees: 8,
              child: Text(
                'explore.street_abbas'.tr(context: context),
                style: labelStyle,
                maxLines: 1,
              ),
            ),
            ExploreMapShapeWidget(
              centerX: 72,
              centerY: 236,
              width: 80,
              height: 17,
              degrees: -12,
              child: Text(
                'explore.street_makram'.tr(context: context),
                style: labelStyle,
                maxLines: 1,
              ),
            ),
            Positioned(
              left: 180.w,
              top: 450.h,
              child: Container(
                width: 30.r,
                height: 30.r,
                decoration: BoxDecoration(
                  color: AppColors.mapUserDot,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
