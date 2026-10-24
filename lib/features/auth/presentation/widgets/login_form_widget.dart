import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app/app_regex.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../data/models/login_request_body.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  bool _isPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
            LoginRequestBody(
              email: _emailController.text.trim(),
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            keyboardType: TextInputType.emailAddress,
            hintText: 'auth.email_hint'.tr(),
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: AppColors.neutral500,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'validation.email_required'.tr();
              }
              if (!AppRegex.isEmailValid(value.trim())) {
                return 'validation.email_invalid'.tr();
              }
              return null;
            },
          ),
          hSpace(16),
          CustomTextFormField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            obscureText: _isPasswordObscured,
            hintText: 'auth.password_hint'.tr(),
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: AppColors.neutral500,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordObscured
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.neutral500,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordObscured = !_isPasswordObscured;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'validation.password_required'.tr();
              }
              if (!AppRegex.isPasswordValid(value)) {
                return 'validation.password_too_short'.tr();
              }
              return null;
            },
          ),
          hSpace(24),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              final isLoading = state is LoginLoading;
              return CustomButton(
                text: 'auth.login'.tr(),
                isLoading: isLoading,
                onTap: _submit,
              );
            },
          ),
        ],
      ),
    );
  }
}
