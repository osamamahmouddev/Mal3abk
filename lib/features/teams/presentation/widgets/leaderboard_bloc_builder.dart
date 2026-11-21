import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/plain_note_box_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../cubit/leaderboard_cubit.dart';
import '../cubit/leaderboard_state.dart';
import 'rankings_header_widget.dart';
import 'rankings_table_widget.dart';

class LeaderboardBlocBuilder extends StatelessWidget {
  const LeaderboardBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        return switch (state) {
          LeaderboardSuccess(
            :final entries,
            :final governorate,
            :final myTeamIds,
            :final hasMore,
          ) =>
            // The title, region filters and podium stay put; only the
            // table under them scrolls (and pages in more teams).
            Column(
              children: [
                RankingsHeaderWidget(
                  podium: entries.take(3).toList(),
                  governorate: governorate,
                ),
                Expanded(
                  child: NotificationListener<ScrollEndNotification>(
                    onNotification: (notification) {
                      if (hasMore && notification.metrics.extentAfter < 300) {
                        context.read<LeaderboardCubit>().loadMore();
                      }
                      return false;
                    },
                    child: entries.length > 3
                        // Column titles stay pinned; only the rows scroll.
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(
                              16.w,
                              12.h,
                              16.w,
                              16.h,
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: RankingsTableWidget(
                                entries: entries.skip(3).toList(),
                                myTeamIds: myTeamIds,
                                footer: PlainNoteBoxWidget(
                                  text: 'teams.rankings.note'.tr(
                                    context: context,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : CustomStateWidget(
                            icon: const Icon(Icons.emoji_events_outlined),
                            title: entries.isEmpty
                                ? 'teams.rankings.empty'.tr(context: context)
                                : 'teams.rankings.not_ready_title'.tr(
                                    context: context,
                                  ),
                            description: 'teams.rankings.note'.tr(
                              context: context,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          LeaderboardError(:final message) => CustomStateWidget(
            title: message.tr(context: context),
            description: '',
            actionText: 'common.retry'.tr(context: context),
            onActionTap: () => context.read<LeaderboardCubit>().load(),
          ),
          _ => const ShimmerListSkeletonWidget(itemHeight: 56, itemCount: 8),
        };
      },
    );
  }
}
