import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/booking_quote_request_body.dart';
import '../models/booking_quote_response_model.dart';
import '../models/create_booking_request_body.dart';
import '../models/create_booking_response_model.dart';
import '../models/player_booking_detail_model.dart';
import '../models/player_booking_summary_model.dart';
import '../models/submit_proof_request_body.dart';
import '../models/upload_ticket_model.dart';

part 'booking_api_service.g.dart';

@RestApi()
abstract class BookingApiService {
  factory BookingApiService(Dio dio, {String? baseUrl}) = _BookingApiService;

  @POST(ApiConstants.bookingQuote)
  Future<BookingQuoteResponseModel> getQuote(
    @Body() BookingQuoteRequestBody body,
  );

  @POST(ApiConstants.createBooking)
  Future<CreateBookingResponseModel> createBooking(
    @Body() CreateBookingRequestBody body,
    @Header('Idempotency-Key') String idempotencyKey,
  );

  @GET(ApiConstants.myBookingsList)
  Future<PlayerBookingsPagedListModel> getMyBookings({
    @Query('tab') String? tab,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  @GET(ApiConstants.myBookingDetail)
  Future<PlayerBookingDetailModel> getBookingDetail(@Path('id') String id);

  @POST(ApiConstants.proofUploadUrl)
  Future<UploadTicketModel> getProofUploadUrl(@Path('id') String id);

  @POST(ApiConstants.submitBookingProof)
  Future<dynamic> submitProof(
    @Path('id') String id,
    @Body() SubmitProofRequestBody body,
  );
}
