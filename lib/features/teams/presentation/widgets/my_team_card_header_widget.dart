import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/initials_avatar_widget.dart';
import '../../data/models/team_summary_model.dart';

/// Avatar, name, city and member count, with a captain badge for the captain.
class MyTeamCardHeaderWidget extends StatelessWidget {
  const MyTeamCardHeaderWidget({required this.team, super.key});

  final TeamSummaryModel team;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;

    return Padding(
      padding: EdgeInsets.all(14.r),
      child: Row(
        children: [
          InitialsAvatarWidget(
            initials: team.name.initials,
            color: AppColors.brandRed,
            size: 48,
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(team.name, style: AppTextStyles.font16Bold),
                hSpace(4),
                Text(
                  'teams.common.meta_members'.tr(
                    context: context,
                    args: [team.city, team.memberCount.toLocalizedDigits(lang)],
                  ),
                  style: AppTextStyles.font12Regular,
                ),
              ],
            ),
          ),
          if (team.isCaptain)
            AppBadgeWidget(
              text: 'teams.list.captain'.tr(context: context),
              type: AppBadgeType.warning,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            ),
        ],
      ),
    );
  }
}
