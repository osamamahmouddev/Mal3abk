import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_card_widget.dart';
import '../../data/models/team_profile_model.dart';
import '../../data/models/update_team_settings_request_body.dart';
import '../cubit/team_action_cubit.dart';
import 'team_setting_switch_row_widget.dart';

class TeamSettingsCardWidget extends StatelessWidget {
  const TeamSettingsCardWidget({required this.profile, super.key});

  final TeamProfileModel profile;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'teams.settings.$key'.tr(context: context);
    void update({bool? isPublic, bool? isRecruiting, bool? isOpen}) =>
        context.read<TeamActionCubit>().updateSettings(
          profile.id,
          UpdateTeamSettingsRequestBody(
            isPublic: isPublic ?? profile.isPublic,
            isRecruiting: isRecruiting ?? profile.isRecruiting,
            isOpenForChallenges: isOpen ?? profile.isOpenForChallenges,
          ),
        );

    return CustomCardWidget(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          TeamSettingSwitchRowWidget(
            title: t('public'),
            subtitle: t('public_sub'),
            value: profile.isPublic,
            onChanged: (value) => update(isPublic: value),
          ),
          TeamSettingSwitchRowWidget(
            title: t('recruiting'),
            subtitle: t('recruiting_sub'),
            value: profile.isRecruiting,
            onChanged: (value) => update(isRecruiting: value),
          ),
          TeamSettingSwitchRowWidget(
            title: t('challenges'),
            subtitle: t('challenges_sub'),
            value: profile.isOpenForChallenges,
            onChanged: (value) => update(isOpen: value),
          ),
        ],
      ),
    );
  }
}
