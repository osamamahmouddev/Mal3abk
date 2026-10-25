import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  AppAssets.logoStacked,
                  width: 120.w,
                  fit: BoxFit.contain,
                ),
              ),
              hSpace(24),
              Text(
                'auth.login.title'.tr(context: context),
                style: AppTextStyles.font22Bold,
                textAlign: TextAlign.center,
              ),
              hSpace(8),
              Text(
                isOtpSent.value
                    ? 'auth.login.otp_sent_hint'.tr(context: context)
                    : 'auth.login.phone_hint_subtitle'.tr(context: context),
                style: AppTextStyles.font14Regular,
                textAlign: TextAlign.center,
              ),
              hSpace(32),
              if (!isOtpSent.value) ...[
                CustomTextFormField(
                  controller: phoneController,
                  labelText: 'auth.login.phone_label'.tr(context: context),
                  hintText: '01012345678',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Center(
                      widthFactor: 1.0,
                      child: Text(
                        '+20',
                        style: AppTextStyles.font14Bold.copyWith(
                          color: AppColors.brandNavy,
                        ),
                      ),
                    ),
                  ),
                ),
                hSpace(24),
                CustomButton(
                  text: 'auth.login.send_code'.tr(context: context),
                  type: CustomButtonType.primary,
                  height: 54.h,
                  isLoading: isLoading.value,
                  onTap: handleSendCode,
                ),
                hSpace(16),
                Text(
                  'auth.login.new_account_notice'.tr(context: context),
                  style: AppTextStyles.font13Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ] else ...[
                CustomTextFormField(
                  controller: otpController,
                  labelText: 'auth.login.otp_label'.tr(context: context),
                  hintText: '••••',
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                ),
                hSpace(24),
                CustomButton(
                  text: 'auth.login.verify_and_enter'.tr(context: context),
                  type: CustomButtonType.primary,
                  height: 54.h,
                  isLoading: isLoading.value,
                  onTap: handleVerifyOtp,
                ),
                hSpace(16),
                CustomButton(
                  text: 'auth.login.edit_phone'.tr(context: context),
                  type: CustomButtonType.ghost,
                  height: 44.h,
                  onTap: () => isOtpSent.value = false,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
