import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import 'team_profile_variant.dart';

class TeamProfileFooterWidget extends StatelessWidget {
  const TeamProfileFooterWidget({required this.variant, super.key});

  final TeamProfileVariant variant;

  @override
  Widget build(BuildContext context) {
    void openChallenge() =>
        Navigator.of(context).pushNamed(AppRoutes.challengeTeam);

    if (variant == TeamProfileVariant.other) {
      return BottomActionBarWidget(
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'teams.profile.challenge'.tr(context: context),
                height: 54.h,
                borderRadius: 16,
                boxShadow: AppShadows.redGlow,
                textStyle: AppTextStyles.font16Bold.copyWith(
                  color: AppColors.white,
                ),
                onTap: openChallenge,
              ),
            ),
            vSpace(8),
            CustomButton(
              text: '',
              type: CustomButtonType.outline,
              width: 54.r,
              height: 54.r,
              borderRadius: 16,
              borderColor: AppColors.border,
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                AppAssets.icFlag,
                width: 20.r,
                height: 20.r,
              ),
              onTap: () {},
            ),
          ],
        ),
      );
    }

    return BottomActionBarWidget(
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'teams.profile.invite'.tr(context: context),
              type: CustomButtonType.outline,
              height: 52.h,
              borderRadius: 12,
              textStyle: AppTextStyles.font15SemiBold.copyWith(
                color: AppColors.brandNavy,
              ),
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.invitePlayers),
            ),
          ),
          vSpace(8),
          Expanded(
            child: CustomButton(
              text: 'teams.profile.find_opponent'.tr(context: context),
              type: CustomButtonType.secondary,
              height: 52.h,
              borderRadius: 12,
              textStyle: AppTextStyles.font15Bold.copyWith(
                color: AppColors.white,
              ),
              onTap: openChallenge,
            ),
          ),
        ],
      ),
    );
  }
}
