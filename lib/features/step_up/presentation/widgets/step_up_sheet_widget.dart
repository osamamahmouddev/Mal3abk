import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/otp_code_field_widget.dart';
import '../../../../core/widgets/resend_countdown_widget.dart';
import '../cubit/step_up_cubit.dart';
import '../cubit/step_up_state.dart';

/// Re-verifies the player with a code sent to their phone and returns a
/// short-lived token for [scope], or null if they back out.
class StepUpSheetWidget extends HookWidget {
  const StepUpSheetWidget({required this.scope, super.key});

  final String scope;

  static Future<String?> show(BuildContext context, {required String scope}) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => BlocProvider<StepUpCubit>(
        create: (_) => sl<StepUpCubit>()..sendCode(),
        child: StepUpSheetWidget(scope: scope),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final code = useTextEditingController();
    final resendKey = useState(0);
    final cubit = context.read<StepUpCubit>();
    void verify() => cubit.verify(scope: scope, code: code.text);

    return BlocConsumer<StepUpCubit, StepUpState>(
      listener: (context, state) {
        switch (state) {
          case StepUpVerified(:final token):
            HapticFeedback.mediumImpact();
            Navigator.of(context).pop(token);
          case StepUpError():
            HapticFeedback.heavyImpact();
            code.clear();
          default:
            break;
        }
      },
      builder: (context, state) {
        final error = state is StepUpError ? state.message : null;
        final busy = state is StepUpSending || state is StepUpVerifying;
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 12.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'step_up.title'.tr(context: context),
                      style: AppTextStyles.font18Bold,
                      textAlign: TextAlign.center,
                    ),
                    hSpace(6),
                    Text(
                      'step_up.description'.tr(context: context),
                      style: AppTextStyles.font13Regular,
                      textAlign: TextAlign.center,
                    ),
                    hSpace(20),
                    OtpCodeFieldWidget(
                      controller: code,
                      hasError: error != null,
                      onCompleted: (_) => verify(),
                    ),
                    if (error != null) ...[
                      hSpace(10),
                      Text(
                        error.tr(context: context),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.font13Regular.copyWith(
                          color: AppColors.redText,
                        ),
                      ),
                    ],
                    hSpace(12),
                    ResendCountdownWidget(
                      restartKey: resendKey.value,
                      enabled: !busy,
                      onResend: () {
                        resendKey.value++;
                        cubit.sendCode();
                      },
                    ),
                    hSpace(12),
                    CustomButton(
                      text: 'step_up.confirm'.tr(context: context),
                      height: 50.h,
                      borderRadius: 12,
                      isLoading: busy,
                      textStyle: AppTextStyles.font16Bold.copyWith(
                        color: AppColors.white,
                      ),
                      onTap: verify,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
