import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../cubit/leaderboard_cubit.dart';
import '../cubit/leaderboard_state.dart';
import 'team_rank_card_widget.dart';

/// "ترتيب فريقي": the user's best-placed team, pinned under the list.
class MyTeamRankBarBlocBuilder extends StatelessWidget {
  const MyTeamRankBarBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;

    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        final mine = switch (state) {
          LeaderboardSuccess(:final entries, :final myTeamIds) =>
            entries.where((e) => myTeamIds.contains(e.teamId)).firstOrNull,
          _ => null,
        };
        if (mine == null) return const SizedBox.shrink();
        return BottomActionBarWidget(
          child: TeamRankCardWidget(
            rank: mine.rank.toLocalizedDigits(lang),
            teamName: 'teams.rankings.your_team'.tr(
              context: context,
              args: [mine.name],
            ),
            trend: mine.city,
            record:
                '${mine.wins.toLocalizedDigits(lang)}-${mine.draws.toLocalizedDigits(lang)}-${mine.losses.toLocalizedDigits(lang)}',
            points: mine.points.toLocalizedDigits(lang),
            isMyTeam: true,
          ),
        );
      },
    );
  }
}
