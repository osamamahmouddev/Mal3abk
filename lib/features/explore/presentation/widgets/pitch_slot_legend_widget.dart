import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class PitchSlotLegendWidget extends StatelessWidget {
  const PitchSlotLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final labelStyle = AppTextStyles.font12Regular.copyWith(
      color: AppColors.offlineBanner,
    );

    return Row(
      children: [
        Container(
          width: 12.r,
          height: 12.r,
          decoration: BoxDecoration(
            color: AppColors.brandNavy,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        vSpace(6),
        Text(
          'explore.slots.legend_selected'.tr(context: context),
          style: labelStyle,
        ),
        vSpace(16),
        Container(
          width: 14.r,
          height: 14.r,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(3.r),
            border: Border.all(color: AppColors.borderInput),
          ),
        ),
        vSpace(6),
        Text(
          'explore.slots.legend_available'.tr(context: context),
          style: labelStyle,
        ),
        vSpace(16),
        Container(
          width: 12.r,
          height: 12.r,
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        vSpace(6),
        Text('explore.slots.booked'.tr(context: context), style: labelStyle),
      ],
    );
  }
}
