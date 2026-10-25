import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_bottom_nav_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/home_hero_search_card_widget.dart';
import '../widgets/home_location_header_widget.dart';
import '../widgets/home_nearby_pitch_card_widget.dart';
import '../widgets/home_team_activity_card_widget.dart';
import '../widgets/home_upcoming_booking_card_widget.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      bottomNavigationBar: CustomBottomNavBarWidget(
        currentIndex: currentIndex.value,
        onTap: (index) {
          currentIndex.value = index;
          if (index == 1) Navigator.of(context).pushNamed(AppRoutes.exploreList);
          if (index == 2) Navigator.of(context).pushNamed(AppRoutes.myBookings);
          if (index == 3) Navigator.of(context).pushNamed(AppRoutes.myTeams);
          if (index == 4) Navigator.of(context).pushNamed(AppRoutes.myProfile);
        },
        items: [
          CustomBottomNavBarItem(
            title: 'home.nav_home'.tr(context: context),
            icon: Icons.home_filled,
          ),
          CustomBottomNavBarItem(
            title: 'home.nav_explore'.tr(context: context),
            icon: Icons.explore_outlined,
            activeIcon: Icons.explore_rounded,
          ),
          CustomBottomNavBarItem(
            title: 'home.nav_bookings'.tr(context: context),
            icon: Icons.calendar_today_outlined,
            activeIcon: Icons.calendar_today_rounded,
          ),
          CustomBottomNavBarItem(
            title: 'home.nav_teams'.tr(context: context),
            icon: Icons.groups_outlined,
            activeIcon: Icons.groups_rounded,
          ),
          CustomBottomNavBarItem(
            title: 'home.nav_profile'.tr(context: context),
            icon: Icons.person_outline_rounded,
            activeIcon: Icons.person_rounded,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const HomeLocationHeaderWidget(),
              hSpace(18),
              const HomeHeroSearchCardWidget(),
              hSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'home.upcoming_booking'.tr(context: context),
                    style: AppTextStyles.font16Bold,
                  ),
                  CustomButton(
                    text: 'home.bookings'.tr(context: context),
                    type: CustomButtonType.ghost,
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.myBookings),
                  ),
                ],
              ),
              const HomeUpcomingBookingCardWidget(),
              hSpace(18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'home.teams_activity'.tr(context: context),
                    style: AppTextStyles.font16Bold,
                  ),
                  CustomButton(
                    text: 'home.nav_teams'.tr(context: context),
                    type: CustomButtonType.ghost,
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.myTeams),
                  ),
                ],
              ),
              const HomeTeamActivityCardWidget(),
              hSpace(18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'home.nearby_pitches'.tr(context: context),
                    style: AppTextStyles.font16Bold,
                  ),
                  CustomButton(
                    text: 'home.on_map'.tr(context: context),
                    type: CustomButtonType.ghost,
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.exploreMap),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HomeNearbyPitchCardWidget(
                      name: 'ملعب النجوم',
                      rating: '٤٫٨',
                      dist: '١٫٢ كم · من ١٥٠ ج.م',
                      slot: 'متاح ٨:٠٠ م',
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.venueProfile),
                    ),
                    vSpace(12),
                    HomeNearbyPitchCardWidget(
                      name: 'أكاديمية الدلتا',
                      rating: '٤٫٦',
                      dist: '٢٫٥ كم · من ٢٠٠ ج.م',
                      slot: 'متاح ٩:٠٠ م',
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.venueProfile),
                    ),
                  ],
                ),
              ),
              hSpace(24),
            ],
          ),
        ),
      ),
    );
  }
}
