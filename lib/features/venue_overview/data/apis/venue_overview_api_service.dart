import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/venue_approval_model.dart';
import '../models/venue_dashboard_model.dart';

part 'venue_overview_api_service.g.dart';

@RestApi()
abstract class VenueOverviewApiService {
  factory VenueOverviewApiService(Dio dio, {String? baseUrl}) =
      _VenueOverviewApiService;

  @GET(ApiConstants.venueDashboard)
  Future<VenueDashboardModel> getDashboard(@Path('venueId') String venueId);

  @GET(ApiConstants.venueApproval)
  Future<VenueApprovalModel> getApproval(@Path('venueId') String venueId);
}
