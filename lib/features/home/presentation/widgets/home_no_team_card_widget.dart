import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class HomeNoTeamCardWidget extends StatelessWidget {
  const HomeNoTeamCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderInput),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'home.no_team_title'.tr(context: context),
                  style: AppTextStyles.font14Bold,
                ),
                hSpace(6),
                Text(
                  'home.no_team_sub'.tr(context: context),
                  style: AppTextStyles.font12Regular,
                ),
              ],
            ),
          ),
          vSpace(10),
          CustomButton(
            text: 'home.create_team'.tr(context: context),
            type: CustomButtonType.secondary,
            height: 40.h,
            borderRadius: 10,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            textStyle: AppTextStyles.font13Bold.copyWith(
              color: AppColors.white,
            ),
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.createTeam),
          ),
          vSpace(10),
          CustomButton(
            text: 'home.have_code'.tr(context: context),
            type: CustomButtonType.outline,
            height: 42.h,
            borderRadius: 10,
            borderColor: AppColors.borderInput,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            textStyle: AppTextStyles.font13SemiBold.copyWith(
              color: AppColors.brandNavy,
            ),
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.joinTeamByCode),
          ),
        ],
      ),
    );
  }
}
