import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../data/models/team_summary_model.dart';
import 'my_team_card_actions_widget.dart';
import 'my_team_card_header_widget.dart';
import 'my_team_card_stats_widget.dart';

class MyTeamCardWidget extends StatelessWidget {
  const MyTeamCardWidget({required this.team, super.key});

  final TeamSummaryModel team;

  @override
  Widget build(BuildContext context) {
    void openTeam() => Navigator.of(
      context,
    ).pushNamed(AppRoutes.teamProfile, arguments: team.id);

    // A tap anywhere opens the team; the manage button keeps its own target.
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderCard),
        boxShadow: AppShadows.card,
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: openTeam,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyTeamCardHeaderWidget(team: team),
              MyTeamCardStatsWidget(team: team),
              MyTeamCardActionsWidget(
                showManage: team.isLeader,
                onTeamPage: openTeam,
                onManage: () => Navigator.of(
                  context,
                ).pushNamed(AppRoutes.manageMembers, arguments: team.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
