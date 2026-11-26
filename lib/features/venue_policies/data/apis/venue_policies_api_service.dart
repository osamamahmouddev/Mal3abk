import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';

part 'venue_policies_api_service.g.dart';

@RestApi()
abstract class VenuePoliciesApiService {
  factory VenuePoliciesApiService(Dio dio, {String? baseUrl}) =
      _VenuePoliciesApiService;

  /// Every version of the policy; one is current.
  @GET(ApiConstants.venueBookingPolicy)
  Future<dynamic> getPolicy(@Path('venueId') String venueId);

  @PUT(ApiConstants.venueBookingPolicy)
  Future<void> savePolicy(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );
}
