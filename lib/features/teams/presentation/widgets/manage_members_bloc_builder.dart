import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../cubit/team_action_cubit.dart';
import '../cubit/team_dashboard_cubit.dart';
import '../cubit/team_dashboard_state.dart';
import 'team_join_requests_section_widget.dart';
import 'team_member_options_sheet_widget.dart';
import 'team_member_row_widget.dart';
import 'team_settings_card_widget.dart';

class ManageMembersBlocBuilder extends StatelessWidget {
  const ManageMembersBlocBuilder({required this.teamId, super.key});

  final String teamId;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;

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
              CustomCardWidget(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (final member in dashboard.profile.roster)
                      TeamMemberRowWidget(
                        initials: (member.playerName ?? '؟').initials,
                        name: member.playerName ?? '—',
                        details: 'teams.manage.joined'.tr(
                          context: context,
                          args: [CairoTime.shortDate(member.joinedAtUtc, lang)],
                        ),
                        isCaptain: member.isCaptain,
                        onOptions: member.isCaptain
                            ? null
                            : () => showModalBottomSheet<void>(
                                context: context,
                                backgroundColor: AppColors.white,
                                builder: (_) => BlocProvider.value(
                                  value: context.read<TeamActionCubit>(),
                                  child: TeamMemberOptionsSheetWidget(
                                    teamId: teamId,
                                    member: member,
                                  ),
                                ),
                              ),
                      ),
                  ],
                ),
              ),
              hSpace(14),
              Text(
                'teams.settings.title'.tr(context: context),
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(10),
              TeamSettingsCardWidget(profile: dashboard.profile),
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
