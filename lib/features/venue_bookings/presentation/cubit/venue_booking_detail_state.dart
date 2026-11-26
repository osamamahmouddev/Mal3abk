import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/venue_booking_detail_model.dart';

part 'venue_booking_detail_state.freezed.dart';

enum VenueBookingAction { confirm, cancel, noShow }

@freezed
sealed class VenueBookingDetailState with _$VenueBookingDetailState {
  const factory VenueBookingDetailState.loading() = VenueBookingDetailLoading;

  /// [busy] is the action being sent; [done] the one that just succeeded
  /// (the screen shows its message once); [actionError] a failed one.
  const factory VenueBookingDetailState.success({
    required VenueBookingDetailModel booking,
    VenueBookingAction? busy,
    VenueBookingAction? done,
    String? actionError,
  }) = VenueBookingDetailSuccess;
  const factory VenueBookingDetailState.error(String message) =
      VenueBookingDetailError;
}
