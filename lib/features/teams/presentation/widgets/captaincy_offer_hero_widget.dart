import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class CaptaincyOfferHeroWidget extends StatelessWidget {
  const CaptaincyOfferHeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.brandNavy,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AppAssets.captaincyPattern,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40.w, 22.h, 40.w, 24.h),
            child: Column(
              children: [
                Container(
                  width: 78.r,
                  height: 78.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.brandRed,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.accentGold, width: 3),
                  ),
                  child: Text(
                    'teams.sample.nogoum_i'.tr(context: context),
                    style: AppTextStyles.font24Bold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                hSpace(10),
                Container(
                  height: 24.h,
                  padding: EdgeInsets.symmetric(horizontal: 9.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.accentGold,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'teams.captaincy.badge'.tr(context: context),
                    style: AppTextStyles.font12Bold.copyWith(
                      color: AppColors.brandNavy,
                    ),
                  ),
                ),
                hSpace(10),
                Text(
                  'teams.captaincy.headline'.tr(context: context),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font20Bold.copyWith(
                    color: AppColors.white,
                    height: 30 / 20,
                  ),
                ),
                hSpace(6),
                Text(
                  'teams.captaincy.valid'.tr(context: context),
                  style: AppTextStyles.font13Regular.copyWith(
                    color: AppColors.onNavyMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
