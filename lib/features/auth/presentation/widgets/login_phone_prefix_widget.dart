import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class LoginPhonePrefixWidget extends StatelessWidget {
  const LoginPhonePrefixWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 16.w, end: 12.w),
      padding: EdgeInsetsDirectional.only(end: 10.w),
      decoration: const BoxDecoration(
        border: BorderDirectional(
          end: BorderSide(color: AppColors.textSecondary),
        ),
      ),
      child: Text(
        '+20',
        textDirection: TextDirection.ltr,
        style: AppTextStyles.font15Regular.copyWith(
          color: AppColors.textSecondary,
          height: 22 / 15,
        ),
      ),
    );
  }
}
