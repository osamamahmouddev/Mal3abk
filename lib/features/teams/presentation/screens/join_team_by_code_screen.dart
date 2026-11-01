import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../widgets/join_team_preview_card_widget.dart';

class JoinTeamByCodeScreen extends HookWidget {
  const JoinTeamByCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final codeController = useTextEditingController();

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'teams.join.title'.tr(context: context),
      ),
      bottomNavigationBar: BottomActionBarWidget(
        child: CustomButton(
          text: 'teams.join.submit'.tr(
            context: context,
            args: ['teams.profile.mine_name'.tr(context: context)],
          ),
          height: 52.h,
          borderRadius: 16,
          textStyle: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
          onTap: () => Navigator.of(context).pop(),
        ),
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
            hintText: 'teams.invite.sample_code'.tr(context: context),
            textAlign: TextAlign.center,
            borderColor: AppColors.successGreen,
            focusedBorderColor: AppColors.successGreen,
            style: AppTextStyles.font22Bold,
            hintStyle: AppTextStyles.font22Bold.copyWith(
              color: AppColors.textDisabled,
            ),
          ),
          hSpace(62),
          const JoinTeamPreviewCardWidget(),
        ],
      ),
    );
  }
}
