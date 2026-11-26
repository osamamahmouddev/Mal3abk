import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_bottom_nav_bar_widget.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../auth/presentation/cubit/logout_cubit.dart';
import '../../../settings/presentation/widgets/logout_bloc_listener.dart';
import '../../../venue_bookings/presentation/screens/venue_bookings_screen.dart';
import '../../../venue_calendar/presentation/screens/venue_calendar_screen.dart';
import '../../../venue_overview/presentation/screens/venue_overview_screen.dart';
import '../cubit/venue_session_cubit.dart';
import '../cubit/venue_session_state.dart';
import '../widgets/venue_no_venue_widget.dart';
import 'venue_more_screen.dart';

/// The venue owner/staff app: overview, calendar, bookings and the rest of
/// the dashboard sections, for the venue picked in the top bar.
class VenueShellScreen extends HookWidget {
  const VenueShellScreen({super.key});

  static const int overviewTab = 0;
  static const int calendarTab = 1;
  static const int bookingsTab = 2;

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(overviewTab);
    final visited = useRef(<int>{overviewTab});

    void switchTab(int index) {
      visited.value.add(index);
      currentIndex.value = index;
    }

    return LogoutBlocListener(
      child: BlocBuilder<VenueSessionCubit, VenueSessionState>(
        buildWhen: (a, b) =>
            a.runtimeType != b.runtimeType ||
            (a is VenueSessionReady &&
                b is VenueSessionReady &&
                a.venue.id != b.venue.id),
        builder: (context, state) => switch (state) {
          VenueSessionLoading() => const Scaffold(
            backgroundColor: AppColors.pageBackground,
            body: Center(child: CircularProgressIndicator()),
          ),
          VenueSessionError(:final message) => Scaffold(
            backgroundColor: AppColors.pageBackground,
            body: SafeArea(
              child: CustomStateWidget(
                title: 'venue.shell.load_error_title'.tr(context: context),
                description: message.tr(context: context),
                actionText: 'common.retry'.tr(context: context),
                onActionTap: () => context.read<VenueSessionCubit>().load(),
                footer: TextButton(
                  onPressed: () => context.read<LogoutCubit>().logout(),
                  child: Text('auth.logout'.tr(context: context)),
                ),
              ),
            ),
          ),
          VenueSessionNoVenue() => const VenueNoVenueWidget(),
          VenueSessionReady(:final venue) => PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) {
              if (didPop) return;
              if (currentIndex.value != overviewTab) {
                currentIndex.value = overviewTab;
              } else {
                SystemNavigator.pop();
              }
            },
            child: Scaffold(
              backgroundColor: AppColors.pageBackground,
              extendBody: true,
              bottomNavigationBar: CustomBottomNavBarWidget(
                currentIndex: currentIndex.value,
                onTap: switchTab,
                items: [
                  CustomBottomNavBarItem(
                    title: 'venue.nav.overview'.tr(context: context),
                    iconAsset: AppAssets.icNavHome,
                  ),
                  CustomBottomNavBarItem(
                    title: 'venue.nav.calendar'.tr(context: context),
                    iconAsset: AppAssets.icNavCalendar,
                  ),
                  CustomBottomNavBarItem(
                    title: 'venue.nav.bookings'.tr(context: context),
                    iconAsset: AppAssets.icNavBookings,
                  ),
                  CustomBottomNavBarItem(
                    title: 'venue.nav.more'.tr(context: context),
                    iconAsset: AppAssets.icNavMenu,
                  ),
                ],
              ),
              // Keyed by venue so switching venue reloads every tab.
              body: IndexedStack(
                key: ValueKey(venue.id),
                index: currentIndex.value,
                children: [
                  VenueOverviewScreen(onOpenTab: switchTab),
                  if (visited.value.contains(calendarTab))
                    const VenueCalendarScreen()
                  else
                    const SizedBox.shrink(),
                  if (visited.value.contains(bookingsTab))
                    const VenueBookingsScreen()
                  else
                    const SizedBox.shrink(),
                  VenueMoreScreen(onOpenTab: switchTab),
                ],
              ),
            ),
          ),
        },
      ),
    );
  }
}
