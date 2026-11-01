import '../../../../core/network/api_result.dart';
import '../../data/models/explore_result_model.dart';
import '../repos/explore_repo.dart';

class ExploreVenuesUseCase {
  ExploreVenuesUseCase({required this.exploreRepo});

  final ExploreRepo exploreRepo;

  Future<ApiResult<ExploreResultModel>> call({
    String? city,
    String? area,
    int? page,
    int? pageSize,
  }) => exploreRepo.exploreVenues(
    city: city,
    area: area,
    page: page,
    pageSize: pageSize,
  );
}
