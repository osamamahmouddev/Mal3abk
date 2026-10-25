import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class NotificationPreviewCardWidget extends StatelessWidget {
  const NotificationPreviewCardWidget({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.time,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.white,
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.font13SemiBold,
                ),
                hSpace(2),
                Text(
                  time,
                  style: AppTextStyles.font11Regular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
