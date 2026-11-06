import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class NotificationItemCardWidget extends StatelessWidget {
  const NotificationItemCardWidget({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.time,
    required this.isUnread,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String time;
  final bool isUnread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      backgroundColor: isUnread ? AppColors.white : AppColors.lightSurface,
      margin: EdgeInsets.only(bottom: 10.h),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: isUnread
                ? AppColors.lightSurface
                : AppColors.white,
            child: Icon(icon, color: iconColor, size: 22.sp),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: isUnread
                      ? AppTextStyles.font14Bold
                      : AppTextStyles.font14Medium,
                ),
                hSpace(4),
                Text(time, style: AppTextStyles.font11Regular),
              ],
            ),
          ),
          if (isUnread) ...[
            vSpace(8),
            Container(
              width: 8.w,
              height: 8.h,
              decoration: const BoxDecoration(
                color: AppColors.brandRed,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
