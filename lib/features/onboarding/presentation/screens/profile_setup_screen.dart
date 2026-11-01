import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/form_field_label_widget.dart';
import '../../../../core/widgets/primary_cta_button_widget.dart';
import '../widgets/onboarding_step_header_widget.dart';
import '../widgets/profile_avatar_picker_widget.dart';
import '../widgets/profile_setup_area_selector_widget.dart';
import '../widgets/profile_setup_level_selector_widget.dart';
import '../widgets/profile_setup_position_selector_widget.dart';

class ProfileSetupScreen extends HookWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final selectedArea = useState('nasr_city');
    final selectedPositions = useState(<String>{'pos_mid', 'pos_fwd'});
    final selectedLevel = useState('mid');

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      bottomNavigationBar: BottomActionBarWidget(
        child: PrimaryCtaButtonWidget(
          text: 'onboarding.profile_setup.next'.tr(context: context),
          onTap: () =>
              Navigator.of(context).pushNamed(AppRoutes.locationPermission),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OnboardingStepHeaderWidget(
                stepLabel: 'onboarding.profile_setup.step'.tr(context: context),
                completedSteps: 1,
              ),
              vSpace(6),
              Text(
                'onboarding.profile_setup.title'.tr(context: context),
                style: AppTextStyles.font22Bold,
              ),
              vSpace(8),
              Text(
                'onboarding.profile_setup.desc'.tr(context: context),
                style: AppTextStyles.font13Regular,
              ),
              vSpace(38),
              ProfileAvatarPickerWidget(
                initials: 'onboarding.profile_setup.sample_initials'.tr(
                  context: context,
                ),
              ),
              hSpace(14),
              FormFieldLabelWidget(
                label: 'onboarding.profile_setup.name_label'.tr(
                  context: context,
                ),
                isRequired: true,
              ),
              hSpace(12),
              CustomTextFormField(
                controller: nameController,
                hintText: 'onboarding.profile_setup.name_hint'.tr(
                  context: context,
                ),
                style: AppTextStyles.font16Regular,
              ),
              hSpace(14),
              FormFieldLabelWidget(
                label: 'onboarding.profile_setup.area_label'.tr(
                  context: context,
                ),
                isRequired: true,
              ),
              hSpace(14),
              ProfileSetupAreaSelectorWidget(
                selectedArea: selectedArea.value,
                onSelect: (value) => selectedArea.value = value,
              ),
              hSpace(14),
              FormFieldLabelWidget(
                label: 'onboarding.profile_setup.pos_label'.tr(
                  context: context,
                ),
                hint: 'onboarding.profile_setup.pos_hint'.tr(context: context),
              ),
              hSpace(14),
              ProfileSetupPositionSelectorWidget(
                selectedPositions: selectedPositions.value,
                onToggle: (key) {
                  final next = {...selectedPositions.value};
                  if (!next.remove(key)) next.add(key);
                  selectedPositions.value = next;
                },
              ),
              hSpace(14),
              FormFieldLabelWidget(
                label: 'onboarding.profile_setup.level_label'.tr(
                  context: context,
                ),
                hint: 'onboarding.profile_setup.optional'.tr(context: context),
              ),
              hSpace(14),
              ProfileSetupLevelSelectorWidget(
                selectedLevel: selectedLevel.value,
                onSelect: (value) => selectedLevel.value = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
