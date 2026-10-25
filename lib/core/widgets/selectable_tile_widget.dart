import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

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
    final baseStyle = titleStyle ??
        (boldTitle ? AppTextStyles.font14Bold : AppTextStyles.font14SemiBold);

    return Material(
      color: isSelected ? AppColors.brandNavy : AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: isSelected ? AppColors.brandNavy : borderColor,
        ),
      ),
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
              Text(title, style: baseStyle.copyWith(color: fg)),
              if (subtitle != null)
                Opacity(
                  opacity: subtitleOpacity,
                  child: Text(
                    subtitle!,
                    style: (subtitleStyle ?? AppTextStyles.font11Regular)
                        .copyWith(color: fg),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
