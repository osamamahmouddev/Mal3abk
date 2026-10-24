import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    required this.onTap,
    super.key,
    this.isLoading = false,
    this.enabled = true,
    this.height,
    this.width,
    this.borderRadius,
    this.backgroundColor = AppColors.brandPrimary,
    this.disabledColor,
    this.textStyle,
    this.padding,
  });

  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final bool enabled;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color backgroundColor;
  final Color? disabledColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final isInteractive = enabled && !isLoading;
    final radius = BorderRadius.circular((borderRadius ?? 10).r);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isInteractive ? onTap : null,
        borderRadius: radius,
        child: Container(
          width: width,
          padding: padding,
          height: height ?? 48.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: enabled
                ? backgroundColor
                : (disabledColor ?? backgroundColor.withValues(alpha: 0.5)),
            borderRadius: radius,
          ),
          child: isLoading
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                )
              : Text(
                  text,
                  style: textStyle ??
                      AppTextStyles.font16Medium.copyWith(
                        color: AppColors.white,
                      ),
                ),
        ),
      ),
    );
  }
}
