import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_skeleton_widget.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../cubit/team_invite_cubit.dart';
import '../cubit/team_invite_state.dart';
import 'invite_code_card_widget.dart';

class TeamInviteBlocBuilder extends StatelessWidget {
  const TeamInviteBlocBuilder({required this.teamId, super.key});

  final String teamId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamInviteCubit, TeamInviteState>(
      builder: (context, state) => switch (state) {
        TeamInviteSuccess(:final invitation) => InviteCodeCardWidget(
          code: invitation.inviteCode,
        ),
        TeamInviteError(:final message) => CustomStateWidget(
          title: message.tr(context: context),
          description: '',
          actionText: 'common.retry'.tr(context: context),
          onActionTap: () => context.read<TeamInviteCubit>().createCode(teamId),
        ),
        _ => const CustomSkeletonWidget(height: 220, borderRadius: 18),
      },
    );
  }
}
