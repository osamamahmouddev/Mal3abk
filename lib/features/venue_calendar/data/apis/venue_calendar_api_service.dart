import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/calendar_slot_model.dart';
import '../models/manual_booking_request_body.dart';
import '../models/operating_schedule_model.dart';
import '../models/venue_customer_model.dart';

part 'venue_calendar_api_service.g.dart';

@RestApi()
abstract class VenueCalendarApiService {
  factory VenueCalendarApiService(Dio dio, {String? baseUrl}) =
      _VenueCalendarApiService;

  @GET(ApiConstants.venueCalendar)
  Future<List<CalendarSlotModel>> getCalendar(
    @Path('venueId') String venueId, {
    @Query('rangeStartUtc') required String rangeStartUtc,
    @Query('rangeEndUtc') required String rangeEndUtc,
    @Query('pitchId') String? pitchId,
  });

  @GET(ApiConstants.venueSchedules)
  Future<List<OperatingScheduleModel>> getSchedules(
    @Path('venueId') String venueId,
  );

  @POST(ApiConstants.venueBlockedSlots)
  Future<void> blockSlot(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiConstants.venueBlockedSlot)
  Future<void> unblockSlot(
    @Path('venueId') String venueId,
    @Path('slotId') String slotId,
  );

  @POST(ApiConstants.venueManualBooking)
  Future<void> createManualBooking(
    @Path('venueId') String venueId,
    @Body() ManualBookingRequestBody body,
  );

  @POST(ApiConstants.venueManualBookingBulk)
  Future<dynamic> bulkBook(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.venueManualBookingBulkRelease)
  Future<dynamic> bulkRelease(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiConstants.venueCustomers)
  Future<VenueCustomerPageModel> getCustomers(
    @Path('venueId') String venueId, {
    @Query('search') String? search,
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 20,
  });

  @POST(ApiConstants.venuePricePreview)
  Future<dynamic> previewPrice(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.venueBookingConfirmDeposit)
  Future<void> confirmManual(
    @Path('venueId') String venueId,
    @Path('bookingId') String bookingId,
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.venueBookingCancel)
  Future<void> cancelBooking(
    @Path('venueId') String venueId,
    @Path('bookingId') String bookingId,
    @Body() Map<String, dynamic> body,
  );
}
