import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class HomeLocationHeaderWidget extends StatelessWidget {
  const HomeLocationHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'home.current_location'.tr(context: context),
                style: AppTextStyles.font11Regular,
              ),
              hSpace(2),
              Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 16.sp,
                    color: AppColors.brandRed,
                  ),
                  vSpace(4),
                  Text(
                    'home.default_city'.tr(context: context),
                    style: AppTextStyles.font15Bold,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18.sp,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.notifications),
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            width: 44.w,
            height: 44.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: Stack(
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  size: 24.sp,
                  color: AppColors.brandNavy,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 9.w,
                    height: 9.h,
                    decoration: const BoxDecoration(
                      color: AppColors.brandRed,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
