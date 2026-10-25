import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_motion.dart';

/// 22px rounded checkbox from the design system (tap handled by the parent).
class AppCheckboxWidget extends StatelessWidget {
  const AppCheckboxWidget({required this.value, super.key});

  final bool value;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppMotion.fast,
      curve: AppMotion.standard,
      width: 22.r,
      height: 22.r,
      decoration: BoxDecoration(
        color: value ? AppColors.brandNavy : AppColors.white,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: value ? AppColors.brandNavy : AppColors.checkboxBorder,
          width: 2,
        ),
      ),
      child: AnimatedScale(
        scale: value ? 1 : 0,
        duration: AppMotion.medium,
        curve: AppMotion.emphasized,
        child: Icon(Icons.check_rounded, size: 16.r, color: AppColors.white),
      ),
    );
  }
}
