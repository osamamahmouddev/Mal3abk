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
    return Row(
      children: [
        Container(
          width: 26.r,
          height: 26.r,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.brandNavy,
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: AppTextStyles.font13Bold.copyWith(color: AppColors.white),
          ),
        ),
        vSpace(10),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
