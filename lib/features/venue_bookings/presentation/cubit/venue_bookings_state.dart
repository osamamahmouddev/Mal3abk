import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/venue_booking_item_model.dart';
import '../../data/models/venue_bookings_query.dart';

part 'venue_bookings_state.freezed.dart';

@freezed
sealed class VenueBookingsState with _$VenueBookingsState {
  const factory VenueBookingsState.loading({
    required VenueBookingsQuery query,
  }) = VenueBookingsLoading;

  /// [counts] holds each tab's total for the badges (missing while loading).
  const factory VenueBookingsState.success({
    required VenueBookingsQuery query,
    required List<VenueBookingItemModel> items,
    required int totalCount,
    required int page,
    @Default({}) Map<VenueBookingsTab, int> counts,
    @Default(false) bool isLoadingMore,
    String? actionBookingId,
  }) = VenueBookingsSuccess;
  const factory VenueBookingsState.error({
    required VenueBookingsQuery query,
    required String message,
  }) = VenueBookingsError;
}
