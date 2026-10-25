import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/booking_card_widget.dart';
import '../../../../core/widgets/custom_tab_bar_widget.dart';
import '../../../../core/widgets/page_title_header_widget.dart';

class MyBookingsScreen extends HookWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(1);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: Column(
        children: [
          PageTitleHeaderWidget(
            title: 'booking.my_bookings_title'.tr(context: context),
            bottom: CustomTabBarWidget(
              tabs: [
                'booking.upcoming_tab'.tr(context: context),
                'booking.pending_tab'.tr(context: context),
                'booking.past_tab'.tr(context: context),
                'booking.cancelled_tab'.tr(context: context),
              ],
              selectedIndex: selectedTab.value,
              badgeCounts: const {0: 1, 1: 2},
              indicatorColor: AppColors.brandNavy,
              showTopBorder: false,
              onTabSelected: (index) => selectedTab.value = index,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
              children: [
                BookingCardWidget(
                  venueName: 'explore.sample1_name'.tr(context: context),
                  pitchName: 'explore.venue.pitch1'.tr(context: context),
                  dateTime: 'booking.list.sample1_time'.tr(context: context),
                  bookingCode: 'booking.deposit.sample_booking_no'.tr(context: context),
                  status: BookingStatus.pendingReview,
                  statusText: 'home.in_review'.tr(context: context),
                  depositRowText: 'booking.deposit_receipt'.tr(context: context),
                  depositAmount: 'booking.list.sample1_deposit'.tr(context: context),
                  noteText: 'booking.pending_note'.tr(context: context),
                  secondaryActionText: 'booking.details_btn'.tr(context: context),
                  onSecondaryAction: () =>
                      Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
                  onTap: () => Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
                ),
                hSpace(12),
                BookingCardWidget(
                  venueName: 'booking.list.sample2_venue'.tr(context: context),
                  pitchName: 'explore.venue.pitch1'.tr(context: context),
                  dateTime: 'booking.list.sample2_time'.tr(context: context),
                  bookingCode: 'booking.rejected.sample_no'.tr(context: context),
                  status: BookingStatus.rejected,
                  statusText: 'booking.receipt_rejected'.tr(context: context),
                  depositRowText: 'booking.deposit_required_label'.tr(context: context),
                  depositAmount: 'booking.amount_60'.tr(context: context),
                  noteText: 'booking.list.sample2_note'.tr(context: context),
                  primaryActionText: 'booking.reupload_btn'.tr(context: context),
                  secondaryActionText: 'booking.details_btn'.tr(context: context),
                  onPrimaryAction: () =>
                      Navigator.of(context).pushNamed(AppRoutes.uploadProof),
                  onSecondaryAction: () =>
                      Navigator.of(context).pushNamed(AppRoutes.proofRejected),
                  onTap: () => Navigator.of(context).pushNamed(AppRoutes.proofRejected),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
