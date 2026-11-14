import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/home_feed_model.dart';

part 'home_api_service.g.dart';

@RestApi()
abstract class HomeApiService {
  factory HomeApiService(Dio dio, {String? baseUrl}) = _HomeApiService;

  @GET(ApiConstants.home)
  Future<HomeFeedModel> getHomeFeed({
    @Query('city') String? city,
    @Query('area') String? area,
    @Query('lat') double? lat,
    @Query('lng') double? lng,
  });
}
