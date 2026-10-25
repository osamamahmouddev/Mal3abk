import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';

class HomeTeamActivityCardWidget extends StatelessWidget {
  const HomeTeamActivityCardWidget({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14.r);

    return Material(
      color: AppColors.goldLight,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.brandRed,
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.redGlow,
                ),
                child: Text(
                  'teams.sample.nogoum_i'.tr(context: context),
                  style: AppTextStyles.font13Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              vSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'home.sample_challenge_text'.tr(context: context),
                      style: AppTextStyles.font14Bold.copyWith(
                        color: AppColors.goldText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    hSpace(2),
                    Text(
                      'home.sample_challenge_time'.tr(context: context),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.goldText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
