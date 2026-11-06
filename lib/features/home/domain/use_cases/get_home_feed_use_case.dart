import '../../../../core/network/api_result.dart';
import '../../../profile/domain/repos/profile_repo.dart';
import '../../data/models/located_home_feed_model.dart';
import '../repos/home_repo.dart';

/// Loads the feed for the given place, or for the player's own city and area
/// from their profile.
class GetHomeFeedUseCase {
  GetHomeFeedUseCase({required this.homeRepo, required this.profileRepo});

  final HomeRepo homeRepo;
  final ProfileRepo profileRepo;

  Future<ApiResult<LocatedHomeFeedModel>> call({
    String? city,
    String? area,
  }) async {
    var placeCity = city;
    var placeArea = area;
    if (placeCity == null) {
      final profile = await profileRepo.getMyProfile();
      profile.maybeWhen(
        success: (p) {
          placeCity = p.city;
          placeArea = p.area;
        },
        orElse: () {},
      );
    }
    final result = await homeRepo.getHomeFeed(city: placeCity, area: placeArea);
    return result.when(
      success: (feed) => ApiResult.success(
        LocatedHomeFeedModel(feed: feed, city: placeCity, area: placeArea),
      ),
      failure: (failure) => ApiResult.failure(failure),
    );
  }
}
