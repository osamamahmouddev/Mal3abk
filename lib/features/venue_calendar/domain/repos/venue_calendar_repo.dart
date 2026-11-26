import '../../../../core/network/api_result.dart';
import '../../data/models/calendar_slot_model.dart';
import '../../data/models/manual_booking_request_body.dart';
import '../../data/models/operating_schedule_model.dart';
import '../../data/models/venue_customer_model.dart';

abstract class VenueCalendarRepo {
  Future<ApiResult<List<CalendarSlotModel>>> getCalendar(
    String venueId, {
    required DateTime fromUtc,
    required DateTime toUtc,
    String? pitchId,
  });

  Future<ApiResult<List<OperatingScheduleModel>>> getSchedules(String venueId);

  Future<ApiResult<void>> blockSlot(
    String venueId, {
    required String pitchId,
    required DateTime startUtc,
    required DateTime endUtc,
    required String reason,
  });

  Future<ApiResult<void>> unblockSlot(String venueId, String slotId);

  Future<ApiResult<void>> createManualBooking(
    String venueId,
    ManualBookingRequestBody body,
  );

  Future<ApiResult<BulkOutcome>> bulkBook(
    String venueId, {
    required List<CalendarHour> hours,
    required ManualPaymentStatus status,
    String? customerName,
    String? customerPhone,
    double? pricePerHour,
  });

  /// Frees manual bookings and blocked periods; returns what was freed.
  Future<ApiResult<BulkOutcome>> release(
    String venueId, {
    required List<String> bookingIds,
    required List<String> blockedSlotIds,
  });

  Future<ApiResult<List<VenueCustomerModel>>> searchCustomers(
    String venueId,
    String search,
  );

  /// The price the venue's rules give this slot, or null when none applies.
  Future<double?> previewPrice(
    String venueId, {
    required String pitchId,
    required DateTime startUtc,
    required DateTime endUtc,
  });

  Future<ApiResult<void>> confirmManual(String venueId, String bookingId);

  Future<ApiResult<void>> cancelBooking(
    String venueId,
    String bookingId,
    String reason,
  );
}
