import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../widgets/profile_avatar_picker_widget.dart';
import '../widgets/profile_setup_level_selector_widget.dart';
import '../widgets/profile_setup_position_selector_widget.dart';

class ProfileSetupScreen extends HookWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final areaController = useTextEditingController();
    final selectedPosition = useState('pos_mid');
    final selectedLevel = useState('mid');

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.pageBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.brandNavy),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'onboarding.profile_setup.step'.tr(context: context),
                    style: AppTextStyles.font13Regular,
                  ),
                ],
              ),
              hSpace(8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.brandRed,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  vSpace(8),
                  Expanded(
                    child: Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.borderInput,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                ],
              ),
              hSpace(20),
              Text(
                'onboarding.profile_setup.title'.tr(context: context),
                style: AppTextStyles.font22Bold,
              ),
              hSpace(6),
              Text(
                'onboarding.profile_setup.desc'.tr(context: context),
                style: AppTextStyles.font13Regular,
              ),
              hSpace(24),
              const ProfileAvatarPickerWidget(initials: 'أس'),
              hSpace(24),
              CustomTextFormField(
                controller: nameController,
                labelText: 'onboarding.profile_setup.name_label'.tr(context: context),
                hintText: 'onboarding.profile_setup.name_hint'.tr(context: context),
              ),
              hSpace(16),
              CustomTextFormField(
                controller: areaController,
                labelText: 'onboarding.profile_setup.area_label'.tr(context: context),
                hintText: 'onboarding.profile_setup.area_hint'.tr(context: context),
              ),
              hSpace(20),
              Text(
                'onboarding.profile_setup.pos_label'.tr(context: context),
                style: AppTextStyles.font14SemiBold,
              ),
              hSpace(10),
              ProfileSetupPositionSelectorWidget(
                selectedPosition: selectedPosition.value,
                onSelect: (val) => selectedPosition.value = val,
              ),
              hSpace(20),
              Text(
                'onboarding.profile_setup.level_label'.tr(context: context),
                style: AppTextStyles.font14SemiBold,
              ),
              hSpace(10),
              ProfileSetupLevelSelectorWidget(
                selectedLevel: selectedLevel.value,
                onSelect: (val) => selectedLevel.value = val,
              ),
              hSpace(36),
              CustomButton(
                text: 'onboarding.profile_setup.next'.tr(context: context),
                type: CustomButtonType.primary,
                height: 52.h,
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.locationPermission),
              ),
              hSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}
