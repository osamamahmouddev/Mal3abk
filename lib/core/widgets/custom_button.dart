import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

enum CustomButtonType {
  primary,
  secondary,
  outline,
  ghost,
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    required this.onTap,
    super.key,
    this.type = CustomButtonType.primary,
    this.isLoading = false,
    this.enabled = true,
    this.height,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.textStyle,
    this.padding,
    this.icon,
  });

  final String text;
  final VoidCallback onTap;
  final CustomButtonType type;
  final bool isLoading;
  final bool enabled;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = BorderRadius.circular((borderRadius ?? 14).r);

    Color bg;
    Color fg;
    Border? border;

    switch (type) {
      case CustomButtonType.primary:
        bg = backgroundColor ?? AppColors.brandRed;
        fg = foregroundColor ?? AppColors.white;
        break;
      case CustomButtonType.secondary:
        bg = backgroundColor ?? AppColors.brandNavy;
        fg = foregroundColor ?? AppColors.white;
        break;
      case CustomButtonType.outline:
        bg = backgroundColor ?? Colors.transparent;
        fg = foregroundColor ?? AppColors.brandNavy;
        border = Border.all(
          color: borderColor ?? AppColors.borderInput,
          width: 1.2,
        );
        break;
      case CustomButtonType.ghost:
        bg = backgroundColor ?? Colors.transparent;
        fg = foregroundColor ?? AppColors.textSecondary;
        break;
    }

    if (!enabled) {
      bg = bg.withValues(alpha: 0.5);
      fg = fg.withValues(alpha: 0.6);
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (enabled && !isLoading) ? onTap : null,
        borderRadius: effectiveRadius,
        child: Container(
          width: width,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
          height: height ?? 52.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: effectiveRadius,
            border: border,
          ),
          child: isLoading
              ? SizedBox(
                  width: 22.w,
                  height: 22.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    valueColor: AlwaysStoppedAnimation<Color>(fg),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      SizedBox(width: 8.w),
                    ],
                    Text(
                      text,
                      style: textStyle ??
                          AppTextStyles.font16SemiBold.copyWith(
                            color: fg,
                          ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
