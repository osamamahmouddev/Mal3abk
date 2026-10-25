import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_back_button_widget.dart';
import '../../../../core/widgets/brand_wordmark_widget.dart';
import '../widgets/login_otp_step_widget.dart';
import '../widgets/login_phone_step_widget.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = useTextEditingController();
    final otpController = useTextEditingController();
    final isOtpSent = useState(false);
    final isLoading = useState(false);

    void handleSendCode() {
      if (phoneController.text.trim().isEmpty) return;
      isLoading.value = true;
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!context.mounted) return;
        isLoading.value = false;
        isOtpSent.value = true;
      });
    }

    void handleVerifyOtp() {
      isLoading.value = true;
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!context.mounted) return;
        isLoading.value = false;
        Navigator.of(context).pushReplacementNamed(AppRoutes.profileSetup);
      });
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: AppBackButtonWidget(),
              ),
              hSpace(18),
              BrandWordmarkWidget(
                crossAxisAlignment: CrossAxisAlignment.center,
                titleStyle: AppTextStyles.font44Bold.copyWith(
                  color: AppColors.brandNavy,
                ),
                latinStyle: AppTextStyles.font15SemiBold.copyWith(
                  color: AppColors.textSecondary,
                ),
                accentColor: AppColors.brandRed,
              ),
              hSpace(35),
              Text(
                'auth.login.title'.tr(context: context),
                style: AppTextStyles.font24Bold,
                textAlign: TextAlign.center,
              ),
              hSpace(12),
              Text(
                isOtpSent.value
                    ? 'auth.login.otp_sent_hint'.tr(context: context)
                    : 'auth.login.phone_hint_subtitle'.tr(context: context),
                style: AppTextStyles.font14Regular,
                textAlign: TextAlign.center,
              ),
              hSpace(26),
              if (isOtpSent.value)
                LoginOtpStepWidget(
                  controller: otpController,
                  isLoading: isLoading.value,
                  onSubmit: handleVerifyOtp,
                  onEditPhone: () => isOtpSent.value = false,
                )
              else
                LoginPhoneStepWidget(
                  controller: phoneController,
                  isLoading: isLoading.value,
                  onSubmit: handleSendCode,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
