import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../widgets/leaderboard_bloc_builder.dart';
import '../widgets/my_team_rank_bar_bloc_builder.dart';

class RankingsScreen extends StatelessWidget {
  const RankingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.pageBackground,
      bottomNavigationBar: MyTeamRankBarBlocBuilder(),
      body: LeaderboardBlocBuilder(),
    );
  }
}
