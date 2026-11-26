import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/venue_booking_detail_model.dart';
import '../models/venue_booking_item_model.dart';

part 'venue_bookings_api_service.g.dart';

@RestApi()
abstract class VenueBookingsApiService {
  factory VenueBookingsApiService(Dio dio, {String? baseUrl}) =
      _VenueBookingsApiService;

  @GET(ApiConstants.venueBookings)
  Future<VenueBookingPageModel> getBookings(
    @Path('venueId') String venueId, {
    @Query('statuses') List<int>? statuses,
    @Query('search') String? search,
    @Query('pitchId') String? pitchId,
    @Query('startDateUtc') String? startDateUtc,
    @Query('endDateUtc') String? endDateUtc,
    @Query('manual') bool? manual,
    @Query('sort') String? sort,
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 20,
  });

  @GET(ApiConstants.venueBooking)
  Future<VenueBookingDetailModel> getBooking(
    @Path('venueId') String venueId,
    @Path('bookingId') String bookingId,
  );

  @POST(ApiConstants.venueBookingConfirmDeposit)
  Future<void> confirmManual(
    @Path('venueId') String venueId,
    @Path('bookingId') String bookingId,
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.venueBookingCancel)
  Future<void> cancel(
    @Path('venueId') String venueId,
    @Path('bookingId') String bookingId,
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.venueBookingNoShow)
  Future<void> markNoShow(
    @Path('venueId') String venueId,
    @Path('bookingId') String bookingId,
    @Body() Map<String, dynamic> body,
  );
}
