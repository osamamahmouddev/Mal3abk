import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class FavoriteTodaySlotsWidget extends StatelessWidget {
  const FavoriteTodaySlotsWidget({required this.slots, super.key});

  final List<String> slots;

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) {
      return Text(
        'explore.no_slots_today'.tr(context: context),
        style: AppTextStyles.font12SemiBold.copyWith(
          color: AppColors.offlineBanner,
        ),
      );
    }

    return Row(
      children: [
        Text(
          'explore.today_label'.tr(context: context),
          style: AppTextStyles.font12Regular,
        ),
        for (final slot in slots) ...[
          vSpace(6),
          Container(
            height: 28.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.successLight,
              borderRadius: BorderRadius.circular(7.r),
            ),
            child: Text(
              slot,
              style: AppTextStyles.font12Bold.copyWith(
                color: AppColors.successGreen,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
