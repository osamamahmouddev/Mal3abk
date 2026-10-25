import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_motion.dart';
import '../styles/app_text_styles.dart';
import 'press_scale_widget.dart';

/// Navy-when-selected option used by chips, segmented choices and level cards.
class SelectableTileWidget extends StatelessWidget {
  const SelectableTileWidget({
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.height,
    required this.borderRadius,
    super.key,
    this.subtitle,
    this.horizontalPadding = 0,
    this.boldTitle = false,
    this.titleStyle,
    this.borderColor = AppColors.border,
    this.subtitleStyle,
    this.subtitleOpacity = 0.8,
  });

  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final double height;
  final double borderRadius;
  final double horizontalPadding;
  final bool boldTitle;
  final TextStyle? titleStyle;
  final Color borderColor;
  final TextStyle? subtitleStyle;
  final double subtitleOpacity;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius.r);
    final fg = isSelected ? AppColors.white : AppColors.textPrimary;
    final baseStyle =
        titleStyle ??
        (boldTitle ? AppTextStyles.font14Bold : AppTextStyles.font14SemiBold);

    return PressScaleWidget(
      child: AnimatedContainer(
        duration: AppMotion.medium,
        curve: AppMotion.standard,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.brandNavy : AppColors.white,
          borderRadius: radius,
          border: Border.all(
            color: isSelected ? AppColors.brandNavy : borderColor,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: radius,
            child: Container(
              height: height.h,
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: AppMotion.medium,
                    style: baseStyle.copyWith(color: fg),
                    child: Text(title),
                  ),
                  if (subtitle != null)
                    Opacity(
                      opacity: subtitleOpacity,
                      child: AnimatedDefaultTextStyle(
                        duration: AppMotion.medium,
                        style: (subtitleStyle ?? AppTextStyles.font11Regular)
                            .copyWith(color: fg),
                        child: Text(subtitle!),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
