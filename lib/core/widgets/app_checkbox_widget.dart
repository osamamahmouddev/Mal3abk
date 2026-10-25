import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';

/// 22px rounded checkbox from the design system (tap handled by the parent).
class AppCheckboxWidget extends StatelessWidget {
  const AppCheckboxWidget({required this.value, super.key});

  final bool value;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
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
      child: value
          ? Icon(Icons.check_rounded, size: 16.r, color: AppColors.white)
          : null,
    );
  }
}
