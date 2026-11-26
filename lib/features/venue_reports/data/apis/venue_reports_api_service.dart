import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/venue_report_models.dart';

part 'venue_reports_api_service.g.dart';

@RestApi()
abstract class VenueReportsApiService {
  factory VenueReportsApiService(Dio dio, {String? baseUrl}) =
      _VenueReportsApiService;

  @GET(ApiConstants.venueReports)
  Future<VenueReportModel> getReport(
    @Path('venueId') String venueId, {
    @Query('from') required String from,
    @Query('to') required String to,
    @Query('groupBy') required int groupBy,
    @Query('pitchId') String? pitchId,
  });

  @GET(ApiConstants.venueReportsCsv)
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> exportBookingsCsv(
    @Path('venueId') String venueId, {
    @Query('from') required String from,
    @Query('to') required String to,
    @Query('pitchId') String? pitchId,
  });

  @GET(ApiConstants.venuePayouts)
  Future<VenuePayoutStatementModel> getPayouts(@Path('venueId') String venueId);
}
