import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/venue_model.dart';

part 'venue_session_state.freezed.dart';

@freezed
sealed class VenueSessionState with _$VenueSessionState {
  const factory VenueSessionState.loading() = VenueSessionLoading;

  /// [venue] is the one open now; [permissions] are the user's at it.
  const factory VenueSessionState.ready({
    required List<VenueModel> venues,
    required VenueModel venue,
    required Set<String> permissions,
    required String accessLevel,
  }) = VenueSessionReady;

  /// Signed in but no venue yet: the owner sets one up first.
  const factory VenueSessionState.noVenue() = VenueSessionNoVenue;
  const factory VenueSessionState.error(String message) = VenueSessionError;
}

extension VenueSessionReadyX on VenueSessionReady {
  bool can(String permission) => permissions.contains(permission);

  bool get isOwner => accessLevel == 'Owner';
}
