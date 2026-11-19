import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../cubit/match_details_cubit.dart';
import '../cubit/match_details_state.dart';
import 'match_status_badge_widget.dart';
import 'match_status_banner_widget.dart';
import 'team_matchup_header_widget.dart';
import '../../../../core/animations/ball_refresh_indicator.dart';

class MatchDetailsBlocBuilder extends StatelessWidget {
  const MatchDetailsBlocBuilder({required this.matchId, super.key});

  final String matchId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MatchDetailsCubit>();
    final lang = context.locale.languageCode;
    return BlocBuilder<MatchDetailsCubit, MatchDetailsState>(
      builder: (context, state) {
        return switch (state) {
          MatchDetailsSuccess(:final details) => () {
            final match = details.match;
            String t(String key) => 'matches.match.$key'.tr(context: context);
            return BallRefreshIndicator(
              onRefresh: () => cubit.load(matchId),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                children: [
                  TeamMatchupHeaderWidget(
                    homeName: match.homeTeamName,
                    awayName: match.awayTeamName,
                    center: 'common.vs'.tr(context: context),
                    score: match.hasScore
                        ? (
                            match.homeScore!.toLocalizedDigits(lang),
                            match.awayScore!.toLocalizedDigits(lang),
                          )
                        : null,
                    homeCaption: details.myTeam?.id == match.homeTeamId
                        ? 'matches.challenge.your_team'.tr(context: context)
                        : null,
                    awayCaption: details.myTeam?.id == match.awayTeamId
                        ? 'matches.challenge.your_team'.tr(context: context)
                        : null,
                  ),
                  hSpace(14),
                  MatchStatusBannerWidget(
                    details: details,
                    nowUtc: DateTime.now().toUtc(),
                  ),
                  hSpace(14),
                  CustomCardWidget(
                    borderRadius: 18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                CairoTime.dayAndTime(
                                  match.scheduledStartUtc,
                                  lang,
                                ),
                                style: AppTextStyles.font14SemiBold,
                              ),
                            ),
                            MatchStatusBadgeWidget(match: match),
                          ],
                        ),
                        hSpace(8),
                        Text(
                          '${match.venueName ?? t('venue_tbd')} · ${'matches.minutes'.tr(context: context, args: [match.durationMinutes.toLocalizedDigits(lang)])}',
                          style: AppTextStyles.font12Regular,
                        ),
                        if (match.notes case final notes?
                            when notes.isNotEmpty) ...[
                          hSpace(8),
                          Text(notes, style: AppTextStyles.font13Regular),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          }(),
          MatchDetailsError(:final message) => CustomStateWidget(
            title: message.tr(context: context),
            description: '',
            actionText: 'common.retry'.tr(context: context),
            onActionTap: () => cubit.load(matchId),
          ),
          _ => const ShimmerListSkeletonWidget(itemHeight: 140, itemCount: 3),
        };
      },
    );
  }
}
