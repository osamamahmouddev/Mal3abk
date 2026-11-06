import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/player_booking_detail_model.dart';

part 'booking_details_state.freezed.dart';

@freezed
sealed class BookingDetailsState with _$BookingDetailsState {
  const factory BookingDetailsState.initial() = BookingDetailsInitial;
  const factory BookingDetailsState.loading() = BookingDetailsLoading;
  const factory BookingDetailsState.success(PlayerBookingDetailModel booking) =
      BookingDetailsSuccess;
  const factory BookingDetailsState.error(String message) = BookingDetailsError;
}
