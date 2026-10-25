import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class TeamMemberTileWidget extends StatelessWidget {
  const TeamMemberTileWidget({
    required this.name,
    required this.role,
    required this.isCaptain,
    super.key,
  });

  final String name;
  final String role;
  final bool isCaptain;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.lightSurface,
            child: Text(name.substring(0, 1), style: AppTextStyles.font13SemiBold),
          ),
          vSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.font14SemiBold),
                Text(role, style: AppTextStyles.font11Regular),
              ],
            ),
          ),
          if (isCaptain) const AppBadgeWidget(text: 'كابتن', type: AppBadgeType.warning),
        ],
      ),
    );
  }
}
