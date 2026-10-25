import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class LoginOtpStepWidget extends StatelessWidget {
  const LoginOtpStepWidget({
    required this.controller,
    required this.isLoading,
    required this.onSubmit,
    required this.onEditPhone,
    super.key,
  });

  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSubmit;
  final VoidCallback onEditPhone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextFormField(
          controller: controller,
          labelText: 'auth.login.otp_label'.tr(context: context),
          hintText: '••••',
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: AppTextStyles.font17Regular,
        ),
        hSpace(20),
        CustomButton(
          text: 'auth.login.verify_and_enter'.tr(context: context),
          height: 54.h,
          borderRadius: 16,
          textStyle: AppTextStyles.font17Bold.copyWith(color: AppColors.white),
          isLoading: isLoading,
          onTap: onSubmit,
        ),
        hSpace(12),
        CustomButton(
          text: 'auth.login.edit_phone'.tr(context: context),
          type: CustomButtonType.ghost,
          height: 44.h,
          onTap: onEditPhone,
        ),
      ],
    );
  }
}
