import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_dialog_widget.dart';
import '../../data/models/team_member_model.dart';
import '../cubit/team_action_cubit.dart';
import 'team_member_option_button_widget.dart';

/// What a leader can do to one member. The captain can hand over captaincy,
/// appoint or drop a vice-captain and remove anyone; a vice-captain can only
/// remove plain members (the server enforces the same rules).
class TeamMemberOptionsSheetWidget extends StatelessWidget {
  const TeamMemberOptionsSheetWidget({
    required this.teamId,
    required this.member,
    required this.callerIsCaptain,
    super.key,
  });

  final String teamId;
  final TeamMemberModel member;
  final bool callerIsCaptain;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeamActionCubit>();
    final name = member.playerName ?? '';
    String t(String key) =>
        'teams.manage.$key'.tr(context: context, args: [name]);

    void confirm(String title, String description, VoidCallback action) {
      final sheetNavigator = Navigator.of(context);
      final navigator = Navigator.of(context, rootNavigator: true);
      sheetNavigator.pop();
      CustomDialogWidget.show<void>(
        context: sheetNavigator.context,
        title: title,
        description: description,
        primaryActionText: 'common.confirm'.tr(context: context),
        secondaryActionText: 'common.cancel'.tr(context: context),
        isDestructive: true,
        onPrimaryAction: () {
          navigator.pop();
          action();
        },
        onSecondaryAction: navigator.pop,
      );
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(name, style: AppTextStyles.font16Bold),
            hSpace(14),
            if (callerIsCaptain) ...[
              TeamMemberOptionButtonWidget(
                text: t('make_captain'),
                onTap: () => confirm(
                  t('make_captain'),
                  t('make_captain_desc'),
                  () => cubit.transferCaptaincy(teamId, member.playerId),
                ),
              ),
              hSpace(10),
              if (member.isViceCaptain)
                TeamMemberOptionButtonWidget(
                  text: t('make_member'),
                  onTap: () => confirm(
                    t('make_member'),
                    t('make_member_desc'),
                    () => cubit.makeMember(teamId, member.playerId),
                  ),
                )
              else
                TeamMemberOptionButtonWidget(
                  text: t('make_vice'),
                  onTap: () => confirm(
                    t('make_vice'),
                    t('make_vice_desc'),
                    () => cubit.makeViceCaptain(teamId, member.playerId),
                  ),
                ),
              hSpace(10),
            ],
            TeamMemberOptionButtonWidget(
              text: t('remove'),
              isDestructive: true,
              onTap: () => confirm(
                t('remove'),
                t('remove_desc'),
                () => cubit.removeMember(teamId, member.playerId),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
