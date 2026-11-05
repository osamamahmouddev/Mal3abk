import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/reference_repo.dart';
import '../apis/reference_api_service.dart';
import '../models/governorate_model.dart';

class ReferenceRepoImpl implements ReferenceRepo {
  ReferenceRepoImpl({required this.referenceApiService});

  final ReferenceApiService referenceApiService;
  List<GovernorateModel>? cachedGovernorates;

  @override
  Future<ApiResult<List<GovernorateModel>>> getGovernorates() async {
    final cached = cachedGovernorates;
    if (cached != null) return ApiResult.success(cached);
    try {
      final governorates = await referenceApiService.getGovernorates();
      cachedGovernorates = governorates;
      return ApiResult.success(governorates);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }
}
