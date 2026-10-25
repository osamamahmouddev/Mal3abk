import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../routes/routes.dart';
import '../styles/app_assets.dart';
import 'custom_bottom_nav_bar_widget.dart';

/// App-wide 5-tab navigation bar rendered once by the main shell.
class MainNavBarWidget extends StatelessWidget {
  const MainNavBarWidget({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  static const List<String> tabRoutes = [
    AppRoutes.home,
    AppRoutes.exploreList,
    AppRoutes.myBookings,
    AppRoutes.myTeams,
    AppRoutes.myProfile,
  ];

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavBarWidget(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        CustomBottomNavBarItem(
          title: 'home.nav_home'.tr(context: context),
          iconAsset: AppAssets.icNavHome,
        ),
        CustomBottomNavBarItem(
          title: 'home.nav_explore'.tr(context: context),
          iconAsset: AppAssets.icNavExplore,
        ),
        CustomBottomNavBarItem(
          title: 'home.nav_bookings'.tr(context: context),
          iconAsset: AppAssets.icNavBookings,
        ),
        CustomBottomNavBarItem(
          title: 'home.nav_teams'.tr(context: context),
          iconAsset: AppAssets.icNavTeams,
        ),
        CustomBottomNavBarItem(
          title: 'home.nav_profile'.tr(context: context),
          iconAsset: AppAssets.icNavProfile,
        ),
      ],
    );
  }
}
