import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../widgets/login_bloc_listener.dart';
import '../widgets/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginBlocListener(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hSpace(24),
                Center(
                  child: Image.asset(
                    AppAssets.logoStacked,
                    width: 150.w,
                    fit: BoxFit.contain,
                  ),
                ),
                hSpace(32),
                Text(
                  'auth.welcome_back'.tr(),
                  style: AppTextStyles.font24Bold,
                ),
                hSpace(8),
                Text(
                  'auth.login_prompt'.tr(),
                  style: AppTextStyles.font14Regular,
                ),
                hSpace(32),
                const LoginFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
