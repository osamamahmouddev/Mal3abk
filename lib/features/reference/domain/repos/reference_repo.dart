import '../../../../core/network/api_result.dart';
import '../../data/models/governorate_model.dart';

abstract class ReferenceRepo {
  Future<ApiResult<List<GovernorateModel>>> getGovernorates();
}
