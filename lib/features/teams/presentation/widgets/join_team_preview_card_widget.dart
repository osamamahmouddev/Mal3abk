import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';

class JoinTeamPreviewCardWidget extends StatelessWidget {
  const JoinTeamPreviewCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 18.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.brandNavy, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 56.r,
                height: 56.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.brandRed,
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.redGlow,
                ),
                child: Text(
                  'teams.sample.nogoum_i'.tr(context: context),
                  style: AppTextStyles.font20Bold.copyWith(color: AppColors.white),
                ),
              ),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('teams.profile.mine_name'.tr(context: context), style: AppTextStyles.font17Bold),
                    hSpace(2),
                    Text('teams.join.team_meta'.tr(context: context), style: AppTextStyles.font13Regular),
                    hSpace(2),
                    Text('teams.join.captain'.tr(context: context), style: AppTextStyles.font12Regular),
                  ],
                ),
              ),
            ],
          ),
          hSpace(12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.lightGrayBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'teams.join.privacy_note'.tr(context: context),
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textBody,
                height: 20 / 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
