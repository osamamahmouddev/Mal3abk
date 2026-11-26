import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/venue_policies_repo.dart';
import '../apis/venue_policies_api_service.dart';
import '../models/booking_policy_model.dart';

class VenuePoliciesRepoImpl implements VenuePoliciesRepo {
  VenuePoliciesRepoImpl({required this.apiService});

  final VenuePoliciesApiService apiService;

  @override
  Future<ApiResult<BookingPolicyModel>> getPolicy(String venueId) async {
    try {
      return ApiResult.success(
        BookingPolicyModel.fromVersions(await apiService.getPolicy(venueId)),
      );
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> savePolicy(
    String venueId,
    BookingPolicyModel policy,
  ) async {
    try {
      await apiService.savePolicy(venueId, policy.toJson());
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }
}
