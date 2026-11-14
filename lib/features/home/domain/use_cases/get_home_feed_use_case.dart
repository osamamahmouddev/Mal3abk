import '../../../../core/location/location_service.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/located_home_feed_model.dart';
import '../repos/home_repo.dart';

/// Loads the feed for a picked place, for the player's own location, or for
/// all of Egypt when neither is given.
class GetHomeFeedUseCase {
  GetHomeFeedUseCase({required this.homeRepo});

  final HomeRepo homeRepo;

  Future<ApiResult<LocatedHomeFeedModel>> call({
    String? city,
    String? area,
    GeoPoint? near,
  }) async {
    final result = near == null
        ? await homeRepo.getHomeFeed(city: city, area: area)
        : await homeRepo.getHomeFeed(lat: near.latitude, lng: near.longitude);
    return result.when(
      success: (feed) => ApiResult.success(
        LocatedHomeFeedModel(
          feed: feed,
          city: near == null ? city : null,
          area: near == null ? area : null,
          near: near,
        ),
      ),
      failure: (failure) => ApiResult.failure(failure),
    );
  }
}
