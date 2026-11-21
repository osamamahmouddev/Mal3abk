import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// A team card while it loads, in the real card's shape: avatar, two text
/// lines, a stats strip and an actions row, so nothing jumps when the teams
/// arrive.
class MyTeamsSkeletonWidget extends StatelessWidget {
  const MyTeamsSkeletonWidget({this.itemCount = 2, super.key});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final block = BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(8.r),
    );

    return TurfShimmerWidget(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.r),
        itemCount: itemCount,
        separatorBuilder: (_, _) => hSpace(12),
        itemBuilder: (_, _) => Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.borderCard),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(14.r),
                child: Row(
                  children: [
                    Container(
                      width: 48.r,
                      height: 48.r,
                      decoration: const BoxDecoration(
                        color: AppColors.lightSurface,
                        shape: BoxShape.circle,
                      ),
                    ),
                    vSpace(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 130.w,
                            height: 16.h,
                            decoration: block,
                          ),
                          hSpace(6),
                          Container(
                            width: 90.w,
                            height: 12.h,
                            decoration: block,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 1, color: AppColors.borderCard),
              Container(height: 62.h, color: AppColors.lightSurface),
              Container(height: 1, color: AppColors.borderCard),
              Container(height: 47.h),
            ],
          ),
        ),
      ),
    );
  }
}
