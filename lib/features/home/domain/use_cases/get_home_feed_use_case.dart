import '../../../../core/network/api_result.dart';
import '../../data/models/home_feed_model.dart';
import '../repos/home_repo.dart';

class GetHomeFeedUseCase {
  GetHomeFeedUseCase({required this.homeRepo});

  final HomeRepo homeRepo;

  Future<ApiResult<HomeFeedModel>> call({String? city, String? area}) =>
      homeRepo.getHomeFeed(city: city ?? 'القاهرة', area: area ?? 'مدينة نصر');
}
