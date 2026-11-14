import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

/// The rankings shortcut beside the teams title. Creating and joining a team
/// live in `TeamsQuickActionsWidget` under the title.
class MyTeamsHeaderActionsWidget extends StatelessWidget {
  const MyTeamsHeaderActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.goldLight,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.rankings),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.emoji_events_outlined,
                size: 18.r,
                color: AppColors.goldDark,
              ),
              vSpace(6),
              Text(
                'teams.list.rankings'.tr(context: context),
                style: AppTextStyles.font13SemiBold.copyWith(
                  color: AppColors.goldDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
