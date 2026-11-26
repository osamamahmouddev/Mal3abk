import '../../../../core/network/api_result.dart';
import '../../data/models/booking_policy_model.dart';

abstract class VenuePoliciesRepo {
  Future<ApiResult<BookingPolicyModel>> getPolicy(String venueId);

  Future<ApiResult<void>> savePolicy(String venueId, BookingPolicyModel policy);
}
