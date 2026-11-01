import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

/// `+20` country prefix shown inside Egyptian phone number fields with an elegant divider.
class PhonePrefixWidget extends StatelessWidget {
  const PhonePrefixWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        hSpace(14),
        Text(
          '+20',
          textDirection: TextDirection.ltr,
          style: AppTextStyles.font16Medium.copyWith(
            color: AppColors.brandNavy,
          ),
        ),
        hSpace(10),
        Container(
          width: 1.w,
          height: 22.h,
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(1.r),
          ),
        ),
        hSpace(12),
      ],
    );
  }
}
