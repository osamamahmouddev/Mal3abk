import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/notification_preview_card_widget.dart';

class NotificationsPermissionScreen extends StatelessWidget {
  const NotificationsPermissionScreen({super.key});

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
              const Spacer(),
              NotificationPreviewCardWidget(
                icon: Icons.check_circle_rounded,
                iconColor: AppColors.successGreen,
                title: 'onboarding.notifications.preview1_title'.tr(context: context),
                time: 'onboarding.notifications.preview1_time'.tr(context: context),
              ),
              hSpace(10),
              NotificationPreviewCardWidget(
                icon: Icons.swap_horiz_rounded,
                iconColor: AppColors.brandNavy,
                title: 'onboarding.notifications.preview2_title'.tr(context: context),
                time: 'onboarding.notifications.preview2_time'.tr(context: context),
              ),
              hSpace(10),
              NotificationPreviewCardWidget(
                icon: Icons.alarm_rounded,
                iconColor: AppColors.brandRed,
                title: 'onboarding.notifications.preview3_title'.tr(context: context),
                time: 'onboarding.notifications.preview3_time'.tr(context: context),
              ),
              hSpace(32),
              Text(
                'onboarding.notifications.title'.tr(context: context),
                style: AppTextStyles.font22Bold,
                textAlign: TextAlign.center,
              ),
              hSpace(12),
              Text(
                'onboarding.notifications.desc'.tr(context: context),
                style: AppTextStyles.font14Regular,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomButton(
                text: 'onboarding.notifications.enable'.tr(context: context),
                type: CustomButtonType.primary,
                height: 54.h,
                onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
              ),
              hSpace(12),
              CustomButton(
                text: 'onboarding.notifications.not_now'.tr(context: context),
                type: CustomButtonType.ghost,
                height: 48.h,
                onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
              ),
              hSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}
