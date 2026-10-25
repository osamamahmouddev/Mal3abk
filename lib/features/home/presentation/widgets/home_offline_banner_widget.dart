import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class HomeOfflineBannerWidget extends StatelessWidget {
  const HomeOfflineBannerWidget({
    required this.lastLoadedAt,
    required this.onRetry,
    super.key,
  });

  final String lastLoadedAt;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offlineBanner,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          SvgPicture.asset(AppAssets.icWifiOff, width: 18.r, height: 18.r),
          vSpace(9),
          Expanded(
            child: Text(
              'home.offline_message'.tr(context: context, args: [lastLoadedAt]),
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          vSpace(12),
          CustomButton(
            text: 'home.retry'.tr(context: context),
            type: CustomButtonType.outline,
            height: 32.h,
            borderRadius: 8,
            borderColor: AppColors.white40,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            textStyle: AppTextStyles.font12SemiBold.copyWith(
              color: AppColors.white,
            ),
            onTap: onRetry,
          ),
        ],
      ),
    );
  }
}
