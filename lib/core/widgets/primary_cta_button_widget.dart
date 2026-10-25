import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_shadows.dart';
import '../styles/app_text_styles.dart';
import 'custom_button.dart';

/// Red call-to-action button with the glow shadow used across Figma screens.
class PrimaryCtaButtonWidget extends StatelessWidget {
  const PrimaryCtaButtonWidget({
    required this.text,
    required this.onTap,
    super.key,
    this.height = 52,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback onTap;
  final double height;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      height: height.h,
      borderRadius: 16,
      isLoading: isLoading,
      textStyle: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
      boxShadow: AppShadows.redGlow,
      onTap: onTap,
    );
  }
}
