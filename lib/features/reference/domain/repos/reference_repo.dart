import '../../../../core/network/api_result.dart';
import '../../data/models/filter_options_model.dart';
import '../../data/models/governorate_model.dart';

abstract class ReferenceRepo {
  Future<ApiResult<List<GovernorateModel>>> getGovernorates();

  Future<ApiResult<FilterOptionsModel>> getFilterOptions();
}
