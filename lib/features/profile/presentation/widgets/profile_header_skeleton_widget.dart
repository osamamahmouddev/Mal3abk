import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_skeleton_widget.dart';

/// The profile header while it loads: the same navy block, with soft pulsing
/// shapes where the avatar, name and stats will be.
class ProfileHeaderSkeletonWidget extends StatelessWidget {
  const ProfileHeaderSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.brandNavy,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 20.h),
          child: Column(
            children: [
              Row(
                children: [
                  CustomSkeletonWidget(
                    width: 72.r,
                    height: 72.r,
                    borderRadius: 36,
                    color: AppColors.white8,
                  ),
                  vSpace(14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSkeletonWidget(
                          width: 150.w,
                          height: 20.h,
                          color: AppColors.white8,
                        ),
                        hSpace(10),
                        CustomSkeletonWidget(
                          width: 100.w,
                          height: 13.h,
                          color: AppColors.white8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              hSpace(16),
              Row(
                children: [
                  for (var i = 0; i < 3; i++) ...[
                    if (i > 0) vSpace(8),
                    Expanded(
                      child: CustomSkeletonWidget(
                        height: 64.h,
                        borderRadius: 12,
                        color: AppColors.white8,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
