import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/venue_reports_repo.dart';
import '../apis/venue_reports_api_service.dart';
import '../models/venue_report_models.dart';

class VenueReportsRepoImpl implements VenueReportsRepo {
  VenueReportsRepoImpl({required this.apiService});

  final VenueReportsApiService apiService;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<VenueReportModel>> getReport(
    String venueId, {
    required String from,
    required String to,
    required int groupBy,
    String? pitchId,
  }) => _guard(
    () => apiService.getReport(
      venueId,
      from: from,
      to: to,
      groupBy: groupBy,
      pitchId: pitchId,
    ),
  );

  @override
  Future<ApiResult<List<int>>> exportBookingsCsv(
    String venueId, {
    required String from,
    required String to,
    String? pitchId,
  }) => _guard(
    () async => (await apiService.exportBookingsCsv(
      venueId,
      from: from,
      to: to,
      pitchId: pitchId,
    )).data,
  );

  @override
  Future<ApiResult<VenuePayoutStatementModel>> getPayouts(String venueId) =>
      _guard(() => apiService.getPayouts(venueId));
}
