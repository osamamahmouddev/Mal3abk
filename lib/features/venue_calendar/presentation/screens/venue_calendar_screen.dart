import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../venue_shell/data/models/my_permissions_model.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/widgets/venue_top_bar_widget.dart';
import '../cubit/venue_calendar_cubit.dart';
import '../cubit/venue_calendar_state.dart';
import '../widgets/venue_calendar_body_widget.dart';

/// Day, week and month calendar of bookings and blocked periods, with manual
/// booking, blocking and picking many hours at once.
class VenueCalendarScreen extends StatelessWidget {
  const VenueCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.read<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    final canBook = session.can(VenuePermissions.bookingsApprove);
    return BlocProvider<VenueCalendarCubit>(
      create: (_) => sl<VenueCalendarCubit>()
        ..start(
          session.venue.id,
          firstPitchId: session.venue.activePitches.firstOrNull?.id,
        ),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: VenueTopBarWidget(
            title: 'venue.calendar.title'.tr(context: context),
            actions: [
              if (canBook)
                BlocBuilder<VenueCalendarCubit, VenueCalendarState>(
                  buildWhen: (a, b) =>
                      a.picking != b.picking || a.view != b.view,
                  builder: (context, state) =>
                      state.view == VenueCalendarView.month
                      ? const SizedBox.shrink()
                      : IconButton(
                          tooltip:
                              (state.picking
                                      ? 'venue.calendar.pick_done'
                                      : 'venue.calendar.pick_many')
                                  .tr(context: context),
                          isSelected: state.picking,
                          icon: const Icon(Icons.checklist_rounded),
                          selectedIcon: const Icon(
                            Icons.playlist_add_check_circle_rounded,
                            color: AppColors.accentGold,
                          ),
                          onPressed: () => context
                              .read<VenueCalendarCubit>()
                              .togglePicking(),
                        ),
                ),
            ],
          ),
          body: const VenueCalendarBodyWidget(),
        ),
      ),
    );
  }
}
