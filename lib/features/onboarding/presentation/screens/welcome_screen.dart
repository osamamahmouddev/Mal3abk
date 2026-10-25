import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/onboarding_feature_item_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  AppAssets.logoStacked,
                  width: 140.w,
                  fit: BoxFit.contain,
                ),
              ),
              hSpace(16),
              Text(
                'onboarding.welcome.headline'.tr(context: context),
                style: AppTextStyles.font20Bold,
                textAlign: TextAlign.center,
              ),
              hSpace(32),
              OnboardingFeatureItemWidget(
                number: '١',
                title: 'onboarding.welcome.feat1_title'.tr(context: context),
                subtitle: 'onboarding.welcome.feat1_sub'.tr(context: context),
              ),
              hSpace(18),
              OnboardingFeatureItemWidget(
                number: '٢',
                title: 'onboarding.welcome.feat2_title'.tr(context: context),
                subtitle: 'onboarding.welcome.feat2_sub'.tr(context: context),
              ),
              hSpace(18),
              OnboardingFeatureItemWidget(
                number: '٣',
                title: 'onboarding.welcome.feat3_title'.tr(context: context),
                subtitle: 'onboarding.welcome.feat3_sub'.tr(context: context),
              ),
              const Spacer(),
              CustomButton(
                text: 'onboarding.welcome.start_phone'.tr(context: context),
                type: CustomButtonType.primary,
                height: 54.h,
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.login),
              ),
              hSpace(12),
              CustomButton(
                text: 'onboarding.welcome.explore_first'.tr(context: context),
                type: CustomButtonType.outline,
                height: 50.h,
                onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
              ),
              hSpace(16),
              Text(
                'onboarding.welcome.terms_notice'.tr(context: context),
                style: AppTextStyles.font11Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
