import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/section_header_widget.dart';
import '../widgets/home_hero_search_card_widget.dart';
import '../widgets/home_location_header_widget.dart';
import '../widgets/home_nearby_pitches_carousel_widget.dart';
import '../widgets/home_pending_result_card_widget.dart';
import '../widgets/home_team_activity_card_widget.dart';
import '../widgets/home_upcoming_booking_card_widget.dart';
import '../../../main_shell/presentation/widgets/main_shell_scope_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(horizontal: 16.w);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const HomeLocationHeaderWidget(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 14.h, bottom: 16.h),
                children: [
                  Padding(
                    padding: padding,
                    child: const HomeHeroSearchCardWidget(),
                  ),
                  hSpace(18),
                  Padding(
                    padding: padding,
                    child: SectionHeaderWidget(
                      title: 'home.upcoming_booking'.tr(context: context),
                      actionText: 'home.bookings'.tr(context: context),
                      onAction: () => MainShellScopeWidget.switchTab(
                        context,
                        MainShellScopeWidget.bookingsTab,
                      ),
                    ),
                  ),
                  hSpace(12),
                  Padding(
                    padding: padding,
                    child: const HomeUpcomingBookingCardWidget(),
                  ),
                  hSpace(18),
                  Padding(
                    padding: padding,
                    child: SectionHeaderWidget(
                      title: 'home.teams_activity'.tr(context: context),
                      actionText: 'home.my_teams'.tr(context: context),
                      onAction: () => MainShellScopeWidget.switchTab(
                        context,
                        MainShellScopeWidget.teamsTab,
                      ),
                    ),
                  ),
                  hSpace(12),
                  Padding(
                    padding: padding,
                    child: HomeTeamActivityCardWidget(
                      onTap: () => Navigator.of(
                        context,
                      ).pushNamed(AppRoutes.challengeDetails),
                    ),
                  ),
                  hSpace(10),
                  Padding(
                    padding: padding,
                    child: const HomePendingResultCardWidget(),
                  ),
                  hSpace(18),
                  Padding(
                    padding: padding,
                    child: SectionHeaderWidget(
                      title: 'home.nearby_pitches'.tr(context: context),
                      actionText: 'home.on_map'.tr(context: context),
                      actionColor: AppColors.brandRed,
                      onAction: () =>
                          Navigator.of(context).pushNamed(AppRoutes.exploreMap),
                    ),
                  ),
                  hSpace(12),
                  const HomeNearbyPitchesCarouselWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
