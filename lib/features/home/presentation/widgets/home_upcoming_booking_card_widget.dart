import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class HomeUpcomingBookingCardWidget extends StatelessWidget {
  const HomeUpcomingBookingCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.h,
            decoration: BoxDecoration(
              color: AppColors.pitchGreen,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Icon(Icons.sports_soccer_rounded, color: AppColors.white, size: 24.sp),
            ),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'home.sample_pitch_name'.tr(context: context),
                  style: AppTextStyles.font14Bold,
                ),
                hSpace(2),
                Text(
                  'home.sample_booking_time'.tr(context: context),
                  style: AppTextStyles.font12Regular,
                ),
              ],
            ),
          ),
          AppBadgeWidget(
            text: 'home.in_review'.tr(context: context),
            type: AppBadgeType.warning,
          ),
        ],
      ),
    );
  }
}
