import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/animations/state_switcher_widget.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/custom_skeleton_widget.dart';
import '../../../booking/presentation/cubit/my_bookings_cubit.dart';
import '../../../booking/presentation/cubit/my_bookings_state.dart';
import '../../../booking/presentation/cubit/my_bookings_tab.dart';
import 'home_empty_booking_widget.dart';
import 'home_upcoming_booking_card_widget.dart';

/// The player's next booking, or a prompt to book one.
class HomeUpcomingBookingBlocBuilder extends StatelessWidget {
  const HomeUpcomingBookingBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBookingsCubit, MyBookingsState>(
      builder: (context, state) => StateSwitcherWidget(
        stateKey: state.runtimeType,
        child: switch (state) {
          MyBookingsSuccess(:final items) when items.isNotEmpty =>
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
          MyBookingsSuccess() ||
          MyBookingsError() => const HomeEmptyBookingWidget(),
          _ => const CustomSkeletonWidget(height: 80),
        },
      ),
    );
  }
}
