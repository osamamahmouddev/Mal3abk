import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/brand_wordmark_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/onboarding_feature_item_widget.dart';
import '../widgets/welcome_backdrop_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandNavy,
      body: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          const WelcomeBackdropWidget(),
          SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.w, 100.h, 24.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BrandWordmarkWidget(
                    titleStyle: AppTextStyles.font56Bold.copyWith(
                      color: AppColors.white,
                    ),
                    latinStyle: AppTextStyles.font20SemiBold.copyWith(
                      color: AppColors.onNavyMuted,
                    ),
                    accentColor: AppColors.redSoft,
                  ),
                  hSpace(36),
                  Text(
                    'onboarding.welcome.headline'.tr(context: context),
                    style: AppTextStyles.font28Bold.copyWith(
                      color: AppColors.white,
                      height: 40 / 28,
                    ),
                  ),
                  hSpace(24),
                  OnboardingFeatureItemWidget(
                    number: '١',
                    title: 'onboarding.welcome.feat1_title'.tr(context: context),
                    subtitle: 'onboarding.welcome.feat1_sub'.tr(context: context),
                  ),
                  hSpace(15),
                  OnboardingFeatureItemWidget(
                    number: '٢',
                    title: 'onboarding.welcome.feat2_title'.tr(context: context),
                    subtitle: 'onboarding.welcome.feat2_sub'.tr(context: context),
                  ),
                  hSpace(15),
                  OnboardingFeatureItemWidget(
                    number: '٣',
                    title: 'onboarding.welcome.feat3_title'.tr(context: context),
                    subtitle: 'onboarding.welcome.feat3_sub'.tr(context: context),
                  ),
                  const Spacer(),
                  CustomButton(
                    text: 'onboarding.welcome.start_phone'.tr(context: context),
                    height: 54.h,
                    borderRadius: 16,
                    textStyle: AppTextStyles.font17Bold.copyWith(
                      color: AppColors.white,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.redShadow,
                        offset: Offset(0, 10.h),
                        blurRadius: 22.r,
                        spreadRadius: -11.r,
                      ),
                    ],
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.login),
                  ),
                  hSpace(10),
                  CustomButton(
                    text: 'onboarding.welcome.explore_first'.tr(context: context),
                    type: CustomButtonType.outline,
                    height: 50.h,
                    borderRadius: 12,
                    borderColor: AppColors.white30,
                    textStyle: AppTextStyles.font15SemiBold.copyWith(
                      color: AppColors.white,
                    ),
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.main),
                  ),
                  hSpace(10),
                  Text(
                    'onboarding.welcome.terms_notice'.tr(context: context),
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.onNavySubtle,
                      height: 18 / 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
