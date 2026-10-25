import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class NotificationDetailCardWidget extends StatelessWidget {
  const NotificationDetailCardWidget({
    required this.icon,
    required this.title,
    required this.time,
    required this.content,
    super.key,
  });

  final IconData icon;
  final String title;
  final String time;
  final String content;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.successLight,
                child: Icon(icon, color: AppColors.successGreen, size: 22.sp),
              ),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.font16Bold),
                    Text(time, style: AppTextStyles.font11Regular),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24, color: AppColors.border),
          Text(
            content,
            style: AppTextStyles.font13Regular,
          ),
        ],
      ),
    );
  }
}
