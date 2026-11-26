import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/venue_pricing_repo.dart';
import '../apis/venue_pricing_api_service.dart';
import '../models/price_rule_model.dart';

class VenuePricingRepoImpl implements VenuePricingRepo {
  VenuePricingRepoImpl({required this.apiService});

  final VenuePricingApiService apiService;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<List<PriceRuleModel>>> getRules(String venueId) =>
      _guard(() => apiService.getRules(venueId));

  @override
  Future<ApiResult<void>> saveRule(String venueId, PriceRuleDraft draft) =>
      _guard(
        () => draft.id == null
            ? apiService.createRule(venueId, draft.toJson())
            : apiService.updateRule(venueId, draft.id!, draft.toJson()),
      );

  @override
  Future<ApiResult<void>> deleteRule(String venueId, String ruleId) =>
      _guard(() => apiService.deleteRule(venueId, ruleId));

  @override
  Future<ApiResult<PriceQuoteModel>> preview(
    String venueId, {
    required String pitchId,
    required DateTime startUtc,
    required DateTime endUtc,
  }) => _guard(() async {
    final json = await apiService.preview(venueId, {
      'pitchId': pitchId,
      'startUtc': startUtc.toUtc().toIso8601String(),
      'endUtc': endUtc.toUtc().toIso8601String(),
    });
    final current = json is Map ? json['current'] : null;
    return PriceQuoteModel.fromJson(
      current is Map<String, dynamic> ? current : const {},
    );
  });
}
