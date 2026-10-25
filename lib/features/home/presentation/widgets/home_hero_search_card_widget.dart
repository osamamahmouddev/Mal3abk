import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../main_shell/presentation/widgets/main_shell_scope_widget.dart';
import 'home_hero_pill_widget.dart';

class HomeHeroSearchCardWidget extends StatelessWidget {
  const HomeHeroSearchCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.brandNavy,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AppAssets.homeHeroPattern,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'home.play_prompt'.tr(context: context),
                  style: AppTextStyles.font18Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                hSpace(18),
                Row(
                  children: [
                    Expanded(
                      child: HomeHeroPillWidget(
                        iconAsset: AppAssets.icCalendarWhite,
                        label: 'home.today'.tr(context: context),
                      ),
                    ),
                    vSpace(8),
                    Expanded(
                      child: HomeHeroPillWidget(
                        iconAsset: AppAssets.icClockWhite,
                        label: 'home.default_time'.tr(context: context),
                      ),
                    ),
                  ],
                ),
                hSpace(12),
                CustomButton(
                  text: 'home.search_pitch'.tr(context: context),
                  icon: SvgPicture.asset(
                    AppAssets.icSearchWhite,
                    width: 18.r,
                    height: 18.r,
                  ),
                  height: 50.h,
                  borderRadius: 12,
                  boxShadow: AppShadows.redGlow,
                  textStyle: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.white,
                  ),
                  onTap: () => MainShellScopeWidget.switchTab(
                    context,
                    MainShellScopeWidget.exploreTab,
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
