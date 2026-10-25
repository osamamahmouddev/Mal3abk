import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class ProofRejectedBannerWidget extends StatelessWidget {
  const ProofRejectedBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.redLight,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.redBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 32.r,
                height: 32.r,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.redText,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '✕',
                  style: AppTextStyles.font14Bold.copyWith(color: AppColors.white),
                ),
              ),
              vSpace(10),
              Expanded(
                child: Text(
                  'booking.rejected.title'.tr(context: context),
                  style: AppTextStyles.font17Bold.copyWith(color: AppColors.redDark),
                ),
              ),
            ],
          ),
          hSpace(10),
          Container(
            padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 10.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'booking.rejected.reason_meta'.tr(context: context),
                  style: AppTextStyles.font12Regular,
                ),
                hSpace(6),
                Text(
                  'booking.rejected.reason'.tr(context: context),
                  style: AppTextStyles.font14SemiBold.copyWith(height: 22 / 14),
                ),
              ],
            ),
          ),
          hSpace(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: SvgPicture.asset(AppAssets.icClockRed, width: 16.r, height: 16.r),
              ),
              vSpace(7),
              Expanded(
                child: Text(
                  'booking.rejected.hold'.tr(context: context),
                  style: AppTextStyles.font13Regular.copyWith(
                    color: AppColors.redDark,
                    height: 20 / 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
