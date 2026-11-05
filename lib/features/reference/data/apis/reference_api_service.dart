import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/governorate_model.dart';

part 'reference_api_service.g.dart';

@RestApi()
abstract class ReferenceApiService {
  factory ReferenceApiService(Dio dio, {String? baseUrl}) =
      _ReferenceApiService;

  @GET(ApiConstants.governorates)
  Future<List<GovernorateModel>> getGovernorates();
}
