import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/plain_note_box_widget.dart';
import '../../domain/use_cases/join_team_by_code_use_case.dart';
import '../cubit/team_invite_preview_cubit.dart';
import '../widgets/join_team_bloc_listener.dart';
import '../widgets/join_team_submit_bloc_builder.dart';
import '../widgets/team_invite_preview_bloc_builder.dart';

class JoinTeamByCodeScreen extends HookWidget {
  const JoinTeamByCodeScreen({this.initialCode, super.key});

  final String? initialCode;

  @override
  Widget build(BuildContext context) {
    final codeController = useTextEditingController(text: initialCode);
    // Shows the team as soon as the code is complete, from a link or typed.
    useEffect(() {
      final preview = context.read<TeamInvitePreviewCubit>();
      void onChanged() => preview.codeChanged(codeController.text);
      onChanged();
      codeController.addListener(onChanged);
      return () => codeController.removeListener(onChanged);
    }, [codeController]);

    return JoinTeamBlocListener(
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'teams.join.title'.tr(context: context),
        ),
        bottomNavigationBar: BottomActionBarWidget(
          child: JoinTeamSubmitBlocBuilder(controller: codeController),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          children: [
            Text(
              'teams.join.code_label'.tr(context: context),
              style: AppTextStyles.font15Bold,
            ),
            hSpace(10),
            Text(
              'teams.join.code_desc'.tr(context: context),
              style: AppTextStyles.font13Regular,
            ),
            hSpace(14),
            CustomTextFormField(
              controller: codeController,
              hintText: 'ABC234',
              autofocus: initialCode == null,
              textAlign: TextAlign.center,
              borderColor: AppColors.successGreen,
              focusedBorderColor: AppColors.successGreen,
              style: AppTextStyles.font22Bold,
              hintStyle: AppTextStyles.font22Bold.copyWith(
                color: AppColors.textDisabled,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(
                  JoinTeamByCodeUseCase.codeLength,
                ),
                FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')),
              ],
            ),
            const TeamInvitePreviewBlocBuilder(),
            hSpace(24),
            PlainNoteBoxWidget(
              text: 'teams.join.privacy_note'.tr(context: context),
            ),
          ],
        ),
      ),
    );
  }
}
