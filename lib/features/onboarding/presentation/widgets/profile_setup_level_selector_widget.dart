import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class ProfileSetupLevelSelectorWidget extends StatelessWidget {
  const ProfileSetupLevelSelectorWidget({
    required this.selectedLevel,
    required this.onSelect,
    super.key,
  });

  final String selectedLevel;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final levels = [
      {
        'key': 'beg',
        'title': 'onboarding.profile_setup.level_beg_title'.tr(context: context),
        'sub': 'onboarding.profile_setup.level_beg_sub'.tr(context: context),
      },
      {
        'key': 'mid',
        'title': 'onboarding.profile_setup.level_mid_title'.tr(context: context),
        'sub': 'onboarding.profile_setup.level_mid_sub'.tr(context: context),
      },
      {
        'key': 'adv',
        'title': 'onboarding.profile_setup.level_adv_title'.tr(context: context),
        'sub': 'onboarding.profile_setup.level_adv_sub'.tr(context: context),
      },
    ];

    return Row(
      children: levels.map((item) {
        final isSelected = selectedLevel == item['key'];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: InkWell(
              onTap: () => onSelect(item['key']!),
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.brandNavy : AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected ? AppColors.brandNavy : AppColors.borderInput,
                    width: 1.2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item['title']!,
                      style: isSelected
                          ? AppTextStyles.font14Bold.copyWith(color: AppColors.white)
                          : AppTextStyles.font14Medium.copyWith(color: AppColors.textPrimary),
                    ),
                    hSpace(2),
                    Text(
                      item['sub']!,
                      style: AppTextStyles.font11Regular.copyWith(
                        color: isSelected
                            ? AppColors.white.withValues(alpha: 0.8)
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
