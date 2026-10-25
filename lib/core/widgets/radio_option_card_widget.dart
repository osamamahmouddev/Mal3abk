import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

/// White option card with a leading radio, title and subtitle.
class RadioOptionCardWidget extends StatelessWidget {
  const RadioOptionCardWidget({
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
    this.subtitle,
    this.titleStyle,
  });

  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14.r);

    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: isSelected ? AppColors.brandNavy : AppColors.border,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Container(
                width: 20.r,
                height: 20.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.brandNavy : AppColors.checkboxBorder,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Container(
                        width: 10.r,
                        height: 10.r,
                        decoration: const BoxDecoration(
                          color: AppColors.brandNavy,
                          shape: BoxShape.circle,
                        ),
                      )
                    : null,
              ),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: titleStyle ?? AppTextStyles.font15Bold),
                    if (subtitle != null) ...[
                      hSpace(2),
                      Text(subtitle!, style: AppTextStyles.font12Regular),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
