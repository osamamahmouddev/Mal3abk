import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/widgets/venue_top_bar_widget.dart';
import '../cubit/venue_overview_cubit.dart';
import '../widgets/venue_overview_body_widget.dart';

/// Today at the venue: approval status, numbers, today's bookings, deposits
/// under review, occupancy, upcoming bookings, revenue and recent activity.
class VenueOverviewScreen extends StatelessWidget {
  const VenueOverviewScreen({required this.onOpenTab, super.key});

  /// Opens another bottom tab (calendar, bookings).
  final ValueChanged<int> onOpenTab;

  @override
  Widget build(BuildContext context) {
    final session = context.read<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    return BlocProvider<VenueOverviewCubit>(
      create: (_) =>
          sl<VenueOverviewCubit>()
            ..load(session.venue.id, isApproved: session.venue.isApproved),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: VenueTopBarWidget(
          title: 'venue.overview.title'.tr(context: context),
        ),
        body: VenueOverviewBodyWidget(onOpenTab: onOpenTab),
      ),
    );
  }
}
