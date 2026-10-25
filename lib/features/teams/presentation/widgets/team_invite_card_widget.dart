import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/initials_avatar_widget.dart';

class TeamInviteCardWidget extends StatelessWidget {
  const TeamInviteCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.accentGold, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              InitialsAvatarWidget(
                initials: 'teams.sample.abtal_i'.tr(context: context),
                color: AppColors.successGreen,
                size: 44,
              ),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'teams.list.new_invite'.tr(context: context),
                      style: AppTextStyles.font12Bold.copyWith(color: AppColors.goldDark),
                    ),
                    hSpace(2),
                    Text(
                      'teams.list.invite_title'.tr(context: context),
                      style: AppTextStyles.font14Bold,
                    ),
                    hSpace(4),
                    Text(
                      'teams.list.invite_meta'.tr(context: context),
                      style: AppTextStyles.font12Regular,
                    ),
                  ],
                ),
              ),
            ],
          ),
          hSpace(14),
          Row(
            children: [
              Expanded(
                flex: 111,
                child: CustomButton(
                  text: 'teams.list.decline'.tr(context: context),
                  type: CustomButtonType.outline,
                  height: 44.h,
                  borderRadius: 10,
                  backgroundColor: AppColors.white,
                  textStyle: AppTextStyles.font14SemiBold.copyWith(
                    color: AppColors.brandNavy,
                  ),
                  onTap: () {},
                ),
              ),
              vSpace(8),
              Expanded(
                flex: 207,
                child: CustomButton(
                  text: 'teams.list.join'.tr(context: context),
                  type: CustomButtonType.secondary,
                  height: 44.h,
                  borderRadius: 10,
                  textStyle: AppTextStyles.font14Bold.copyWith(color: AppColors.white),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
