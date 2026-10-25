import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class HomeUpcomingBookingCardWidget extends StatelessWidget {
  const HomeUpcomingBookingCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
      padding: EdgeInsets.all(12.r),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: SvgPicture.asset(
              AppAssets.pitchThumbSquare,
              width: 56.r,
              height: 56.r,
            ),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'home.sample_pitch_name'.tr(context: context),
                  style: AppTextStyles.font15Bold,
                ),
                hSpace(4),
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
            borderRadius: 13,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
          ),
        ],
      ),
    );
  }
}
