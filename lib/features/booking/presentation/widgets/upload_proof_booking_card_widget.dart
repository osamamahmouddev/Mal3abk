import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/venue_thumbnail_widget.dart';
import '../../../../core/widgets/hold_countdown_builder.dart';
import '../../data/models/player_booking_detail_model.dart';

class UploadProofBookingCardWidget extends StatelessWidget {
  const UploadProofBookingCardWidget({required this.booking, super.key});

  final PlayerBookingDetailModel booking;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final hold = booking.holdExpiresAtUtc == null
        ? null
        : CairoTime.parseUtc(booking.holdExpiresAtUtc!);

    return CustomCardWidget(
      borderRadius: 18,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          VenueThumbnailWidget(
            imageUrl: booking.venueCoverPhotoUrl,
            size: 48,
            borderRadius: 10,
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  [?booking.venue?.name, ?booking.pitchName].join(' · '),
                  style: AppTextStyles.font14Bold,
                ),
                hSpace(4),
                Text(
                  CairoTime.dayAndTime(booking.startAt, lang),
                  style: AppTextStyles.font12Regular,
                ),
                hSpace(2),
                Text(
                  'booking.upload.amount_due'.tr(
                    context: context,
                    args: [
                      booking.depositAmount.round().toLocalizedDigits(lang),
                    ],
                  ),
                  style: AppTextStyles.font13SemiBold,
                ),
              ],
            ),
          ),
          if (hold != null)
            HoldCountdownBuilder(
              expiresAtUtc: hold,
              builder: (context, remaining) => AppBadgeWidget(
                text: HoldCountdownBuilder.format(remaining, lang),
                type: AppBadgeType.warning,
                borderRadius: 13,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              ),
            ),
        ],
      ),
    );
  }
}
