import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

enum AlertBannerType {
  info,
  warning,
  error,
  offline,
}

class AlertBannerWidget extends StatelessWidget {
  const AlertBannerWidget({
    required this.message,
    super.key,
    this.type = AlertBannerType.info,
    this.actionText,
    this.onActionTap,
    this.icon,
  });

  final String message;
  final AlertBannerType type;
  final String? actionText;
  final VoidCallback? onActionTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    Border? border;
    IconData defaultIcon;

    switch (type) {
      case AlertBannerType.info:
        bg = AppColors.lightSurface;
        fg = AppColors.brandNavy;
        defaultIcon = Icons.info_outline_rounded;
        break;
      case AlertBannerType.warning:
        bg = AppColors.goldLight;
        fg = AppColors.goldDark;
        border = Border.all(color: AppColors.goldBorder, width: 1);
        defaultIcon = Icons.warning_amber_rounded;
        break;
      case AlertBannerType.error:
        bg = AppColors.redLight;
        fg = AppColors.redText;
        border = Border.all(color: AppColors.redBorder, width: 1);
        defaultIcon = Icons.error_outline_rounded;
        break;
      case AlertBannerType.offline:
        bg = AppColors.lightSurface;
        fg = AppColors.textPrimary;
        border = Border.all(color: AppColors.border, width: 1);
        defaultIcon = Icons.wifi_off_rounded;
        break;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12.r),
        border: border,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon ?? defaultIcon,
            size: 20.sp,
            color: fg,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.font13Regular.copyWith(color: fg),
            ),
          ),
          if (actionText != null) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionText!,
                style: AppTextStyles.font13SemiBold.copyWith(
                  color: fg,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

