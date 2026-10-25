import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class RankingsPodiumColumnWidget extends StatelessWidget {
  const RankingsPodiumColumnWidget({
    required this.initials,
    required this.name,
    required this.rank,
    required this.points,
    required this.blockHeight,
    super.key,
    this.isWinner = false,
  });

  final String initials;
  final String name;
  final String rank;
  final String points;
  final double blockHeight;
  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    final avatarSize = (isWinner ? 62 : 52).r;
    final fg = isWinner ? AppColors.brandNavy : AppColors.white;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isWinner ? AppColors.accentGold : AppColors.textDisabled,
              width: 3,
            ),
          ),
          child: Text(initials, style: AppTextStyles.font16Bold.copyWith(color: AppColors.brandNavy)),
        ),
        hSpace(4),
        Text(name, style: AppTextStyles.font13Bold.copyWith(color: AppColors.white)),
        hSpace(8),
        Container(
          height: blockHeight.h,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isWinner ? AppColors.accentGold : AppColors.white14,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(rank, style: AppTextStyles.font20Bold.copyWith(color: fg)),
              Text(points, style: AppTextStyles.font11Regular.copyWith(color: fg)),
            ],
          ),
        ),
      ],
    );
  }
}
