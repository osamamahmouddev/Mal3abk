import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class ProfileVenueOwnerCardWidget extends StatelessWidget {
  const ProfileVenueOwnerCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      backgroundColor: AppColors.goldLight,
      borderColor: AppColors.goldBorder,
      child: Row(
        children: [
          Icon(Icons.stadium_outlined, size: 28.sp, color: AppColors.goldDark),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'profile.venue_owner_title'.tr(context: context),
                  style: AppTextStyles.font14Bold.copyWith(
                    color: AppColors.goldDark,
                  ),
                ),
                Text(
                  'profile.venue_owner_sub'.tr(context: context),
                  style: AppTextStyles.font11Regular,
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14.sp,
            color: AppColors.goldDark,
          ),
        ],
      ),
    );
  }
}
