import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_dialog_widget.dart';
import '../../data/models/team_member_model.dart';
import '../cubit/team_action_cubit.dart';

class TeamMemberOptionsSheetWidget extends StatelessWidget {
  const TeamMemberOptionsSheetWidget({
    required this.teamId,
    required this.member,
    super.key,
  });

  final String teamId;
  final TeamMemberModel member;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeamActionCubit>();
    final name = member.playerName ?? '';
    String t(String key) =>
        'teams.manage.$key'.tr(context: context, args: [name]);

    void confirm(String title, String description, VoidCallback action) {
      final navigator = Navigator.of(context);
      navigator.pop();
      CustomDialogWidget.show<void>(
        context: navigator.context,
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
            CustomButton(
              text: t('make_captain'),
              type: CustomButtonType.outline,
              height: 50.h,
              borderRadius: 12,
              textStyle: AppTextStyles.font15SemiBold.copyWith(
                color: AppColors.brandNavy,
              ),
              onTap: () => confirm(
                t('make_captain'),
                t('make_captain_desc'),
                () => cubit.transferCaptaincy(teamId, member.playerId),
              ),
            ),
            hSpace(10),
            CustomButton(
              text: t('remove'),
              type: CustomButtonType.outline,
              height: 50.h,
              borderRadius: 12,
              borderColor: AppColors.redBorder,
              textStyle: AppTextStyles.font15SemiBold.copyWith(
                color: AppColors.redText,
              ),
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
