import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/primary_cta_button_widget.dart';
import '../widgets/notification_preview_card_widget.dart';

class NotificationsPermissionScreen extends StatelessWidget {
  const NotificationsPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 26.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              NotificationPreviewCardWidget(
                glyph: '✓',
                glyphColor: AppColors.successGreen,
                glyphBackground: AppColors.successLight,
                title: 'onboarding.notifications.preview1_title'.tr(context: context),
                time: 'onboarding.notifications.preview1_time'.tr(context: context),
              ),
              hSpace(4),
              Transform.translate(
                offset: Offset(-10.w, 0),
                child: NotificationPreviewCardWidget(
                  glyph: '⇄',
                  glyphColor: AppColors.goldDark,
                  glyphBackground: AppColors.goldLight,
                  title: 'onboarding.notifications.preview2_title'.tr(context: context),
                  time: 'onboarding.notifications.preview2_time'.tr(context: context),
                ),
              ),
              hSpace(6),
              Transform.translate(
                offset: Offset(10.w, 0),
                child: NotificationPreviewCardWidget(
                  width: 273,
                  glyph: '!',
                  glyphColor: AppColors.redText,
                  glyphBackground: AppColors.redLight,
                  title: 'onboarding.notifications.preview3_title'.tr(context: context),
                  time: 'onboarding.notifications.preview3_time'.tr(context: context),
                ),
              ),
              hSpace(14),
              Text(
                'onboarding.notifications.title'.tr(context: context),
                style: AppTextStyles.font24Bold,
                textAlign: TextAlign.center,
              ),
              hSpace(33),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 38.w),
                child: Text(
                  'onboarding.notifications.desc'.tr(context: context),
                  style: AppTextStyles.font14Regular.copyWith(height: 23 / 14),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              PrimaryCtaButtonWidget(
                text: 'onboarding.notifications.enable'.tr(context: context),
                height: 54,
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed(AppRoutes.main),
              ),
              hSpace(8),
              CustomButton(
                text: 'onboarding.notifications.not_now'.tr(context: context),
                type: CustomButtonType.ghost,
                height: 48.h,
                textStyle: AppTextStyles.font15SemiBold.copyWith(
                  color: AppColors.brandNavy,
                ),
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed(AppRoutes.main),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
