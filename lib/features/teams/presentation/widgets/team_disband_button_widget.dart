import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_dialog_widget.dart';
import '../cubit/team_action_cubit.dart';

/// Shown to a captain who is the team's only member: nobody is left to hand
/// captaincy to, so leaving closes the team.
class TeamDisbandButtonWidget extends StatelessWidget {
  const TeamDisbandButtonWidget({required this.teamId, super.key});

  final String teamId;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'teams.manage.$key'.tr(context: context);

    return CustomButton(
      text: t('disband'),
      type: CustomButtonType.outline,
      height: 50.h,
      borderRadius: 12,
      borderColor: AppColors.redBorder,
      textStyle: AppTextStyles.font15SemiBold.copyWith(
        color: AppColors.redText,
      ),
      onTap: () {
        final cubit = context.read<TeamActionCubit>();
        final navigator = Navigator.of(context, rootNavigator: true);
        CustomDialogWidget.show<void>(
          context: context,
          title: t('disband_title'),
          description: t('disband_desc'),
          primaryActionText: t('disband'),
          secondaryActionText: 'common.cancel'.tr(context: context),
          isDestructive: true,
          onPrimaryAction: () {
            navigator.pop();
            cubit.disbandTeam(teamId);
          },
          onSecondaryAction: navigator.pop,
        );
      },
    );
  }
}
