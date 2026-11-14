import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../data/models/team_summary_model.dart';
import 'team_stat_widget.dart';

/// Matches played, rating and members, side by side.
class MyTeamCardStatsWidget extends StatelessWidget {
  const MyTeamCardStatsWidget({required this.team, super.key});

  final TeamSummaryModel team;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;

    return Container(
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
              // Every team starts at 1500; it only means something once the
              // team has played.
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
    );
  }
}
