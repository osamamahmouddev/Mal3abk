import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_skeleton_widget.dart';
import '../../../../core/widgets/empty_note_box_widget.dart';
import '../cubit/home_team_activity_cubit.dart';
import '../cubit/home_team_activity_state.dart';
import 'home_no_team_card_widget.dart';
import 'home_pending_result_card_widget.dart';
import 'home_team_activity_card_widget.dart';

class HomeTeamActivityBlocBuilder extends StatelessWidget {
  const HomeTeamActivityBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final cubit = context.read<HomeTeamActivityCubit>();

    Future<void> open(String route, String id) async {
      await Navigator.of(context).pushNamed(route, arguments: id);
      await cubit.load();
    }

    return BlocBuilder<HomeTeamActivityCubit, HomeTeamActivityState>(
      builder: (context, state) {
        if (state is! HomeTeamActivitySuccess) {
          return state is HomeTeamActivityError
              ? EmptyNoteBoxWidget(text: state.message.tr(context: context))
              : const CustomSkeletonWidget(height: 58);
        }
        final activity = state.activity;
        if (!activity.hasTeams) return const HomeNoTeamCardWidget();
        if (activity.isQuiet) {
          return EmptyNoteBoxWidget(
            text: 'home.activity.quiet'.tr(context: context),
          );
        }

        final challenge = activity.challengeAwaitingReply;
        final pending = activity.matchAwaitingResult;
        final next = activity.nextMatch;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (challenge != null)
              HomeTeamActivityCardWidget(
                initials: (challenge.challengerTeamName ?? '').initials,
                title: 'home.activity.challenge'.tr(
                  context: context,
                  args: [challenge.challengerTeamName ?? ''],
                ),
                subtitle: CairoTime.dayAndTime(challenge.proposedDateUtc, lang),
                onTap: () => open(AppRoutes.challengeDetails, challenge.id),
              )
            else if (next != null)
              HomeTeamActivityCardWidget(
                initials: next.awayTeamName.initials,
                title: 'home.activity.next_match'.tr(
                  context: context,
                  args: [next.homeTeamName, next.awayTeamName],
                ),
                subtitle: [
                  CairoTime.dayAndTime(next.scheduledStartUtc, lang),
                  ?next.venueName,
                ].join(' · '),
                onTap: () => open(AppRoutes.matchDetails, next.id),
              ),
            if (pending != null) ...[
              if (challenge != null || next != null) hSpace(10),
              HomePendingResultCardWidget(
                title:
                    (pending.canVerifyResult
                            ? 'home.activity.verify_result'
                            : 'home.activity.submit_result')
                        .tr(context: context),
                subtitle: [
                  '${pending.match.homeTeamName} – ${pending.match.awayTeamName}',
                  CairoTime.shortDate(pending.match.scheduledStartUtc, lang),
                ].join(' · '),
                onTap: () => open(AppRoutes.matchDetails, pending.match.id),
              ),
            ],
          ],
        );
      },
    );
  }
}
