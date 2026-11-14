import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_dialog_widget.dart';
import '../cubit/team_invite_cubit.dart';

/// Replaces the invite code after a confirmation, since the old code stops
/// working for everyone who has it.
class TeamInviteNewCodeButtonWidget extends StatelessWidget {
  const TeamInviteNewCodeButtonWidget({required this.teamId, super.key});

  final String teamId;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'teams.invite.new_code'.tr(context: context),
      type: CustomButtonType.outline,
      height: 46.h,
      borderRadius: 12,
      borderColor: AppColors.border,
      textStyle: AppTextStyles.font14SemiBold.copyWith(
        color: AppColors.brandNavy,
      ),
      onTap: () {
        final cubit = context.read<TeamInviteCubit>();
        final navigator = Navigator.of(context, rootNavigator: true);
        CustomDialogWidget.show<void>(
          context: context,
          title: 'teams.invite.new_code_title'.tr(context: context),
          description: 'teams.invite.new_code_desc'.tr(context: context),
          primaryActionText: 'common.confirm'.tr(context: context),
          secondaryActionText: 'common.cancel'.tr(context: context),
          isDestructive: true,
          onPrimaryAction: () {
            navigator.pop();
            cubit.newCode(teamId);
          },
          onSecondaryAction: navigator.pop,
        );
      },
    );
  }
}
