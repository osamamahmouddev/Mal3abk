import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/egyptian_phone_input_formatter.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../cubit/owner_register_cubit.dart';
import '../cubit/owner_register_state.dart';
import 'password_visibility_button_widget.dart';

class OwnerRegisterFormWidget extends HookWidget {
  const OwnerRegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscure = useState(true);
    String t(String key) => 'venue_auth.register.$key'.tr(context: context);

    void submit() {
      FocusScope.of(context).unfocus();
      context.read<OwnerRegisterCubit>().register(
        fullName: nameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        password: passwordController.text,
      );
    }

    return BlocBuilder<OwnerRegisterCubit, OwnerRegisterState>(
      builder: (context, state) {
        final isLoading = state is OwnerRegisterLoading;
        return AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFormField(
                controller: nameController,
                labelText: t('name_label'),
                hintText: t('name_hint'),
                keyboardType: TextInputType.name,
                enabled: !isLoading,
                autofillHints: const [AutofillHints.name],
              ),
              hSpace(14),
              CustomTextFormField(
                controller: emailController,
                labelText: t('email_label'),
                hintText: 'name@example.com',
                keyboardType: TextInputType.emailAddress,
                textDirection: TextDirection.ltr,
                enabled: !isLoading,
                autofillHints: const [AutofillHints.email],
              ),
              hSpace(14),
              CustomTextFormField(
                controller: phoneController,
                labelText: t('phone_label'),
                hintText: '010 1234 5678',
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr,
                enabled: !isLoading,
                inputFormatters: const [EgyptianPhoneInputFormatter()],
                autofillHints: const [AutofillHints.telephoneNumber],
              ),
              hSpace(14),
              CustomTextFormField(
                controller: passwordController,
                labelText: t('password_label'),
                hintText: '••••••••••',
                obscureText: obscure.value,
                textDirection: TextDirection.ltr,
                enabled: !isLoading,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.newPassword],
                suffixIcon: PasswordVisibilityButtonWidget(
                  obscured: obscure.value,
                  onTap: () => obscure.value = !obscure.value,
                ),
                onFieldSubmitted: (_) => submit(),
              ),
              hSpace(6),
              Text(
                t('password_hint'),
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              hSpace(18),
              if (state case OwnerRegisterError(:final message)) ...[
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
                onTap: submit,
              ),
              hSpace(10),
              TextButton(
                onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                child: Text(
                  t('have_account'),
                  style: AppTextStyles.font14Bold.copyWith(
                    color: AppColors.brandNavy,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
