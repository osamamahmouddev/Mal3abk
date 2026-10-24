import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

enum AppBadgeType {
  success,
  warning,
  error,
  neutral,
  accent,
}

class AppBadgeWidget extends StatelessWidget {
  const AppBadgeWidget({
    required this.text,
    super.key,
    this.type = AppBadgeType.neutral,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.textStyle,
  });

  final String text;
  final AppBadgeType type;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (type) {
      case AppBadgeType.success:
        bg = AppColors.successLight;
        fg = AppColors.successGreen;
        break;
      case AppBadgeType.warning:
        bg = AppColors.goldLight;
        fg = AppColors.goldDark;
        break;
      case AppBadgeType.error:
        bg = AppColors.redLight;
        fg = AppColors.redText;
        break;
      case AppBadgeType.accent:
        bg = AppColors.accentGold;
        fg = AppColors.textPrimary;
        break;
      case AppBadgeType.neutral:
        bg = AppColors.lightSurface;
        fg = AppColors.textSecondary;
        break;
    }

    final effectiveBg = backgroundColor ?? bg;
    final effectiveFg = textColor ?? fg;

    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: BorderRadius.circular((borderRadius ?? 12).r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!,
            SizedBox(width: 4.w),
          ],
          Text(
            text,
            style: textStyle ??
                AppTextStyles.font12Bold.copyWith(
                  color: effectiveFg,
                ),
          ),
        ],
      ),
    );
  }
}

