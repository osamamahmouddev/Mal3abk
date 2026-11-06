import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_back_button_widget.dart';
import '../../../../core/widgets/brand_wordmark_widget.dart';
import '../widgets/login_step_bloc_builder.dart';
import '../widgets/send_otp_bloc_listener.dart';
import '../widgets/verify_otp_bloc_listener.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = useTextEditingController();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SendOtpBlocListener(
          child: VerifyOtpBlocListener(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AppBackButtonWidget(),
                  ),
                  hSpace(18),
                  BrandWordmarkWidget(height: 60.h),
                  hSpace(28),
                  Text(
                    'auth.login.title'.tr(context: context),
                    style: AppTextStyles.font24Bold,
                    textAlign: TextAlign.center,
                  ),
                  hSpace(12),
                  LoginStepBlocBuilder(phoneController: phoneController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
