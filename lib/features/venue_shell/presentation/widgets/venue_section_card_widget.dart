import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

/// A titled white card used by the venue dashboard sections.
class VenueSectionCardWidget extends StatelessWidget {
  const VenueSectionCardWidget({
    required this.title,
    required this.child,
    this.subtitle,
    this.actionText,
    this.onAction,
    this.trailing,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onAction;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      padding: EdgeInsets.all(16.r),
      borderRadius: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(title, style: AppTextStyles.font16Bold),
                ),
              ),
              ?trailing,
              if (actionText != null)
                TextButton(
                  onPressed: onAction,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    minimumSize: Size(0, 36.h),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        actionText!,
                        style: AppTextStyles.font13Bold.copyWith(
                          color: AppColors.brandRed,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 18.r,
                        color: AppColors.brandRed,
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (subtitle != null) ...[
            hSpace(2),
            Text(
              subtitle!,
              style: AppTextStyles.font12Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
          hSpace(12),
          child,
        ],
      ),
    );
  }
}

/// A short muted line with an icon, for empty sections.
class VenueEmptyLineWidget extends StatelessWidget {
  const VenueEmptyLineWidget({
    required this.icon,
    required this.text,
    super.key,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18.r, color: AppColors.textMuted),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.font13Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
