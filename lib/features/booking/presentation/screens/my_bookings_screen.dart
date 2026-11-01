import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_tab_bar_widget.dart';
import '../../../../core/widgets/page_title_header_widget.dart';
import '../widgets/my_bookings_bloc_builder.dart';

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
          const Expanded(child: MyBookingsBlocBuilder()),
        ],
      ),
    );
  }
}
