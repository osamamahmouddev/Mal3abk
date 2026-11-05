import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/section_header_widget.dart';
import '../../../matches/data/models/team_challenge_model.dart';
import 'team_result_row_widget.dart';

class TeamChallengesSectionWidget extends StatelessWidget {
  const TeamChallengesSectionWidget({
    required this.teamId,
    required this.challenges,
    required this.onReturn,
    super.key,
  });

  final String teamId;
  final List<TeamChallengeModel> challenges;
  final VoidCallback onReturn;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeaderWidget(
          title: 'teams.challenges.title'.tr(
            context: context,
            args: [challenges.length.toLocalizedDigits(lang)],
          ),
        ),
        hSpace(12),
        CustomCardWidget(
          borderRadius: 18,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (final (i, challenge) in challenges.indexed)
                TeamResultRowWidget(
                  type: challenge.isMyTurn
                      ? TeamResultType.loss
                      : TeamResultType.pending,
                  letter: challenge.isMyTurn ? '!' : '…',
                  title: 'teams.profile.vs'.tr(
                    context: context,
                    args: [
                      (challenge.challengerTeamId == teamId
                              ? challenge.challengedTeamName
                              : challenge.challengerTeamName) ??
                          '',
                    ],
                  ),
                  meta: [
                    CairoTime.dayAndTime(challenge.proposedDateUtc, lang),
                    (challenge.isMyTurn
                            ? 'teams.challenges.your_turn'
                            : 'teams.challenges.waiting')
                        .tr(context: context),
                  ].join(' · '),
                  score: '',
                  showDivider: i < challenges.length - 1,
                  onTap: () async {
                    await Navigator.of(context).pushNamed(
                      AppRoutes.challengeDetails,
                      arguments: challenge.id,
                    );
                    onReturn();
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
