import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

/// One choice in a picker sheet: the label, and a check when it is the
/// current choice.
class PickerOptionTileWidget extends StatelessWidget {
  const PickerOptionTileWidget({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
    super.key,
  });

  final String label;
  final bool isSelected;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.lightSurface : AppColors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18.r, color: AppColors.textSecondary),
                vSpace(10),
              ],
              Expanded(
                child: Text(
                  label,
                  style: isSelected
                      ? AppTextStyles.font15Bold
                      : AppTextStyles.font15Regular,
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  size: 20.r,
                  color: AppColors.brandNavy,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
