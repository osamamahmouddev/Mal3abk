import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'custom_button.dart';
import 'fade_slide_in_widget.dart';
import 'state_illustration_widget.dart';

/// Full-area empty, error or loading state: an illustrated icon, a short
/// title, one line of guidance and an optional next step.
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
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 300.w),
          child: FadeSlideInWidget(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading) ...[
                  RSizedBox(
                    width: 48.w,
                    height: 48.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.brandNavy,
                      ),
                    ),
                  ),
                  hSpace(24),
                ] else if (icon != null) ...[
                  StateIllustrationWidget(icon: icon!),
                  hSpace(24),
                ],
                Text(
                  title,
                  style: AppTextStyles.font18Bold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                hSpace(8),
                Text(
                  description,
                  style: AppTextStyles.font14Regular.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (actionText != null && onActionTap != null) ...[
                  hSpace(28),
                  CustomButton(
                    text: actionText!,
                    onTap: onActionTap!,
                    width: 200.w,
                    height: 48.h,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
