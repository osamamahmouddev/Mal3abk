import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.brandNavy,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'onboarding.location.step'.tr(context: context),
                    style: AppTextStyles.font13Regular,
                  ),
                ],
              ),
              hSpace(8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.brandRed,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  vSpace(8),
                  Expanded(
                    child: Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.brandRed,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: Container(
                  width: 140.w,
                  height: 140.h,
                  decoration: const BoxDecoration(
                    color: AppColors.lightSurface,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.location_on_rounded,
                      size: 64.sp,
                      color: AppColors.brandRed,
                    ),
                  ),
                ),
              ),
              hSpace(32),
              Text(
                'onboarding.location.title'.tr(context: context),
                style: AppTextStyles.font22Bold,
                textAlign: TextAlign.center,
              ),
              hSpace(12),
              Text(
                'onboarding.location.desc'.tr(context: context),
                style: AppTextStyles.font14Regular,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomButton(
                text: 'onboarding.location.allow'.tr(context: context),
                type: CustomButtonType.primary,
                height: 52.h,
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.notificationsPermission),
              ),
              hSpace(12),
              CustomButton(
                text: 'onboarding.location.manual'.tr(context: context),
                type: CustomButtonType.outline,
                height: 48.h,
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.notificationsPermission),
              ),
              hSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}
