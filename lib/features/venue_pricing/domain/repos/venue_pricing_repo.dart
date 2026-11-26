import '../../../../core/network/api_result.dart';
import '../../data/models/price_rule_model.dart';

abstract class VenuePricingRepo {
  Future<ApiResult<List<PriceRuleModel>>> getRules(String venueId);

  /// Creates the rule, or updates it when the draft has an id.
  Future<ApiResult<void>> saveRule(String venueId, PriceRuleDraft draft);

  Future<ApiResult<void>> deleteRule(String venueId, String ruleId);

  Future<ApiResult<PriceQuoteModel>> preview(
    String venueId, {
    required String pitchId,
    required DateTime startUtc,
    required DateTime endUtc,
  });
}
