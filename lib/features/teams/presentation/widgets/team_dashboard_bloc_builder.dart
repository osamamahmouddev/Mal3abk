import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../cubit/team_dashboard_cubit.dart';
import '../cubit/team_dashboard_state.dart';
import 'team_join_requests_section_widget.dart';
import 'team_profile_header_section_widget.dart';
import 'team_profile_matches_section_widget.dart';
import 'team_profile_players_section_widget.dart';

class TeamDashboardBlocBuilder extends StatelessWidget {
  const TeamDashboardBlocBuilder({required this.teamId, super.key});

  final String teamId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamDashboardCubit, TeamDashboardState>(
      builder: (context, state) {
        return switch (state) {
          TeamDashboardSuccess(:final dashboard) => RefreshIndicator.adaptive(
            onRefresh: () => context.read<TeamDashboardCubit>().load(teamId),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: EdgeInsets.only(bottom: 16.h),
              children: [
                TeamProfileHeaderSectionWidget(profile: dashboard.profile),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (dashboard.pendingJoinRequests.isNotEmpty) ...[
                        TeamJoinRequestsSectionWidget(
                          requests: dashboard.pendingJoinRequests,
                        ),
                        hSpace(10),
                      ],
                      TeamProfileMatchesSectionWidget(
                        profile: dashboard.profile,
                      ),
                      hSpace(10),
                      TeamProfilePlayersSectionWidget(
                        profile: dashboard.profile,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TeamDashboardError(:final message) => CustomStateWidget(
            title: message.tr(context: context),
            description: '',
            actionText: 'common.retry'.tr(context: context),
            onActionTap: () => context.read<TeamDashboardCubit>().load(teamId),
          ),
          _ => const ShimmerListSkeletonWidget(itemHeight: 160, itemCount: 4),
        };
      },
    );
  }
}
