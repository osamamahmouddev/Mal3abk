import '../../../../core/network/api_result.dart';
import '../../data/models/venue_booking_detail_model.dart';
import '../../data/models/venue_booking_item_model.dart';
import '../../data/models/venue_bookings_query.dart';

abstract class VenueBookingsRepo {
  Future<ApiResult<VenueBookingPageModel>> getBookings(
    String venueId,
    VenueBookingsQuery query, {
    VenueBookingsTab? tab,
    int page = 1,
    int pageSize = 20,
  });

  Future<ApiResult<VenueBookingDetailModel>> getBooking(
    String venueId,
    String bookingId,
  );

  /// Confirms a manual booking that was only held (no platform review).
  Future<ApiResult<void>> confirmManual(String venueId, String bookingId);

  Future<ApiResult<void>> cancel(
    String venueId,
    String bookingId,
    String reason,
  );

  Future<ApiResult<void>> markNoShow(
    String venueId,
    String bookingId,
    String reason,
  );
}
