import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../data/models/team_profile_model.dart';
import '../cubit/team_action_cubit.dart';
import 'team_member_options_sheet_widget.dart';
import 'team_member_row_widget.dart';

/// The roster on the manage screen. The captain manages everyone else; a
/// vice-captain only plain members, as the server allows.
class TeamMembersCardWidget extends StatelessWidget {
  const TeamMembersCardWidget({required this.profile, super.key});

  final TeamProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;

    return CustomCardWidget(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (final member in profile.roster)
            TeamMemberRowWidget(
              initials: (member.playerName ?? '؟').initials,
              name: member.playerName ?? '—',
              details: [
                if (member.isViceCaptain)
                  'teams.roles.vice_captain'.tr(context: context),
                'teams.manage.joined'.tr(
                  context: context,
                  args: [CairoTime.shortDate(member.joinedAtUtc, lang)],
                ),
              ].join(' · '),
              isCaptain: member.isCaptain,
              onOptions:
                  member.isCaptain ||
                      (!profile.isCaptain && member.isViceCaptain)
                  ? null
                  : () => showModalBottomSheet<void>(
                      context: context,
                      backgroundColor: AppColors.white,
                      builder: (_) => BlocProvider.value(
                        value: context.read<TeamActionCubit>(),
                        child: TeamMemberOptionsSheetWidget(
                          teamId: profile.id,
                          member: member,
                          callerIsCaptain: profile.isCaptain,
                        ),
                      ),
                    ),
            ),
        ],
      ),
    );
  }
}
