import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/booking_card_widget.dart';
import '../../../../core/widgets/fade_slide_in_widget.dart';

class MyBookingsFallbackWidget extends StatelessWidget {
  const MyBookingsFallbackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      children: [
        FadeSlideInWidget(
          child: BookingCardWidget(
            venueName: 'explore.sample1_name'.tr(context: context),
            pitchName: 'explore.venue.pitch1'.tr(context: context),
            dateTime: 'booking.list.sample1_time'.tr(context: context),
            bookingCode: 'booking.deposit.sample_booking_no'.tr(
              context: context,
            ),
            status: BookingStatus.pendingReview,
            statusText: 'home.in_review'.tr(context: context),
            depositRowText: 'booking.deposit_receipt'.tr(context: context),
            depositAmount: 'booking.list.sample1_deposit'.tr(context: context),
            noteText: 'booking.pending_note'.tr(context: context),
            secondaryActionText: 'booking.details_btn'.tr(context: context),
            onSecondaryAction: () =>
                Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
          ),
        ),
        hSpace(12),
        FadeSlideInWidget(
          index: 1,
          child: BookingCardWidget(
            venueName: 'booking.list.sample2_venue'.tr(context: context),
            pitchName: 'explore.venue.pitch1'.tr(context: context),
            dateTime: 'booking.list.sample2_time'.tr(context: context),
            bookingCode: 'booking.rejected.sample_no'.tr(context: context),
            status: BookingStatus.rejected,
            statusText: 'booking.receipt_rejected'.tr(context: context),
            depositRowText: 'booking.deposit_required_label'.tr(
              context: context,
            ),
            depositAmount: 'booking.amount_60'.tr(context: context),
            noteText: 'booking.list.sample2_note'.tr(context: context),
            primaryActionText: 'booking.reupload_btn'.tr(context: context),
            secondaryActionText: 'booking.details_btn'.tr(context: context),
            onPrimaryAction: () =>
                Navigator.of(context).pushNamed(AppRoutes.uploadProof),
            onSecondaryAction: () =>
                Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
          ),
        ),
      ],
    );
  }
}
