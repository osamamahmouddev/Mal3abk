import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/verify_old_phone_cubit.dart';
import '../cubit/verify_old_phone_state.dart';

class VerifyOldPhoneButtonBlocBuilder extends StatelessWidget {
  const VerifyOldPhoneButtonBlocBuilder({
    required this.requestId,
    required this.codeController,
    super.key,
  });

  final String requestId;
  final TextEditingController codeController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyOldPhoneCubit, VerifyOldPhoneState>(
      builder: (context, state) {
        return CustomButton(
          text: 'phone_change.verify_old.submit'.tr(context: context),
          height: 54.h,
          borderRadius: 16,
          textStyle: AppTextStyles.font17Bold.copyWith(color: AppColors.white),
          isLoading: switch (state) {
            VerifyOldPhoneLoading() || VerifyOldPhoneSuccess() => true,
            _ => false,
          },
          onTap: () => context.read<VerifyOldPhoneCubit>().verify(
            requestId: requestId,
            code: codeController.text,
          ),
        );
      },
    );
  }
}
