import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import 'login_phone_prefix_widget.dart';

class LoginPhoneStepWidget extends StatelessWidget {
  const LoginPhoneStepWidget({
    required this.controller,
    required this.isLoading,
    required this.onSubmit,
    super.key,
  });

  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextFormField(
          controller: controller,
          labelText: 'auth.login.phone_label'.tr(context: context),
          hintText: '01012345678',
          keyboardType: TextInputType.phone,
          style: AppTextStyles.font17Regular,
          contentPadding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 15.h,
          ),
          prefixIcon: const LoginPhonePrefixWidget(),
        ),
        hSpace(20),
        CustomButton(
          text: 'auth.login.send_code'.tr(context: context),
          height: 54.h,
          borderRadius: 16,
          textStyle: AppTextStyles.font17Bold.copyWith(color: AppColors.white),
          isLoading: isLoading,
          onTap: onSubmit,
        ),
        hSpace(12),
        Text(
          'auth.login.new_account_notice'.tr(context: context),
          style: AppTextStyles.font13Regular,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
