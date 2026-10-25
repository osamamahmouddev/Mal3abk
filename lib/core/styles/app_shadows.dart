import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'app_colors.dart';

class AppShadows {
  const AppShadows._();

  /// Standard white card: 0 10 24 -14 navy/16 + 0 1 2 navy/4.
  static List<BoxShadow> get card => [
        BoxShadow(
          color: AppColors.navyShadow16,
          offset: Offset(0, 10.h),
          blurRadius: 24.r,
          spreadRadius: -14.r,
        ),
        BoxShadow(
          color: AppColors.navyShadow4,
          offset: Offset(0, 1.h),
          blurRadius: 2.r,
        ),
      ];

  /// Red CTA glow.
  static List<BoxShadow> get redGlow => [
        BoxShadow(
          color: AppColors.redShadow,
          offset: Offset(0, 10.h),
          blurRadius: 22.r,
          spreadRadius: -11.r,
        ),
      ];

  /// Floating bottom navigation bar.
  static List<BoxShadow> get navBar => [
        BoxShadow(
          color: AppColors.navyShadow30,
          offset: Offset(0, 12.h),
          blurRadius: 32.r,
          spreadRadius: -16.r,
        ),
      ];
}
