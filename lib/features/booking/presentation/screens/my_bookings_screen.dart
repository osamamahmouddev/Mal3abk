import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/booking_card_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_tab_bar_widget.dart';

class MyBookingsScreen extends HookWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(1); // Default to "معلّقة" as seen in Figma 10:128
    final tabs = [
      'booking.upcoming_tab'.tr(context: context),
      'booking.pending_tab'.tr(context: context),
      'booking.past_tab'.tr(context: context),
      'booking.cancelled_tab'.tr(context: context),
    ];

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.my_bookings_title'.tr(context: context),
        showBackButton: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: CustomTabBarWidget(
            tabs: tabs,
            selectedIndex: selectedTab.value,
            badgeCounts: const {0: 1, 1: 2},
            onTabSelected: (index) => selectedTab.value = index,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          children: [
            BookingCardWidget(
              venueName: 'ملعب النجوم',
              pitchName: 'ملعب ١',
              dateTime: 'السبت ٢٦ يوليو · ٨:٠٠ م – ٩:٠٠ م',
              bookingCode: 'KH-2607-0142',
              status: BookingStatus.pendingReview,
              statusText: 'booking.pending_review'.tr(context: context),
              depositRowText: 'booking.deposit_receipt'.tr(context: context),
              depositAmount: '٥٠ ج.م · مرفوع ٧:٠٩ م',
              noteText: 'booking.pending_note'.tr(context: context),
              secondaryActionText: 'booking.details_btn'.tr(context: context),
              onSecondaryAction: () => Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
            ),
            BookingCardWidget(
              venueName: 'ملعب المدينة',
              pitchName: 'ملعب ١',
              dateTime: 'الإثنين ٢٨ يوليو · ١٠:٠٠ م – ١١:٠٠ م',
              bookingCode: 'KH-2807-0151',
              status: BookingStatus.rejected,
              statusText: 'booking.receipt_rejected'.tr(context: context),
              depositRowText: 'booking.deposit_required_label'.tr(context: context),
              depositAmount: '٦٠ ج.م',
              noteText: 'booking.rejected_note'.tr(context: context),
              primaryActionText: 'booking.reupload_btn'.tr(context: context),
              secondaryActionText: 'booking.details_btn'.tr(context: context),
              onPrimaryAction: () => Navigator.of(context).pushNamed(AppRoutes.proofRejected),
              onSecondaryAction: () => Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.proofRejected),
            ),
          ],
        ),
      ),
    );
  }
}
