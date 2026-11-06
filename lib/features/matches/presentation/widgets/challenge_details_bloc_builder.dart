import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../data/models/team_challenge_model.dart';
import '../cubit/challenge_details_cubit.dart';
import '../cubit/challenge_details_state.dart';
import 'challenge_info_card_widget.dart';
import 'team_matchup_header_widget.dart';

class ChallengeDetailsBlocBuilder extends StatelessWidget {
  const ChallengeDetailsBlocBuilder({required this.challengeId, super.key});

  final String challengeId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChallengeDetailsCubit>();
    return BlocBuilder<ChallengeDetailsCubit, ChallengeDetailsState>(
      builder: (context, state) {
        return switch (state) {
          ChallengeDetailsSuccess(:final details) => RefreshIndicator.adaptive(
            onRefresh: () => cubit.load(challengeId),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              children: [
                TeamMatchupHeaderWidget(
                  homeName: details.challenge.challengerTeamName ?? '',
                  awayName: details.challenge.challengedTeamName ?? '',
                  center: 'common.vs'.tr(context: context),
                  homeCaption:
                      details.myTeam?.id == details.challenge.challengerTeamId
                      ? 'matches.challenge.your_team'.tr(context: context)
                      : null,
                  awayCaption:
                      details.myTeam?.id == details.challenge.challengedTeamId
                      ? 'matches.challenge.your_team'.tr(context: context)
                      : null,
                ),
                hSpace(14),
                if (details.challenge.isOpen) ...[
                  AlertBannerWidget(
                    type: details.canRespond
                        ? AlertBannerType.warning
                        : AlertBannerType.info,
                    message: details.canRespond
                        ? 'matches.challenge.your_turn'.tr(context: context)
                        : 'matches.challenge.waiting'.tr(
                            context: context,
                            args: [details.challenge.waitingTeamName],
                          ),
                  ),
                  hSpace(14),
                ],
                if (details.challenge.status == ChallengeStatus.accepted &&
                    details.challenge.matchId != null) ...[
                  AlertBannerWidget(
                    message: 'matches.challenge.accepted_note'.tr(
                      context: context,
                    ),
                  ),
                  hSpace(14),
                ],
                ChallengeInfoCardWidget(challenge: details.challenge),
              ],
            ),
          ),
          ChallengeDetailsError(:final message) => CustomStateWidget(
            title: message.tr(context: context),
            description: '',
            actionText: 'common.retry'.tr(context: context),
            onActionTap: () => cubit.load(challengeId),
          ),
          _ => const ShimmerListSkeletonWidget(itemHeight: 140, itemCount: 3),
        };
      },
    );
  }
}
