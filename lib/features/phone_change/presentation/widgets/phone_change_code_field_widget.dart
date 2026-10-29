import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

/// Description plus the 6-digit code field shared by both verify steps.
class PhoneChangeCodeFieldWidget extends StatelessWidget {
  const PhoneChangeCodeFieldWidget({
    required this.description,
    required this.controller,
    super.key,
  });

  final String description;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          description,
          style: AppTextStyles.font14Regular,
          textAlign: TextAlign.center,
        ),
        hSpace(20),
        CustomTextFormField(
          controller: controller,
          labelText: 'auth.login.otp_label'.tr(context: context),
          hintText: '••••••',
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: AppTextStyles.font17Regular,
          autofocus: true,
        ),
      ],
    );
  }
}
