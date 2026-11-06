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
import '../../../../core/widgets/custom_button.dart';

class MyTeamsHeaderActionsWidget extends StatelessWidget {
  const MyTeamsHeaderActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final labelStyle = AppTextStyles.font13SemiBold.copyWith(
      color: AppColors.brandNavy,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomButton(
          text: 'teams.list.rankings'.tr(context: context),
          type: CustomButtonType.ghost,
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          textStyle: labelStyle,
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.rankings),
        ),
        vSpace(8),
        CustomButton(
          text: 'teams.list.join_code'.tr(context: context),
          type: CustomButtonType.outline,
          height: 42.h,
          borderRadius: 10,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          textStyle: labelStyle,
          onTap: () =>
              Navigator.of(context).pushNamed(AppRoutes.joinTeamByCode),
        ),
        vSpace(8),
        CustomButton(
          text: 'teams.list.new_team'.tr(context: context),
          height: 40.h,
          borderRadius: 10,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          boxShadow: AppShadows.redGlow,
          icon: SvgPicture.asset(
            AppAssets.icPlusWhite,
            width: 16.r,
            height: 16.r,
          ),
          textStyle: AppTextStyles.font14Bold.copyWith(color: AppColors.white),
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.createTeam),
        ),
      ],
    );
  }
}
