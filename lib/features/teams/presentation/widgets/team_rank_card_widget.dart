import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

/// One standings row: rank, team + trend, W-D-L record and points.
class TeamRankCardWidget extends StatelessWidget {
  const TeamRankCardWidget({
    required this.rank,
    required this.teamName,
    required this.trend,
    required this.record,
    required this.points,
    super.key,
    this.isMyTeam = false,
  });

  final String rank;
  final String teamName;
  final String trend;
  final String record;
  final String points;
  final bool isMyTeam;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: isMyTeam ? AppColors.goldLight : null,
        border: const Border(top: BorderSide(color: AppColors.lightSurface)),
      ),
      child: Row(
        children: [
          Container(
            width: 30.w,
            alignment: AlignmentDirectional.centerStart,
            child: Text(rank, style: AppTextStyles.font14Bold),
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(teamName, style: AppTextStyles.font14Bold),
                hSpace(2),
                Text(trend, style: AppTextStyles.font11Regular),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              record,
              textAlign: TextAlign.center,
              style: AppTextStyles.font12Regular.copyWith(color: AppColors.textBody),
            ),
          ),
          Container(
            width: 32.w,
            alignment: AlignmentDirectional.centerEnd,
            child: Text(points, style: AppTextStyles.font14Bold),
          ),
        ],
      ),
    );
  }
}
