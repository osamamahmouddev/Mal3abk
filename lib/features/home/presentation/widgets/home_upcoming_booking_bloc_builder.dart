import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/animations/state_switcher_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/section_header_widget.dart';
import '../../../booking/presentation/cubit/my_bookings_cubit.dart';
import '../../../booking/presentation/cubit/my_bookings_state.dart';
import '../../../booking/presentation/cubit/my_bookings_tab.dart';
import '../../../main_shell/presentation/widgets/main_shell_scope_widget.dart';
import 'home_upcoming_booking_card_widget.dart';
import 'home_upcoming_booking_skeleton_widget.dart';

/// The upcoming-booking section: hidden entirely once the player has no
/// booking ahead, so the home feed doesn't dedicate space to an empty state
/// for something the player hasn't done yet.
class HomeUpcomingBookingBlocBuilder extends StatelessWidget {
  const HomeUpcomingBookingBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBookingsCubit, MyBookingsState>(
      builder: (context, state) => StateSwitcherWidget(
        stateKey: state.runtimeType,
        child: switch (state) {
          MyBookingsSuccess(:final items) when items.isNotEmpty =>
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeaderWidget(
                  title: 'home.upcoming_booking'.tr(context: context),
                  actionText: 'home.bookings'.tr(context: context),
                  onAction: () => MainShellScopeWidget.switchTab(
                    context,
                    MainShellScopeWidget.bookingsTab,
                  ),
                ),
                hSpace(12),
                HomeUpcomingBookingCardWidget(
                  booking: items.reduce(
                    (a, b) => a.startAt.isBefore(b.startAt) ? a : b,
                  ),
                  onTap: () async {
                    final cubit = context.read<MyBookingsCubit>();
                    final next = items.reduce(
                      (a, b) => a.startAt.isBefore(b.startAt) ? a : b,
                    );
                    await Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.bookingDetails, arguments: next.id);
                    await cubit.load(MyBookingsTab.upcoming);
                  },
                ),
              ],
            ),
          MyBookingsSuccess() || MyBookingsError() => const SizedBox.shrink(),
          _ => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionHeaderWidget(
                title: 'home.upcoming_booking'.tr(context: context),
                actionText: 'home.bookings'.tr(context: context),
                onAction: () => MainShellScopeWidget.switchTab(
                  context,
                  MainShellScopeWidget.bookingsTab,
                ),
              ),
              hSpace(12),
              const HomeUpcomingBookingSkeletonWidget(),
            ],
          ),
        },
      ),
    );
  }
}
