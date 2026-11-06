import '../../../../core/network/api_result.dart';
import '../../data/models/explore_filter_model.dart';
import '../../data/models/explore_result_model.dart';
import '../repos/explore_repo.dart';

class ExploreVenuesUseCase {
  ExploreVenuesUseCase({required this.exploreRepo});

  final ExploreRepo exploreRepo;

  Future<ApiResult<ExploreResultModel>> call({
    String? city,
    String? area,
    ExploreFilterModel filter = const ExploreFilterModel(),
    int? page,
    int? pageSize,
  }) => exploreRepo.exploreVenues(
    city: city,
    area: area,
    filter: filter,
    page: page,
    pageSize: pageSize,
  );
}
