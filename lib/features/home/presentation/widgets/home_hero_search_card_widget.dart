import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class HomeHeroSearchCardWidget extends StatelessWidget {
  const HomeHeroSearchCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.brandNavy,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'home.play_prompt'.tr(context: context),
            style: AppTextStyles.font18Bold.copyWith(color: AppColors.white),
          ),
          hSpace(14),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, size: 16.sp, color: AppColors.white),
                      vSpace(8),
                      Text(
                        'home.today'.tr(context: context),
                        style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
              vSpace(10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time_rounded, size: 16.sp, color: AppColors.white),
                      vSpace(8),
                      Text(
                        'home.default_time'.tr(context: context),
                        style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          hSpace(14),
          CustomButton(
            text: 'home.search_pitch'.tr(context: context),
            icon: Icon(Icons.search_rounded, size: 20.sp, color: AppColors.white),
            type: CustomButtonType.primary,
            height: 48.h,
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.exploreList),
          ),
        ],
      ),
    );
  }
}
