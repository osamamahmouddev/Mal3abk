import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

/// One tappable legend entry (color swatch + label) that filters the slot grid.
class PitchSlotLegendItemWidget extends StatelessWidget {
  const PitchSlotLegendItemWidget({
    required this.label,
    required this.swatchColor,
    required this.isActive,
    required this.onTap,
    super.key,
    this.swatchBorderColor,
  });

  final String label;
  final Color swatchColor;
  final Color? swatchBorderColor;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(8.r);

    return Semantics(
      button: true,
      selected: isActive,
      child: Material(
        color: isActive ? AppColors.lightSurface : AppColors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12.r,
                  height: 12.r,
                  decoration: BoxDecoration(
                    color: swatchColor,
                    borderRadius: BorderRadius.circular(3.r),
                    border: swatchBorderColor == null
                        ? null
                        : Border.all(color: swatchBorderColor!),
                  ),
                ),
                vSpace(6),
                Text(
                  label,
                  style: isActive
                      ? AppTextStyles.font12Bold.copyWith(
                          color: AppColors.textPrimary,
                        )
                      : AppTextStyles.font12Regular.copyWith(
                          color: AppColors.offlineBanner,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
