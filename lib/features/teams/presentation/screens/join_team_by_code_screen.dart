import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class JoinTeamByCodeScreen extends HookWidget {
  const JoinTeamByCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final codeController = useTextEditingController();

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'الانضمام لفريق'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'اكتب كود الفريق المكوّن من ٨ أحرف/أرقام اللي وصلك من كابتن الفريق.',
                style: AppTextStyles.font14Regular,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                controller: codeController,
                hintText: 'مثال: NGM-7842',
                textAlign: TextAlign.center,
                style: AppTextStyles.font18Bold.copyWith(letterSpacing: 2),
              ),
              SizedBox(height: 24.h),
              CustomButton(
                text: 'انضمام للفريق',
                type: CustomButtonType.primary,
                height: 52.h,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
