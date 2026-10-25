import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class SlotChipWidget extends StatelessWidget {
  const SlotChipWidget({required this.label, super.key, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(8.r);

    return Material(
      color: AppColors.successLight,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          height: 34.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.font12Bold.copyWith(
              color: AppColors.successGreen,
            ),
          ),
        ),
      ),
    );
  }
}
