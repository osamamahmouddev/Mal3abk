import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../venue_shell/data/models/my_permissions_model.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/widgets/venue_top_bar_widget.dart';
import '../cubit/venue_bookings_cubit.dart';
import '../cubit/venue_bookings_state.dart';
import '../widgets/venue_bookings_csv.dart';
import '../widgets/venue_bookings_list_widget.dart';

/// Every booking of the venue with tabs, search and filters, like the web
/// reservations page.
class VenueBookingsScreen extends StatelessWidget {
  const VenueBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.read<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    return BlocProvider<VenueBookingsCubit>(
      create: (_) => sl<VenueBookingsCubit>()..start(session.venue.id),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: VenueTopBarWidget(
            title: 'venue.bookings.title'.tr(context: context),
            actions: [
              IconButton(
                tooltip: 'venue.bookings.export'.tr(context: context),
                icon: const Icon(Icons.ios_share_rounded),
                onPressed: () => _export(context, session),
              ),
              if (session.can(VenuePermissions.bookingsApprove))
                IconButton(
                  tooltip: 'venue.overview.manual_booking'.tr(context: context),
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  onPressed: () async {
                    final cubit = context.read<VenueBookingsCubit>();
                    final created = await context.pushNamed<bool>(
                      AppRoutes.venueManualBooking,
                      arguments: session.venue,
                    );
                    if (created == true) await cubit.refresh();
                  },
                ),
            ],
          ),
          body: const VenueBookingsListWidget(),
        ),
      ),
    );
  }

  Future<void> _export(BuildContext context, VenueSessionReady session) async {
    final state = context.read<VenueBookingsCubit>().state;
    if (state is! VenueBookingsSuccess || state.items.isEmpty) {
      AppTopSnackBar.showInfo(
        context,
        'venue.bookings.export_empty'.tr(context: context),
      );
      return;
    }
    await VenueBookingsCsv.share(context, session.venue, state.items);
  }
}
