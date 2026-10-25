import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';

class BottomActionBarWidget extends StatelessWidget {
  const BottomActionBarWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyShadow30,
            offset: Offset(0, -10.h),
            blurRadius: 30.r,
            spreadRadius: -15.r,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        minimum: EdgeInsets.only(bottom: 26.h),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
          child: child,
        ),
      ),
    );
  }
}
