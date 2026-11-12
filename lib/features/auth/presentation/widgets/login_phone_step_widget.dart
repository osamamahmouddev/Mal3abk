import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/hooks/use_seconds_until.dart';
import '../../../../core/utils/countdown_clock.dart';
import '../../../../core/utils/egyptian_phone_input_formatter.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/phone_prefix_widget.dart';
import '../cubit/send_otp_cubit.dart';

class LoginPhoneStepWidget extends HookWidget {
  const LoginPhoneStepWidget({
    required this.controller,
    required this.isLoading,
    this.rateLimitedUntil,
    super.key,
  });

  final TextEditingController controller;
  final bool isLoading;

  /// When the number asked for too many codes: the button waits until then
  /// and a banner explains why.
  final DateTime? rateLimitedUntil;

  @override
  Widget build(BuildContext context) {
    final waitSeconds = useSecondsUntil(rateLimitedUntil);
    final isWaiting = waitSeconds > 0;
    final clock = CountdownClock.format(
      waitSeconds,
      context.locale.languageCode,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'auth.login.phone_hint_subtitle'.tr(context: context),
          style: AppTextStyles.font14Regular,
          textAlign: TextAlign.center,
        ),
        hSpace(26),
        CustomTextFormField(
          controller: controller,
          labelText: 'auth.login.phone_label'.tr(context: context),
          hintText: '010 1234 5678',
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.end,
          inputFormatters: const [EgyptianPhoneInputFormatter()],
          style: AppTextStyles.font17Regular,
          contentPadding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 15.h,
          ),
          prefixIcon: const PhonePrefixWidget(),
          onFieldSubmitted: (value) =>
              context.read<SendOtpCubit>().sendOtp(value),
        ),
        if (isWaiting) ...[
          hSpace(16),
          AlertBannerWidget(
            type: AlertBannerType.warning,
            icon: Icons.hourglass_top_rounded,
            message: 'auth.login.rate_limited'.tr(
              context: context,
              args: [clock],
            ),
          ),
        ],
        hSpace(20),
        CustomButton(
          text: isWaiting
              ? 'auth.login.send_code_in'.tr(context: context, args: [clock])
              : 'auth.login.send_code'.tr(context: context),
          enabled: !isWaiting,
          height: 54.h,
          borderRadius: 16,
          textStyle: AppTextStyles.font17Bold.copyWith(color: AppColors.white),
          isLoading: isLoading,
          onTap: () => context.read<SendOtpCubit>().sendOtp(controller.text),
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
