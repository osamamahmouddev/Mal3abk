import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/venue_dashboard_model.dart';

part 'venue_overview_state.freezed.dart';

@freezed
sealed class VenueOverviewState with _$VenueOverviewState {
  const factory VenueOverviewState.loading() = VenueOverviewLoading;

  /// [adminMessage] is the platform's last note while the venue is not
  /// approved yet.
  const factory VenueOverviewState.success({
    required VenueDashboardModel dashboard,
    String? adminMessage,
    @Default(false) bool refreshing,
  }) = VenueOverviewSuccess;
  const factory VenueOverviewState.error(String message) = VenueOverviewError;
}
