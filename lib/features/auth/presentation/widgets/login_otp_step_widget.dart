import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/otp_code_field_widget.dart';
import '../../../../core/widgets/resend_countdown_widget.dart';
import '../cubit/send_otp_cubit.dart';
import '../cubit/verify_otp_cubit.dart';
import 'verify_otp_button_bloc_builder.dart';

class LoginOtpStepWidget extends HookWidget {
  const LoginOtpStepWidget({
    required this.phoneNumber,
    required this.sendCount,
    required this.isResending,
    super.key,
  });

  /// Normalized number returned by `otp/send`; `otp/verify` expects it.
  final String phoneNumber;
  final int sendCount;
  final bool isResending;

  @override
  Widget build(BuildContext context) {
    final codeController = useTextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'auth.login.otp_sent_hint'.tr(context: context),
          style: AppTextStyles.font14Regular,
          textAlign: TextAlign.center,
        ),
        hSpace(4),
        Text(
          phoneNumber,
          textDirection: TextDirection.ltr,
          style: AppTextStyles.font14SemiBold,
          textAlign: TextAlign.center,
        ),
        hSpace(26),
        OtpCodeFieldWidget(
          controller: codeController,
          onCompleted: (code) => context.read<VerifyOtpCubit>().verifyOtp(
            phoneNumber: phoneNumber,
            code: code,
          ),
        ),
        hSpace(12),
        ResendCountdownWidget(
          restartKey: sendCount,
          enabled: !isResending,
          onResend: () {
            codeController.clear();
            context.read<SendOtpCubit>().resend();
          },
        ),
        hSpace(12),
        VerifyOtpButtonBlocBuilder(
          phoneNumber: phoneNumber,
          codeController: codeController,
        ),
        hSpace(12),
        CustomButton(
          text: 'auth.login.edit_phone'.tr(context: context),
          type: CustomButtonType.ghost,
          height: 44.h,
          onTap: () => context.read<SendOtpCubit>().reset(),
        ),
      ],
    );
  }
}
