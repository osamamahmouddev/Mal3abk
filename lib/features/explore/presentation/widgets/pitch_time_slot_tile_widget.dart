import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class PitchTimeSlotTileWidget extends StatelessWidget {
  const PitchTimeSlotTileWidget({
    required this.time,
    required this.isBooked,
    required this.isSelected,
    required this.onTap,
    super.key,
    this.isNextDay = false,
  });

  final String time;
  final bool isBooked;
  final bool isSelected;
  final bool isNextDay;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12.r);
    final background = isBooked
        ? AppColors.lightSurface
        : (isSelected ? AppColors.brandNavy : AppColors.white);
    final timeColor = isBooked
        ? AppColors.textDisabled
        : (isSelected ? AppColors.white : AppColors.textPrimary);

    return Material(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: isBooked || isSelected
            ? BorderSide.none
            : const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: isBooked ? null : onTap,
        borderRadius: radius,
        child: Container(
          height: 58.h,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                time,
                style: AppTextStyles.font15Bold.copyWith(
                  color: timeColor,
                  decoration: isBooked ? TextDecoration.lineThrough : null,
                  decorationColor: AppColors.textDisabled,
                ),
              ),
              if (isBooked)
                Text(
                  'explore.slots.booked'.tr(context: context),
                  style: AppTextStyles.font10Regular.copyWith(
                    color: AppColors.textDisabled,
                  ),
                )
              else if (isNextDay)
                Text(
                  'explore.slots.next_day'.tr(context: context),
                  style: AppTextStyles.font10Bold.copyWith(
                    color: isSelected ? AppColors.white : AppColors.brandRed,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
