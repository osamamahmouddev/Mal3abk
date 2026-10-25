import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class ProfileSetupPositionSelectorWidget extends StatelessWidget {
  const ProfileSetupPositionSelectorWidget({
    required this.selectedPosition,
    required this.onSelect,
    super.key,
  });

  final String selectedPosition;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final positions = [
      {'key': 'pos_gk', 'label': 'onboarding.profile_setup.pos_gk'.tr(context: context)},
      {'key': 'pos_def', 'label': 'onboarding.profile_setup.pos_def'.tr(context: context)},
      {'key': 'pos_mid', 'label': 'onboarding.profile_setup.pos_mid'.tr(context: context)},
      {'key': 'pos_fwd', 'label': 'onboarding.profile_setup.pos_fwd'.tr(context: context)},
    ];

    return Row(
      children: positions.map((pos) {
        final isSelected = selectedPosition == pos['key'];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: InkWell(
              onTap: () => onSelect(pos['key']!),
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                height: 44.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.brandNavy : AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected ? AppColors.brandNavy : AppColors.borderInput,
                    width: 1.2,
                  ),
                ),
                child: Text(
                  pos['label']!,
                  style: isSelected
                      ? AppTextStyles.font14Bold.copyWith(color: AppColors.white)
                      : AppTextStyles.font14Medium.copyWith(color: AppColors.textPrimary),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
