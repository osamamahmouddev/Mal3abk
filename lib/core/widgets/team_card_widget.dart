import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'custom_card_widget.dart';

class TeamCardWidget extends StatelessWidget {
  const TeamCardWidget({
    required this.teamName,
    required this.captainName,
    required this.initials,
    super.key,
    this.badgeText,
    this.membersCountText,
    this.ratingText,
    this.onTap,
    this.actionWidget,
  });

  final String teamName;
  final String captainName;
  final String initials;
  final String? badgeText;
  final String? membersCountText;
  final String? ratingText;
  final VoidCallback? onTap;
  final Widget? actionWidget;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      onTap: onTap,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26.r,
            backgroundColor: AppColors.brandNavy,
            child: Text(
              initials,
              style: AppTextStyles.font16Bold.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        teamName,
                        style: AppTextStyles.font16Bold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (badgeText != null) ...[
                      SizedBox(width: 6.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.goldLight,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          badgeText!,
                          style: AppTextStyles.font11Bold.copyWith(
                            color: AppColors.goldDark,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'كابتن: $captainName',
                  style: AppTextStyles.font13Regular,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (membersCountText != null || ratingText != null) ...[
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      if (membersCountText != null)
                        Text(
                          membersCountText!,
                          style: AppTextStyles.font12Medium,
                        ),
                      if (membersCountText != null && ratingText != null)
                        Text(
                          ' · ',
                          style: AppTextStyles.font12Medium,
                        ),
                      if (ratingText != null)
                        Text(
                          ratingText!,
                          style: AppTextStyles.font12Bold.copyWith(
                            color: AppColors.goldDark,
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (actionWidget != null) ...[
            SizedBox(width: 10.w),
            actionWidget!,
          ],
        ],
      ),
    );
  }
}

