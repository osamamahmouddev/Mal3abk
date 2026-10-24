import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class SplashBodyWidget extends StatelessWidget {
  const SplashBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: AppColors.brandPrimary,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.sports_soccer,
              size: 56.r,
              color: AppColors.white,
            ),
          ),
          hSpace(24),
          Text(
            'app.name'.tr(),
            style: AppTextStyles.font32Bold.copyWith(
              color: AppColors.brandPrimary,
            ),
          ),
          hSpace(8),
          Text(
            'auth.login_prompt'.tr(),
            style: AppTextStyles.font14Regular,
          ),
        ],
      ),
    );
  }
}
