import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/cancel_preview_model.dart';

part 'cancel_booking_state.freezed.dart';

@freezed
sealed class CancelBookingState with _$CancelBookingState {
  const factory CancelBookingState.loading() = CancelBookingLoading;

  /// [failure] is set once when a cancel attempt failed.
  const factory CancelBookingState.ready(
    CancelPreviewModel preview, {
    @Default(false) bool submitting,
    String? failure,
  }) = CancelBookingReady;
  const factory CancelBookingState.cancelled() = CancelBookingCancelled;
  const factory CancelBookingState.error(String message) = CancelBookingError;
}
