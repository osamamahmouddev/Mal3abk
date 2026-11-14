import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/fade_slide_in_widget.dart';
import '../../../../core/widgets/section_header_widget.dart';
import '../../../booking/presentation/cubit/my_bookings_cubit.dart';
import '../../../booking/presentation/cubit/my_bookings_tab.dart';
import '../cubit/home_feed_cubit.dart';
import '../cubit/home_team_activity_cubit.dart';
import '../cubit/recently_viewed_cubit.dart';
import '../widgets/home_hero_search_card_widget.dart';
import '../widgets/home_location_header_widget.dart';
import '../widgets/home_nearby_pitches_bloc_builder.dart';
import '../widgets/home_recently_viewed_bloc_builder.dart';
import '../widgets/home_team_activity_bloc_builder.dart';
import '../widgets/home_upcoming_booking_bloc_builder.dart';
import '../../../main_shell/presentation/widgets/main_shell_scope_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(horizontal: 16.w);

    return Scaffold(
      // White behind the status bar so it continues the white header; the
      // page colour starts below it.
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: ColoredBox(
          color: AppColors.pageBackground,
          child: Column(
            children: [
              const HomeLocationHeaderWidget(),
              Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: () => Future.wait([
                    context.read<HomeFeedCubit>().fetchFeed(),
                    context.read<HomeTeamActivityCubit>().load(),
                    context.read<MyBookingsCubit>().load(
                      MyBookingsTab.upcoming,
                    ),
                    context.read<RecentlyViewedCubit>().load(),
                  ]),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: EdgeInsets.only(
                      top: 14.h,
                      bottom: 16.h + MediaQuery.paddingOf(context).bottom,
                    ),
                    children: [
                      FadeSlideInWidget(
                        child: Padding(
                          padding: padding,
                          child: const HomeHeroSearchCardWidget(),
                        ),
                      ),
                      hSpace(18),
                      FadeSlideInWidget(
                        index: 1,
                        child: Padding(
                          padding: padding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SectionHeaderWidget(
                                title: 'home.upcoming_booking'.tr(
                                  context: context,
                                ),
                                actionText: 'home.bookings'.tr(
                                  context: context,
                                ),
                                onAction: () => MainShellScopeWidget.switchTab(
                                  context,
                                  MainShellScopeWidget.bookingsTab,
                                ),
                              ),
                              hSpace(12),
                              const HomeUpcomingBookingBlocBuilder(),
                            ],
                          ),
                        ),
                      ),
                      hSpace(18),
                      FadeSlideInWidget(
                        index: 2,
                        child: Padding(
                          padding: padding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SectionHeaderWidget(
                                title: 'home.teams_activity'.tr(
                                  context: context,
                                ),
                                actionText: 'home.my_teams'.tr(
                                  context: context,
                                ),
                                onAction: () => MainShellScopeWidget.switchTab(
                                  context,
                                  MainShellScopeWidget.teamsTab,
                                ),
                              ),
                              hSpace(12),
                              const HomeTeamActivityBlocBuilder(),
                            ],
                          ),
                        ),
                      ),
                      hSpace(18),
                      FadeSlideInWidget(
                        index: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: padding,
                              child: SectionHeaderWidget(
                                title: 'home.nearby_pitches'.tr(
                                  context: context,
                                ),
                                actionText: 'home.see_all'.tr(context: context),
                                actionColor: AppColors.brandRed,
                                onAction: () => MainShellScopeWidget.switchTab(
                                  context,
                                  MainShellScopeWidget.exploreTab,
                                ),
                              ),
                            ),
                            hSpace(12),
                            const HomeNearbyPitchesBlocBuilder(),
                            const HomeRecentlyViewedBlocBuilder(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
