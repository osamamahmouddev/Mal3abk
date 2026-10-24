import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class CustomChipWidget extends StatelessWidget {
  const CustomChipWidget({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
    this.icon,
    this.count,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? icon;
  final int? count;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = BorderRadius.circular(10.r);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: effectiveRadius,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.brandNavy : AppColors.white,
            borderRadius: effectiveRadius,
            border: Border.all(
              color: isSelected ? AppColors.brandNavy : AppColors.borderInput,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                icon!,
                SizedBox(width: 6.w),
              ],
              Text(
                label,
                style: isSelected
                    ? AppTextStyles.font13SemiBold.copyWith(color: AppColors.white)
                    : AppTextStyles.font13Regular.copyWith(color: AppColors.textPrimary),
              ),
              if (count != null) ...[
                SizedBox(width: 6.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.white.withValues(alpha: 0.2)
                        : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    count.toString(),
                    style: AppTextStyles.font11Bold.copyWith(
                      color: isSelected ? AppColors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

