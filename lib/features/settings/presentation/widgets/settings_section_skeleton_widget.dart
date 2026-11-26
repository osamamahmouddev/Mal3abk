import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/turf_shimmer_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';

/// A settings section while it loads, in the real card's shape: a title bar
/// and [rowCount] switch rows (a title line, a subtitle line and a toggle),
/// separated by dividers, so nothing jumps when the preferences arrive.
class SettingsSectionSkeletonWidget extends StatelessWidget {
  const SettingsSectionSkeletonWidget({required this.rowCount, super.key});

  final int rowCount;

  @override
  Widget build(BuildContext context) {
    final block = BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(8.r),
    );

    return TurfShimmerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(width: 120.w, height: 15.h, decoration: block),
          hSpace(8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.borderCard),
            ),
            child: Column(
              children: [
                for (var i = 0; i < rowCount; i++) ...[
                  if (i > 0)
                    const Divider(height: 1, color: AppColors.border),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 130.w,
                                height: 13.h,
                                decoration: block,
                              ),
                              hSpace(6),
                              Container(
                                width: 190.w,
                                height: 11.h,
                                decoration: block,
                              ),
                            ],
                          ),
                        ),
                        vSpace(12),
                        Container(
                          width: 36.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: AppColors.lightSurface,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
