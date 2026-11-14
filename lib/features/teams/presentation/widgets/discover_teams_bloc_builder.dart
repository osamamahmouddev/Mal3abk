import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/widgets/fade_slide_in_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../cubit/discover_teams_cubit.dart';
import '../cubit/discover_teams_state.dart';
import 'discover_team_card_widget.dart';

class DiscoverTeamsBlocBuilder extends StatelessWidget {
  const DiscoverTeamsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverTeamsCubit, DiscoverTeamsState>(
      builder: (context, state) {
        return switch (state) {
          DiscoverTeamsSuccess(:final teams) when teams.isEmpty =>
            CustomStateWidget(
              title: 'teams.list.discover_empty'.tr(context: context),
              description: '',
            ),
          DiscoverTeamsSuccess(:final teams, :final hasMore) =>
            NotificationListener<ScrollEndNotification>(
              onNotification: (notification) {
                if (hasMore && notification.metrics.extentAfter < 300) {
                  context.read<DiscoverTeamsCubit>().loadMore();
                }
                return false;
              },
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  16.w,
                  4.h,
                  16.w,
                  16.h + MediaQuery.paddingOf(context).bottom,
                ),
                itemCount: teams.length + (hasMore ? 1 : 0),
                separatorBuilder: (_, _) => hSpace(10),
                itemBuilder: (_, index) => index == teams.length
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : FadeSlideInWidget(
                        index: index,
                        child: DiscoverTeamCardWidget(team: teams[index]),
                      ),
              ),
            ),
          DiscoverTeamsError(:final message) => CustomStateWidget(
            title: message.tr(context: context),
            description: '',
            actionText: 'common.retry'.tr(context: context),
            onActionTap: () => context.read<DiscoverTeamsCubit>().load(),
          ),
          _ => const ShimmerListSkeletonWidget(itemHeight: 104),
        };
      },
    );
  }
}
