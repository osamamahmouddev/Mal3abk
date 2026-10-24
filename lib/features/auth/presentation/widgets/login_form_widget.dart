import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/app/app_regex.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../data/models/login_request_body.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginFormWidget extends HookWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final isPasswordObscured = useState(true);

    void submit() {
      if (formKey.currentState?.validate() ?? false) {
        context.read<LoginCubit>().login(
              LoginRequestBody(
                email: emailController.text.trim(),
                password: passwordController.text,
              ),
            );
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            controller: emailController,
            focusNode: emailFocusNode,
            hintText: 'auth.email_hint'.tr(),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'validation.email_required'.tr();
              }
              if (!AppRegex.isEmailValid(value)) {
                return 'validation.email_invalid'.tr();
              }
              return null;
            },
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: AppColors.neutral500,
            ),
          ),
          hSpace(16),
          CustomTextFormField(
            controller: passwordController,
            focusNode: passwordFocusNode,
            hintText: 'auth.password_hint'.tr(),
            obscureText: isPasswordObscured.value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'validation.password_required'.tr();
              }
              if (value.length < 6) {
                return 'validation.password_too_short'.tr();
              }
              return null;
            },
            prefixIcon: const Icon(
              Icons.lock_outline_rounded,
              color: AppColors.neutral500,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordObscured.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.neutral500,
              ),
              onPressed: () {
                isPasswordObscured.value = !isPasswordObscured.value;
              },
            ),
          ),
          hSpace(24),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              final isLoading = state is LoginLoading;
              return CustomButton(
                text: 'auth.login'.tr(),
                isLoading: isLoading,
                onTap: submit,
              );
            },
          ),
        ],
      ),
    );
  }
}
