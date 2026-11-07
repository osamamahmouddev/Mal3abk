import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/initials_avatar_widget.dart';
import '../../data/models/team_summary_model.dart';
import 'my_team_card_actions_widget.dart';
import 'team_stat_widget.dart';

class MyTeamCardWidget extends StatelessWidget {
  const MyTeamCardWidget({required this.team, super.key});

  final TeamSummaryModel team;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderCard),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
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
                          args: [
                            team.city,
                            team.memberCount.toLocalizedDigits(lang),
                          ],
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            height: 62.h,
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.lightSurface)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TeamStatWidget(
                    value: team.matchesPlayed.toLocalizedDigits(lang),
                    label: 'teams.played_matches'.tr(context: context),
                  ),
                ),
                Expanded(
                  child: TeamStatWidget(
                    // Every team starts at 1500; it only means something once
                    // the team has played.
                    value: team.matchesPlayed == 0
                        ? '—'
                        : team.rating.round().toLocalizedDigits(lang),
                    label: 'teams.common.rating'.tr(context: context),
                    isRank: true,
                  ),
                ),
                Expanded(
                  child: TeamStatWidget(
                    value: team.memberCount.toLocalizedDigits(lang),
                    label: 'teams.members'.tr(context: context),
                  ),
                ),
              ],
            ),
          ),
          MyTeamCardActionsWidget(
            showManage: team.isCaptain,
            onTeamPage: () => Navigator.of(
              context,
            ).pushNamed(AppRoutes.teamProfile, arguments: team.id),
            onManage: () => Navigator.of(
              context,
            ).pushNamed(AppRoutes.manageMembers, arguments: team.id),
          ),
        ],
      ),
    );
  }
}
