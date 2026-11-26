import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/venue_overview_repo.dart';
import 'venue_overview_state.dart';

class VenueOverviewCubit extends Cubit<VenueOverviewState>
    with SafeEmitCubitMixin<VenueOverviewState> {
  VenueOverviewCubit({
    required this.venueOverviewRepo,
    this.refreshInterval = const Duration(seconds: 60),
  }) : super(const VenueOverviewState.loading());

  final VenueOverviewRepo venueOverviewRepo;

  /// The web dashboard refreshes every minute; so does the app while open.
  final Duration refreshInterval;
  Timer? _timer;

  Future<void> load(String venueId, {required bool isApproved}) async {
    _timer?.cancel();
    final current = state;
    if (current is VenueOverviewSuccess) {
      emitIfOpen(current.copyWith(refreshing: true));
    } else {
      emitIfOpen(const VenueOverviewState.loading());
    }

    final dashboardFuture = venueOverviewRepo.getDashboard(venueId);
    final approvalFuture = isApproved
        ? null
        : venueOverviewRepo.getApproval(venueId);
    final dashboard = await dashboardFuture;
    final approval = await approvalFuture;
    final adminMessage = approval?.when(
      success: (a) => a.latestAdminMessage,
      failure: (_) => null,
    );

    dashboard.when(
      success: (data) => emitIfOpen(
        VenueOverviewState.success(dashboard: data, adminMessage: adminMessage),
      ),
      failure: (failure) {
        // Keep showing the last numbers when a background refresh fails.
        if (current is VenueOverviewSuccess) {
          emitIfOpen(current.copyWith(refreshing: false));
        } else {
          emitIfOpen(VenueOverviewState.error(failure.message));
        }
      },
    );
    if (refreshInterval > Duration.zero && !isClosed) {
      _timer = Timer(
        refreshInterval,
        () => load(venueId, isApproved: isApproved),
      );
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
