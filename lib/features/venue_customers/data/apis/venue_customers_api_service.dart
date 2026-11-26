import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../../../venue_calendar/data/models/venue_customer_model.dart';
import '../models/venue_customer_detail_model.dart';

part 'venue_customers_api_service.g.dart';

@RestApi()
abstract class VenueCustomersApiService {
  factory VenueCustomersApiService(Dio dio, {String? baseUrl}) =
      _VenueCustomersApiService;

  @GET(ApiConstants.venueCustomers)
  Future<VenueCustomerPageModel> getCustomers(
    @Path('venueId') String venueId, {
    @Query('search') String? search,
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 25,
  });

  @GET(ApiConstants.venueCustomer)
  Future<VenueCustomerDetailModel> getCustomer(
    @Path('venueId') String venueId,
    @Path('customerKey') String customerKey,
  );

  @POST(ApiConstants.venueCustomerNotes)
  Future<void> addNote(
    @Path('venueId') String venueId,
    @Path('customerKey') String customerKey,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiConstants.venueCustomerNote)
  Future<void> deleteNote(
    @Path('venueId') String venueId,
    @Path('customerKey') String customerKey,
    @Path('noteId') String noteId,
  );
}
