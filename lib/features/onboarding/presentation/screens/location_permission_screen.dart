import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/primary_cta_button_widget.dart';
import '../widgets/location_illustration_widget.dart';
import '../widgets/onboarding_step_header_widget.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OnboardingStepHeaderWidget(
                stepLabel: 'onboarding.location.step'.tr(context: context),
                completedSteps: 2,
              ),
              hSpace(48),
              const Center(child: LocationIllustrationWidget()),
              hSpace(17),
              Text(
                'onboarding.location.title'.tr(context: context),
                style: AppTextStyles.font22Bold,
                textAlign: TextAlign.center,
              ),
              hSpace(26),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  'onboarding.location.desc'.tr(context: context),
                  style: AppTextStyles.font14Regular.copyWith(height: 23 / 14),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              PrimaryCtaButtonWidget(
                text: 'onboarding.location.allow'.tr(context: context),
                onTap: () => Navigator.of(context)
                    .pushNamed(AppRoutes.notificationsPermission),
              ),
              hSpace(8),
              CustomButton(
                text: 'onboarding.location.manual'.tr(context: context),
                type: CustomButtonType.outline,
                height: 48.h,
                borderRadius: 12,
                backgroundColor: AppColors.white,
                textStyle: AppTextStyles.font15SemiBold.copyWith(
                  color: AppColors.brandNavy,
                ),
                onTap: () => Navigator.of(context)
                    .pushNamed(AppRoutes.notificationsPermission),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
