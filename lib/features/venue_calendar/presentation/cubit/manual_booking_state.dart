import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/calendar_slot_model.dart';
import '../../data/models/manual_booking_request_body.dart';
import '../../data/models/venue_customer_model.dart';

part 'manual_booking_state.freezed.dart';

@freezed
abstract class ManualBookingState with _$ManualBookingState {
  const factory ManualBookingState({
    required String pitchId,

    /// The Cairo business date.
    required DateTime date,

    /// Minutes from the business date's midnight; past 1440 is that night's
    /// late session (after 12 at night).
    required int startMinutes,
    @Default(60) int durationMinutes,
    @Default(ManualPaymentStatus.full) ManualPaymentStatus payment,

    /// The rules' price for the slot, filled in for the user to change.
    double? suggestedPrice,
    @Default([]) List<CalendarSlotModel> daySlots,
    @Default([]) List<VenueCustomerModel> customers,
    @Default(false) bool customersLoading,
    VenueCustomerModel? selectedCustomer,

    /// Field → localization key of its error.
    @Default({}) Map<String, String> errors,
    @Default(false) bool submitting,
    String? serverError,
    @Default(false) bool done,
  }) = _ManualBookingState;
}
