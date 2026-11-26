import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/venue_overview_repo.dart';
import '../apis/venue_overview_api_service.dart';
import '../models/venue_approval_model.dart';
import '../models/venue_dashboard_model.dart';

class VenueOverviewRepoImpl implements VenueOverviewRepo {
  VenueOverviewRepoImpl({required this.apiService});

  final VenueOverviewApiService apiService;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<VenueDashboardModel>> getDashboard(String venueId) =>
      _guard(() => apiService.getDashboard(venueId));

  @override
  Future<ApiResult<VenueApprovalModel>> getApproval(String venueId) =>
      _guard(() => apiService.getApproval(venueId));
}
