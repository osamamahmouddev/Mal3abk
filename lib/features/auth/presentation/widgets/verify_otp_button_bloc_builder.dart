import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/verify_otp_cubit.dart';
import '../cubit/verify_otp_state.dart';

class VerifyOtpButtonBlocBuilder extends StatelessWidget {
  const VerifyOtpButtonBlocBuilder({
    required this.phoneNumber,
    required this.codeController,
    super.key,
  });

  final String phoneNumber;
  final TextEditingController codeController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
      builder: (context, state) {
        return CustomButton(
          text: 'auth.login.verify_and_enter'.tr(context: context),
          height: 54.h,
          borderRadius: 16,
          textStyle: AppTextStyles.font17Bold.copyWith(color: AppColors.white),
          isLoading: switch (state) {
            VerifyOtpLoading() || VerifyOtpSuccess() => true,
            _ => false,
          },
          onTap: () => context.read<VerifyOtpCubit>().verifyOtp(
            phoneNumber: phoneNumber,
            code: codeController.text,
          ),
        );
      },
    );
  }
}
