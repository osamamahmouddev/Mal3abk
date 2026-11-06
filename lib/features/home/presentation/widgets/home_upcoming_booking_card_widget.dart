import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../booking/data/models/player_booking_summary_model.dart';
import '../../../booking/presentation/widgets/booking_status_style.dart';

class HomeUpcomingBookingCardWidget extends StatelessWidget {
  const HomeUpcomingBookingCardWidget({
    required this.booking,
    required this.onTap,
    super.key,
  });

  final PlayerBookingSummaryModel booking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      onTap: onTap,
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
                  [?booking.venueName, ?booking.pitchName].join(' · '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font15Bold,
                ),
                hSpace(4),
                Text(
                  CairoTime.dayAndTime(
                    booking.startAt,
                    context.locale.languageCode,
                  ),
                  style: AppTextStyles.font12Regular,
                ),
              ],
            ),
          ),
          AppBadgeWidget(
            text: BookingStatusStyle.labelKey(
              booking.status,
            ).tr(context: context),
            type: BookingStatusStyle.badge(booking.status),
            borderRadius: 13,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
          ),
        ],
      ),
    );
  }
}
