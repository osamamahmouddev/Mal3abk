import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/form_field_label_widget.dart';
import '../../../profile/data/models/complete_profile_request_body.dart';
import '../../../profile/data/models/my_profile_model.dart';
import '../../../profile/data/models/player_attributes.dart';
import '../../../reference/data/models/governorate_model.dart';
import '../../../reference/presentation/widgets/governorate_area_picker_bloc_builder.dart';
import '../cubit/profile_setup_cubit.dart';
import '../widgets/onboarding_step_header_widget.dart';
import '../widgets/profile_avatar_bloc_builder.dart';
import '../widgets/profile_setup_bloc_listener.dart';
import '../widgets/profile_setup_level_selector_widget.dart';
import '../widgets/profile_setup_position_selector_widget.dart';
import '../widgets/profile_setup_submit_bloc_builder.dart';

/// First-run profile step, also reused to edit the profile later.
class ProfileSetupScreen extends HookWidget {
  const ProfileSetupScreen({super.key, this.profile});

  final MyProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    final isOnboarding = !(profile?.onboardingComplete ?? false);
    final nameController = useTextEditingController(text: profile?.fullName);
    final name = useValueListenable(nameController).text;
    final governorate = useValueNotifier<GovernorateModel?>(null);
    final area = useValueNotifier<String?>(profile?.area);
    final positions = useState<Set<PlayerPosition>>({
      ...?profile?.playerPositions,
    });
    final level = useState<SkillLevel?>(profile?.playerSkillLevel);
    String t(String key) =>
        'onboarding.profile_setup.$key'.tr(context: context);

    void submit() {
      FocusScope.of(context).unfocus();
      context.read<ProfileSetupCubit>().save(
        CompleteProfileRequestBody(
          fullName: nameController.text,
          city: governorate.value?.nameAr ?? '',
          area: area.value ?? '',
          positions: positions.value.toList(growable: false),
          skillLevel: level.value,
          language: context.locale.languageCode,
        ),
        isOnboarding: isOnboarding,
      );
    }

    return ProfileSetupBlocListener(
      isOnboarding: isOnboarding,
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: isOnboarding
            ? null
            : CustomAppBarWidget(title: 'profile.edit'.tr(context: context)),
        bottomNavigationBar: ProfileSetupSubmitBlocBuilder(
          isOnboarding: isOnboarding,
          onSubmit: submit,
        ),
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
            children: [
              if (isOnboarding) ...[
                OnboardingStepHeaderWidget(
                  stepLabel: t('step'),
                  completedSteps: 1,
                ),
                hSpace(6),
                Text(t('title'), style: AppTextStyles.font22Bold),
                hSpace(8),
                Text(t('desc'), style: AppTextStyles.font13Regular),
                hSpace(28),
              ],
              ProfileAvatarBlocBuilder(
                initials: name.trim().isEmpty ? '?' : name.initials,
              ),
              hSpace(18),
              FormFieldLabelWidget(label: t('name_label'), isRequired: true),
              hSpace(12),
              CustomTextFormField(
                controller: nameController,
                hintText: t('name_hint'),
                style: AppTextStyles.font16Regular,
              ),
              hSpace(18),
              GovernorateAreaPickerBlocBuilder(
                label: t('area_label'),
                governorate: governorate,
                area: area,
                initialCity: profile?.city,
              ),
              hSpace(18),
              FormFieldLabelWidget(label: t('pos_label'), hint: t('pos_hint')),
              hSpace(14),
              ProfileSetupPositionSelectorWidget(
                selectedPositions: positions.value,
                onToggle: (position) {
                  final next = {...positions.value};
                  if (!next.remove(position)) next.add(position);
                  positions.value = next;
                },
              ),
              hSpace(18),
              FormFieldLabelWidget(
                label: t('level_label'),
                hint: t('optional'),
              ),
              hSpace(14),
              ProfileSetupLevelSelectorWidget(
                selectedLevel: level.value,
                onSelect: (value) => level.value = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
