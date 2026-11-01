import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class DepositTimerBannerWidget extends StatelessWidget {
  const DepositTimerBannerWidget({required this.remaining, super.key});

  final String remaining;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 14.h),
      decoration: BoxDecoration(
        color: AppColors.goldLight,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: SvgPicture.asset(
              AppAssets.icClockGold,
              width: 22.r,
              height: 22.r,
            ),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'booking.deposit.timer_title'.tr(
                    context: context,
                    args: [remaining],
                  ),
                  style: AppTextStyles.font15Bold.copyWith(
                    color: AppColors.goldDark,
                  ),
                ),
                hSpace(6),
                Text(
                  'booking.deposit.timer_body'.tr(context: context),
                  style: AppTextStyles.font13Regular.copyWith(
                    color: AppColors.goldText,
                    height: 20 / 13,
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
