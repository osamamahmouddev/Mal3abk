import '../../../../core/network/api_result.dart';
import '../../data/models/home_feed_model.dart';

abstract class HomeRepo {
  Future<ApiResult<HomeFeedModel>> getHomeFeed({String? city, String? area});
}
