import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../cubit/team_dashboard_cubit.dart';
import '../cubit/team_dashboard_state.dart';
import 'team_disband_button_widget.dart';
import 'team_join_requests_section_widget.dart';
import 'team_members_card_widget.dart';
import 'team_settings_card_widget.dart';

class ManageMembersBlocBuilder extends StatelessWidget {
  const ManageMembersBlocBuilder({required this.teamId, super.key});

  final String teamId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamDashboardCubit, TeamDashboardState>(
      builder: (context, state) {
        return switch (state) {
          TeamDashboardSuccess(:final dashboard) => ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
            children: [
              if (dashboard.pendingJoinRequests.isNotEmpty) ...[
                TeamJoinRequestsSectionWidget(
                  requests: dashboard.pendingJoinRequests,
                ),
                hSpace(14),
              ],
              TeamMembersCardWidget(profile: dashboard.profile),
              hSpace(14),
              Text(
                'teams.settings.title'.tr(context: context),
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(10),
              TeamSettingsCardWidget(profile: dashboard.profile),
              // Nobody to hand captaincy to: leaving closes the team.
              if (dashboard.profile.isCaptain &&
                  dashboard.profile.roster.length == 1) ...[
                hSpace(20),
                TeamDisbandButtonWidget(teamId: teamId),
              ],
            ],
          ),
          TeamDashboardError(:final message) => CustomStateWidget(
            title: message.tr(context: context),
            description: '',
            actionText: 'common.retry'.tr(context: context),
            onActionTap: () => context.read<TeamDashboardCubit>().load(teamId),
          ),
          _ => const ShimmerListSkeletonWidget(itemHeight: 72, itemCount: 6),
        };
      },
    );
  }
}
