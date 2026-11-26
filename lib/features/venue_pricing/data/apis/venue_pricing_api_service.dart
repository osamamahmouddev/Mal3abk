import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/price_rule_model.dart';

part 'venue_pricing_api_service.g.dart';

@RestApi()
abstract class VenuePricingApiService {
  factory VenuePricingApiService(Dio dio, {String? baseUrl}) =
      _VenuePricingApiService;

  @GET(ApiConstants.venuePriceRules)
  Future<List<PriceRuleModel>> getRules(@Path('venueId') String venueId);

  @POST(ApiConstants.venuePriceRules)
  Future<void> createRule(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );

  @PUT(ApiConstants.venuePriceRule)
  Future<void> updateRule(
    @Path('venueId') String venueId,
    @Path('ruleId') String ruleId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiConstants.venuePriceRule)
  Future<void> deleteRule(
    @Path('venueId') String venueId,
    @Path('ruleId') String ruleId,
  );

  @POST(ApiConstants.venuePricePreview)
  Future<dynamic> preview(
    @Path('venueId') String venueId,
    @Body() Map<String, dynamic> body,
  );
}
