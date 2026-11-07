import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'press_scale_widget.dart';

/// A large tappable card in the photo source sheet (gallery or camera).
class ImageSourceOptionWidget extends StatelessWidget {
  const ImageSourceOptionWidget({
    required this.icon,
    required this.label,
    required this.hint,
    required this.iconColor,
    required this.iconBackground,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final String hint;
  final Color iconColor;
  final Color iconBackground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressScaleWidget(
      child: Material(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
          side: const BorderSide(color: AppColors.borderCard),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18.r),
          onTap: () {
            HapticFeedback.selectionClick();
            onTap();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
            child: Column(
              children: [
                Container(
                  width: 56.r,
                  height: 56.r,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 26.r),
                ),
                hSpace(12),
                Text(label, style: AppTextStyles.font15Bold),
                hSpace(4),
                Text(
                  hint,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
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
