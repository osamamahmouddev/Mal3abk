import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/timeline_card_widget.dart';
import '../../data/models/booking_status.dart';
import '../../data/models/player_booking_detail_model.dart';
import 'booking_status_style.dart';

class BookingPassTimelineWidget extends StatelessWidget {
  const BookingPassTimelineWidget({required this.booking, super.key});

  final PlayerBookingDetailModel booking;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    return TimelineCardWidget(
      title: 'booking.details.log'.tr(context: context),
      compact: true,
      entries: [
        for (final entry in booking.statusHistory)
          (
            [
              BookingStatusStyle.labelKey(entry.status).tr(context: context),
              ?entry.reason,
            ].join(' — '),
            CairoTime.dayAndTime(DateTime.parse(entry.changedAtUtc), lang),
            entry.status == BookingStatus.confirmed
                ? AppColors.successGreen
                : entry.status.isClosed
                ? AppColors.redText
                : AppColors.brandNavy,
            null,
          ),
      ],
    );
  }
}
