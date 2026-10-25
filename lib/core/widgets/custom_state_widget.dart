import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'custom_button.dart';

class CustomStateWidget extends StatelessWidget {
  const CustomStateWidget({
    required this.title,
    required this.description,
    super.key,
    this.icon,
    this.actionText,
    this.onActionTap,
    this.isLoading = false,
  });

  final String title;
  final String description;
  final Widget? icon;
  final String? actionText;
  final VoidCallback? onActionTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 40.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading) ...[
              RSizedBox(
                width: 48.w,
                height: 48.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.brandNavy),
                ),
              ),
              hSpace(20),
            ] else if (icon != null) ...[
              icon!,
              hSpace(20),
            ],
            Text(
              title,
              style: AppTextStyles.font18Bold,
              textAlign: TextAlign.center,
            ),
            hSpace(8),
            Text(
              description,
              style: AppTextStyles.font14Regular.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onActionTap != null) ...[
              hSpace(24),
              CustomButton(
                text: actionText!,
                onTap: onActionTap!,
                type: CustomButtonType.secondary,
                width: 180.w,
                height: 46.h,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

