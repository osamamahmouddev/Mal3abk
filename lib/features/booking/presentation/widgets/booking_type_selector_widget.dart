import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class BookingTypeSelectorWidget extends StatelessWidget {
  const BookingTypeSelectorWidget({
    required this.isTeamBooking,
    required this.onChanged,
    super.key,
  });

  final bool isTeamBooking;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => onChanged(false),
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              height: 46.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: !isTeamBooking ? AppColors.brandNavy : AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: !isTeamBooking ? AppColors.brandNavy : AppColors.borderInput,
                ),
              ),
              child: Text(
                'booking.individual_booking'.tr(context: context),
                style: !isTeamBooking
                    ? AppTextStyles.font14Bold.copyWith(color: AppColors.white)
                    : AppTextStyles.font14Medium,
              ),
            ),
          ),
        ),
        vSpace(10),
        Expanded(
          child: InkWell(
            onTap: () => onChanged(true),
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              height: 46.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isTeamBooking ? AppColors.brandNavy : AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: isTeamBooking ? AppColors.brandNavy : AppColors.borderInput,
                ),
              ),
              child: Text(
                'booking.team_booking'.tr(context: context),
                style: isTeamBooking
                    ? AppTextStyles.font14Bold.copyWith(color: AppColors.white)
                    : AppTextStyles.font14Medium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
