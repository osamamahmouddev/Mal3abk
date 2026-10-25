import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class DepositStepWidget extends StatelessWidget {
  const DepositStepWidget({
    required this.number,
    required this.text,
    super.key,
  });

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12.r,
            backgroundColor: AppColors.brandNavy,
            child: Text(
              number,
              style: AppTextStyles.font11Bold.copyWith(color: AppColors.white),
            ),
          ),
          vSpace(10),
          Expanded(child: Text(text, style: AppTextStyles.font13Regular)),
        ],
      ),
    );
  }
}
