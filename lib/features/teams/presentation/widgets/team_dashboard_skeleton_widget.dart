import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// The team dashboard while it loads, in the real screen's shape: the navy
/// hero with its avatar, the stat grid and the list sections below, so
/// nothing jumps when the dashboard arrives.
class TeamDashboardSkeletonWidget extends StatelessWidget {
  const TeamDashboardSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final onDark = BoxDecoration(
      color: AppColors.white18,
      borderRadius: BorderRadius.circular(8.r),
    );
    final block = BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(8.r),
    );

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TurfShimmerWidget(
            child: Container(
              color: AppColors.brandNavy,
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 18.h),
              child: Column(
                children: [
                  hSpace(44.h),
                  Container(
                    width: 86.r,
                    height: 86.r,
                    decoration: const BoxDecoration(
                      color: AppColors.white18,
                      shape: BoxShape.circle,
                    ),
                  ),
                  hSpace(12),
                  Container(width: 140.w, height: 18.h, decoration: onDark),
                  hSpace(10),
                  Container(width: 190.w, height: 12.h, decoration: onDark),
                  hSpace(12),
                  Container(width: 110.w, height: 27.h, decoration: onDark),
                ],
              ),
            ),
          ),
          TurfShimmerWidget(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      for (var i = 0; i < 3; i++) ...[
                        if (i > 0) vSpace(8),
                        Expanded(
                          child: Container(height: 69.h, decoration: block),
                        ),
                      ],
                    ],
                  ),
                  hSpace(8),
                  Row(
                    children: [
                      for (var i = 0; i < 3; i++) ...[
                        if (i > 0) vSpace(8),
                        Expanded(
                          child: Container(height: 69.h, decoration: block),
                        ),
                      ],
                    ],
                  ),
                  hSpace(24),
                  for (var section = 0; section < 2; section++) ...[
                    if (section > 0) hSpace(24),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Container(
                        width: 130.w,
                        height: 15.h,
                        decoration: block,
                      ),
                    ),
                    hSpace(14),
                    Container(
                      height: 72.h,
                      decoration: BoxDecoration(
                        color: AppColors.lightSurface,
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
