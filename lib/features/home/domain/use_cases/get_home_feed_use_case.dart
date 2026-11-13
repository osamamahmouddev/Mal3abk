import '../../../../core/network/api_result.dart';
import '../../data/models/located_home_feed_model.dart';
import '../repos/home_repo.dart';

/// Loads the feed for the given place, or for all of Egypt when none is picked.
class GetHomeFeedUseCase {
  GetHomeFeedUseCase({required this.homeRepo});

  final HomeRepo homeRepo;

  Future<ApiResult<LocatedHomeFeedModel>> call({
    String? city,
    String? area,
  }) async {
    final result = await homeRepo.getHomeFeed(city: city, area: area);
    return result.when(
      success: (feed) => ApiResult.success(
        LocatedHomeFeedModel(feed: feed, city: city, area: area),
      ),
      failure: (failure) => ApiResult.failure(failure),
    );
  }
}
