import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import 'team_stat_box_widget.dart';

class TeamStatsGridWidget extends StatelessWidget {
  const TeamStatsGridWidget({
    required this.wins,
    required this.draws,
    required this.losses,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.winRate,
    super.key,
  });

  final String wins;
  final String draws;
  final String losses;
  final String goalsFor;
  final String goalsAgainst;
  final String winRate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TeamStatBoxWidget(
                value: wins,
                label: 'teams.wins'.tr(context: context),
                valueColor: AppColors.successGreen,
              ),
            ),
            vSpace(8),
            Expanded(
              child: TeamStatBoxWidget(
                value: draws,
                label: 'teams.draws'.tr(context: context),
              ),
            ),
            vSpace(8),
            Expanded(
              child: TeamStatBoxWidget(
                value: losses,
                label: 'teams.losses'.tr(context: context),
                valueColor: AppColors.redText,
              ),
            ),
          ],
        ),
        hSpace(8),
        Row(
          children: [
            Expanded(
              child: TeamStatBoxWidget(
                value: goalsFor,
                label: 'teams.profile.goals_for'.tr(context: context),
              ),
            ),
            vSpace(8),
            Expanded(
              child: TeamStatBoxWidget(
                value: goalsAgainst,
                label: 'teams.profile.goals_against'.tr(context: context),
              ),
            ),
            vSpace(8),
            Expanded(
              child: TeamStatBoxWidget(
                value: winRate,
                label: 'teams.profile.win_rate'.tr(context: context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
