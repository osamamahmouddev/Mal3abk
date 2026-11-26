import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/app_back_button_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../cubit/owner_forgot_password_cubit.dart';
import '../cubit/owner_forgot_password_state.dart';

/// Sends the password reset link to the owner's email; the link opens the
/// venue web page where the new password is set.
class OwnerForgotPasswordScreen extends HookWidget {
  const OwnerForgotPasswordScreen({this.initialEmail = '', super.key});

  final String initialEmail;

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: initialEmail);
    String t(String key) => 'venue_auth.forgot.$key'.tr(context: context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
          child:
              BlocBuilder<OwnerForgotPasswordCubit, OwnerForgotPasswordState>(
                builder: (context, state) {
                  final isLoading = state is OwnerForgotPasswordLoading;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: AppBackButtonWidget(),
                      ),
                      hSpace(18),
                      Text(
                        t('title'),
                        style: AppTextStyles.font24Bold,
                        textAlign: TextAlign.center,
                      ),
                      hSpace(8),
                      Text(
                        t('subtitle'),
                        style: AppTextStyles.font14Regular,
                        textAlign: TextAlign.center,
                      ),
                      hSpace(24),
                      CustomTextFormField(
                        controller: emailController,
                        labelText: t('email_label'),
                        hintText: 'name@example.com',
                        keyboardType: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        enabled: !isLoading,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.email],
                      ),
                      hSpace(16),
                      if (state is OwnerForgotPasswordSent) ...[
                        AlertBannerWidget(
                          type: AlertBannerType.info,
                          icon: Icons.check_circle_outline_rounded,
                          message: t('sent'),
                        ),
                        hSpace(12),
                      ],
                      if (state case OwnerForgotPasswordError(
                        :final message,
                      )) ...[
                        AlertBannerWidget(
                          type: AlertBannerType.error,
                          message: message.tr(context: context),
                        ),
                        hSpace(12),
                      ],
                      CustomButton(
                        text: t('submit'),
                        height: 54.h,
                        borderRadius: 16,
                        textStyle: AppTextStyles.font17Bold.copyWith(
                          color: AppColors.white,
                        ),
                        isLoading: isLoading,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          context.read<OwnerForgotPasswordCubit>().send(
                            emailController.text,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
        ),
      ),
    );
  }
}
