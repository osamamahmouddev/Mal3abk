import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class ProfileAvatarPickerWidget extends StatelessWidget {
  const ProfileAvatarPickerWidget({
    required this.initials,
    super.key,
    this.onTap,
  });

  final String initials;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(38.r),
      child: Row(
        children: [
          Container(
            width: 76.r,
            height: 76.r,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.brandNavy,
              shape: BoxShape.circle,
            ),
            child: Text(
              initials,
              style: AppTextStyles.font26Bold.copyWith(color: AppColors.white),
            ),
          ),
          vSpace(14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'onboarding.profile_setup.avatar_title'.tr(context: context),
                style: AppTextStyles.font15Bold,
              ),
              hSpace(4),
              Text(
                'onboarding.profile_setup.avatar_sub'.tr(context: context),
                style: AppTextStyles.font12Regular,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
