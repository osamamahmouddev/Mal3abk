import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/my_permissions_model.dart';
import '../models/venue_model.dart';

part 'venue_shell_api_service.g.dart';

@RestApi()
abstract class VenueShellApiService {
  factory VenueShellApiService(Dio dio, {String? baseUrl}) =
      _VenueShellApiService;

  @GET(ApiConstants.managedVenues)
  Future<List<VenueModel>> getVenues();

  @GET(ApiConstants.myPermissions)
  Future<MyPermissionsModel> getPermissions();
}
