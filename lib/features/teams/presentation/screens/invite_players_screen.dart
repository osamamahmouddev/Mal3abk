import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/plain_note_box_widget.dart';
import '../widgets/team_invite_bloc_builder.dart';

class InvitePlayersScreen extends StatelessWidget {
  const InvitePlayersScreen({required this.teamId, super.key});

  final String teamId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'teams.invite.title'.tr(context: context),
      ),
      bottomNavigationBar: BottomActionBarWidget(
        child: CustomButton(
          text: 'teams.invite.done'.tr(context: context),
          type: CustomButtonType.secondary,
          height: 52.h,
          borderRadius: 16,
          textStyle: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 17.h, 16.w, 16.h),
        children: [
          TeamInviteBlocBuilder(teamId: teamId),
          hSpace(14),
          PlainNoteBoxWidget(
            text: 'teams.invite.join_note'.tr(context: context),
          ),
        ],
      ),
    );
  }
}
