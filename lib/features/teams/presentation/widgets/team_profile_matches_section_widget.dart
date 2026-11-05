import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/empty_note_box_widget.dart';
import '../../data/models/match_summary_model.dart';
import '../../data/models/team_profile_model.dart';
import 'team_result_row_widget.dart';

class TeamProfileMatchesSectionWidget extends StatelessWidget {
  const TeamProfileMatchesSectionWidget({required this.profile, super.key});

  final TeamProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    String t(String key) => 'teams.profile.$key'.tr(context: context);
    String score(MatchSummaryModel match) =>
        '${(match.homeScore ?? 0).toLocalizedDigits(lang)}–${(match.awayScore ?? 0).toLocalizedDigits(lang)}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t('upcoming'), style: AppTextStyles.font15Bold),
        hSpace(14),
        if (profile.upcomingMatches.isEmpty)
          EmptyNoteBoxWidget(text: t('no_matches'))
        else
          CustomCardWidget(
            borderRadius: 18,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (final (i, match) in profile.upcomingMatches.indexed)
                  TeamResultRowWidget(
                    type: TeamResultType.pending,
                    letter: t('res_pending'),
                    title: 'teams.profile.vs'.tr(
                      context: context,
                      args: [match.opponentName(profile.id)],
                    ),
                    meta: CairoTime.dayAndTime(match.scheduledAtUtc, lang),
                    score: '',
                    showDivider: i < profile.upcomingMatches.length - 1,
                  ),
              ],
            ),
          ),
        hSpace(10),
        Text(t('last_results'), style: AppTextStyles.font15Bold),
        hSpace(14),
        if (profile.recentMatches.isEmpty)
          EmptyNoteBoxWidget(text: t('no_results'))
        else
          CustomCardWidget(
            borderRadius: 18,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (final (i, match) in profile.recentMatches.indexed)
                  TeamResultRowWidget(
                    type: switch (match.resultFor(profile.id)) {
                      MatchResultForTeam.win => TeamResultType.win,
                      MatchResultForTeam.draw => TeamResultType.draw,
                      MatchResultForTeam.loss => TeamResultType.loss,
                      MatchResultForTeam.pending => TeamResultType.pending,
                    },
                    letter: switch (match.resultFor(profile.id)) {
                      MatchResultForTeam.win => t('res_win'),
                      MatchResultForTeam.draw => t('res_draw'),
                      MatchResultForTeam.loss => t('res_loss'),
                      MatchResultForTeam.pending => t('res_pending'),
                    },
                    title: 'teams.profile.vs'.tr(
                      context: context,
                      args: [match.opponentName(profile.id)],
                    ),
                    meta: CairoTime.shortDate(match.scheduledAtUtc, lang),
                    score: score(match),
                    showDivider: i < profile.recentMatches.length - 1,
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
