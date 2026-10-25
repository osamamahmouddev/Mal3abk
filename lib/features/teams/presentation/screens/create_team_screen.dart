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
import '../../../../core/widgets/plain_note_box_widget.dart';
import '../widgets/create_team_logo_picker_widget.dart';
import '../widgets/create_team_preferences_widget.dart';

class CreateTeamScreen extends HookWidget {
  const CreateTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final bioController = useTextEditingController();

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'teams.create.title'.tr(context: context),
        isClose: true,
      ),
      bottomNavigationBar: BottomActionBarWidget(
        child: CustomButton(
          text: 'teams.create.submit'.tr(context: context),
          height: 52.h,
          borderRadius: 16,
          textStyle: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 18.h),
        children: [
          CreateTeamLogoPickerWidget(initials: 'teams.sample.nogoum_i'.tr(context: context)),
          hSpace(14),
          Text('${'teams.create.name'.tr(context: context)} *', style: AppTextStyles.font14SemiBold),
          hSpace(12),
          CustomTextFormField(
            controller: nameController,
            hintText: 'teams.create.name_hint'.tr(context: context),
            style: AppTextStyles.font16Regular,
          ),
          hSpace(4),
          Text(
            'teams.create.name_available'.tr(context: context),
            style: AppTextStyles.font12SemiBold.copyWith(color: AppColors.successGreen),
          ),
          hSpace(14),
          Text(
            '${'teams.create.bio'.tr(context: context)} ${'onboarding.profile_setup.optional'.tr(context: context)}',
            style: AppTextStyles.font14SemiBold,
          ),
          hSpace(12),
          CustomTextFormField(
            controller: bioController,
            hintText: 'teams.create.bio_hint'.tr(context: context),
            minLines: 2,
            maxLines: 2,
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
          ),
          hSpace(14),
          const CreateTeamPreferencesWidget(),
          hSpace(18),
          PlainNoteBoxWidget(text: 'teams.create.captain_note'.tr(context: context)),
        ],
      ),
    );
  }
}
