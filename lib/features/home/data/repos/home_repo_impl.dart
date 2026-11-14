import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/home_repo.dart';
import '../apis/home_api_service.dart';
import '../models/home_feed_model.dart';

class HomeRepoImpl implements HomeRepo {
  HomeRepoImpl({required this.homeApiService});

  final HomeApiService homeApiService;

  @override
  Future<ApiResult<HomeFeedModel>> getHomeFeed({
    String? city,
    String? area,
    double? lat,
    double? lng,
  }) async {
    try {
      final response = await homeApiService.getHomeFeed(
        city: city,
        area: area,
        lat: lat,
        lng: lng,
      );
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }
}
