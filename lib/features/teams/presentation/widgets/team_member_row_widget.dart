import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class TeamMemberRowWidget extends StatelessWidget {
  const TeamMemberRowWidget({
    required this.name,
    required this.details,
    required this.isCaptain,
    super.key,
  });

  final String name;
  final String details;
  final bool isCaptain;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.brandNavy,
            child: Text(
              name.substring(0, 1),
              style: AppTextStyles.font14Bold.copyWith(color: AppColors.white),
            ),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.font14Bold),
                hSpace(2),
                Text(details, style: AppTextStyles.font12Regular),
              ],
            ),
          ),
          if (isCaptain)
            const AppBadgeWidget(text: 'الكابتن', type: AppBadgeType.accent)
          else
            Icon(Icons.more_vert_rounded, size: 20.sp, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
