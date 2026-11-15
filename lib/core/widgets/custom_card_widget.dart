import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_shadows.dart';
import 'press_scale_widget.dart';

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget({
    required this.child,
    super.key,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor = AppColors.white,
    this.borderColor = AppColors.borderCard,
    this.width,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color backgroundColor;
  final Color borderColor;
  final double? width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = BorderRadius.circular((borderRadius ?? 20).r);

    return PressScaleWidget(
      enabled: onTap != null,
      scale: 0.98,
      child: Container(
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: effectiveRadius,
          boxShadow: AppShadows.card,
        ),
        child: Material(
          color: backgroundColor,
          borderRadius: effectiveRadius,
          child: InkWell(
            onTap: onTap,
            borderRadius: effectiveRadius,
            child: Container(
              padding: padding ?? EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                borderRadius: effectiveRadius,
                border: Border.all(color: borderColor),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
