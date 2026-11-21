import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_tab_bar_widget.dart';
import '../../../../core/widgets/page_title_header_widget.dart';
import '../cubit/my_bookings_cubit.dart';
import '../cubit/my_bookings_tab.dart';
import '../widgets/my_bookings_bloc_builder.dart';

class MyBookingsScreen extends HookWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = useState(MyBookingsTab.upcoming);
    final pageController = usePageController();

    void goToTab(MyBookingsTab tab, {required bool animate}) {
      selected.value = tab;
      context.read<MyBookingsCubit>().load(tab);
      if (animate) {
        pageController.animateToPage(
          tab.index,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
        );
      }
    }

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
              selectedIndex: selected.value.index,
              indicatorColor: AppColors.brandNavy,
              showTopBorder: false,
              onTabSelected: (index) {
                HapticFeedback.selectionClick();
                goToTab(MyBookingsTab.values[index], animate: true);
              },
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                HapticFeedback.selectionClick();
                goToTab(MyBookingsTab.values[index], animate: false);
              },
              children: const [
                MyBookingsBlocBuilder(),
                MyBookingsBlocBuilder(),
                MyBookingsBlocBuilder(),
                MyBookingsBlocBuilder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
