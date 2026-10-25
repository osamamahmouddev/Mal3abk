import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class TeamRankCardWidget extends StatelessWidget {
  const TeamRankCardWidget({
    required this.rank,
    required this.teamName,
    required this.record,
    required this.points,
    required this.isFirst,
    super.key,
    this.isMyTeam = false,
  });

  final int rank;
  final String teamName;
  final String record;
  final String points;
  final bool isFirst;
  final bool isMyTeam;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      backgroundColor: isMyTeam ? AppColors.goldLight : AppColors.white,
      borderColor: isMyTeam ? AppColors.goldBorder : AppColors.borderCard,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isFirst ? AppColors.accentGold : AppColors.lightSurface,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$rank',
              style: AppTextStyles.font14Bold.copyWith(
                color: isFirst ? AppColors.textPrimary : AppColors.brandNavy,
              ),
            ),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(teamName, style: AppTextStyles.font15Bold),
                hSpace(2),
                Text(record, style: AppTextStyles.font12Regular),
              ],
            ),
          ),
          Text(points, style: AppTextStyles.font15Bold.copyWith(color: AppColors.brandNavy)),
        ],
      ),
    );
  }
}
