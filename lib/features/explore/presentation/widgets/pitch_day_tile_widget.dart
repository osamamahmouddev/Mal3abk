import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class PitchDayTileWidget extends StatelessWidget {
  const PitchDayTileWidget({
    required this.dayName,
    required this.dayNumber,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String dayName;
  final String dayNumber;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12.r);
    final fg = isSelected ? AppColors.white : AppColors.textPrimary;

    return Material(
      color: isSelected ? AppColors.brandNavy : AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: isSelected ? AppColors.brandNavy : AppColors.border,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          height: 58.h,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dayName,
                style: AppTextStyles.font10Regular.copyWith(color: fg),
                maxLines: 1,
              ),
              Text(
                dayNumber,
                style: AppTextStyles.font17Bold.copyWith(color: fg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
