import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/section_header_widget.dart';
import '../../data/models/team_profile_model.dart';
import 'team_player_row_widget.dart';

class TeamProfilePlayersSectionWidget extends StatelessWidget {
  const TeamProfilePlayersSectionWidget({required this.profile, super.key});

  final TeamProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final roster = profile.roster;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeaderWidget(
          title: 'teams.profile.players'.tr(
            context: context,
            args: [roster.length.toLocalizedDigits(lang)],
          ),
          actionText: profile.isCaptain
              ? 'teams.profile.manage'.tr(context: context)
              : null,
          onAction: () => Navigator.of(
            context,
          ).pushNamed(AppRoutes.manageMembers, arguments: profile.id),
        ),
        hSpace(14),
        CustomCardWidget(
          borderRadius: 18,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (final (i, member) in roster.indexed)
                TeamPlayerRowWidget(
                  initials: (member.playerName ?? '؟').initials,
                  name: member.isCaptain
                      ? 'teams.profile.captain_suffix'.tr(
                          context: context,
                          args: [member.playerName ?? ''],
                        )
                      : member.playerName ?? '—',
                  position: member.isViceCaptain
                      ? 'teams.roles.vice_captain'.tr(context: context)
                      : member.position ?? '',
                  showDivider: i < roster.length - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
