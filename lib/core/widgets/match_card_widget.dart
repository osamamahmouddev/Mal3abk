import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'app_badge_widget.dart';
import 'custom_card_widget.dart';

class MatchCardWidget extends StatelessWidget {
  const MatchCardWidget({
    required this.team1Name,
    required this.team1Initials,
    required this.team2Name,
    required this.team2Initials,
    required this.dateTime,
    required this.pitchName,
    super.key,
    this.scoreTeam1,
    this.scoreTeam2,
    this.statusText,
    this.statusType = AppBadgeType.neutral,
    this.onTap,
  });

  final String team1Name;
  final String team1Initials;
  final String team2Name;
  final String team2Initials;
  final String dateTime;
  final String pitchName;
  final int? scoreTeam1;
  final int? scoreTeam2;
  final String? statusText;
  final AppBadgeType statusType;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final hasScore = scoreTeam1 != null && scoreTeam2 != null;

    return CustomCardWidget(
      onTap: onTap,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateTime,
                style: AppTextStyles.font12Regular,
              ),
              if (statusText != null)
                AppBadgeWidget(
                  text: statusText!,
                  type: statusType,
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Team 1
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 24.r,
                      backgroundColor: AppColors.brandNavy,
                      child: Text(
                        team1Initials,
                        style: AppTextStyles.font14Bold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      team1Name,
                      style: AppTextStyles.font14SemiBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Score / VS
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  hasScore ? '$scoreTeam1  –  $scoreTeam2' : 'ضد',
                  style: hasScore
                      ? AppTextStyles.font18Bold.copyWith(
                          color: AppColors.brandNavy,
                        )
                      : AppTextStyles.font14SemiBold.copyWith(
                          color: AppColors.textSecondary,
                        ),
                ),
              ),
              // Team 2
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 24.r,
                      backgroundColor: AppColors.brandRed,
                      child: Text(
                        team2Initials,
                        style: AppTextStyles.font14Bold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      team2Name,
                      style: AppTextStyles.font14SemiBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14.sp,
                color: AppColors.textSecondary,
              ),
              SizedBox(width: 4.w),
              Text(
                pitchName,
                style: AppTextStyles.font12Regular,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

