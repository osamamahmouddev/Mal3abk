import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/digits_only_input_formatter.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../cubit/owner_login_cubit.dart';
import '../cubit/owner_login_state.dart';
import 'password_visibility_button_widget.dart';

/// Venue owner/staff sign-in with email (or mobile) and password, plus the
/// authenticator code when the account has two-factor sign-in on.
class OwnerLoginFormWidget extends HookWidget {
  const OwnerLoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final totpController = useTextEditingController();
    final obscure = useState(true);
    String t(String key) => 'venue_auth.login.$key'.tr(context: context);

    void submit() {
      FocusScope.of(context).unfocus();
      context.read<OwnerLoginCubit>().login(
        email: emailController.text,
        password: passwordController.text,
        totpCode: totpController.text,
      );
    }

    return BlocConsumer<OwnerLoginCubit, OwnerLoginState>(
      listener: (context, state) {
        if (state is OwnerLoginSuccess) context.openVenueShell();
      },
      builder: (context, state) {
        final cubit = context.read<OwnerLoginCubit>();
        final isLoading = state is OwnerLoginLoading;
        return AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                t('subtitle'),
                style: AppTextStyles.font14Regular,
                textAlign: TextAlign.center,
              ),
              hSpace(22),
              CustomTextFormField(
                controller: emailController,
                labelText: t('email_label'),
                hintText: 'name@example.com',
                keyboardType: TextInputType.emailAddress,
                textDirection: TextDirection.ltr,
                enabled: !isLoading,
                autofillHints: const [AutofillHints.username],
              ),
              hSpace(14),
              CustomTextFormField(
                controller: passwordController,
                labelText: t('password_label'),
                hintText: '••••••••••',
                obscureText: obscure.value,
                textDirection: TextDirection.ltr,
                enabled: !isLoading,
                autofillHints: const [AutofillHints.password],
                suffixIcon: PasswordVisibilityButtonWidget(
                  obscured: obscure.value,
                  onTap: () => obscure.value = !obscure.value,
                ),
                onFieldSubmitted: (_) => submit(),
              ),
              if (cubit.needsTotp) ...[
                hSpace(14),
                CustomTextFormField(
                  controller: totpController,
                  labelText: t('totp_label'),
                  hintText: '123456',
                  keyboardType: TextInputType.number,
                  textDirection: TextDirection.ltr,
                  autofocus: true,
                  inputFormatters: const [DigitsOnlyInputFormatter()],
                  autofillHints: const [AutofillHints.oneTimeCode],
                  onFieldSubmitted: (_) => submit(),
                ),
              ],
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: isLoading
                      ? null
                      : () => context.pushNamed(
                          AppRoutes.venueForgotPassword,
                          arguments: emailController.text.trim(),
                        ),
                  child: Text(
                    t('forgot_password'),
                    style: AppTextStyles.font13SemiBold.copyWith(
                      color: AppColors.brandNavy,
                    ),
                  ),
                ),
              ),
              if (state case OwnerLoginError(:final message)) ...[
                AlertBannerWidget(
                  type: AlertBannerType.error,
                  message: message.tr(context: context),
                ),
                hSpace(12),
              ],
              if (state is OwnerLoginTotpRequired) ...[
                AlertBannerWidget(
                  type: AlertBannerType.info,
                  message: 'errors.venue_auth.two_factor_required'.tr(
                    context: context,
                  ),
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
                onTap: submit,
              ),
              hSpace(18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      t('no_account'),
                      style: AppTextStyles.font14Regular,
                    ),
                  ),
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () => context.pushNamed(AppRoutes.venueRegister),
                    child: Text(
                      t('register_venue'),
                      style: AppTextStyles.font14Bold.copyWith(
                        color: AppColors.brandRed,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
