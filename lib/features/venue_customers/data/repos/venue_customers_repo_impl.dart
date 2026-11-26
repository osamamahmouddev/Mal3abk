import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../../venue_calendar/data/models/venue_customer_model.dart';
import '../../domain/repos/venue_customers_repo.dart';
import '../apis/venue_customers_api_service.dart';
import '../models/venue_customer_detail_model.dart';

class VenueCustomersRepoImpl implements VenueCustomersRepo {
  VenueCustomersRepoImpl({required this.apiService});

  final VenueCustomersApiService apiService;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<VenueCustomerPageModel>> getCustomers(
    String venueId, {
    String search = '',
    int page = 1,
    int pageSize = 25,
  }) => _guard(
    () => apiService.getCustomers(
      venueId,
      search: search.trim().isEmpty ? null : search.trim(),
      page: page,
      pageSize: pageSize,
    ),
  );

  @override
  Future<ApiResult<VenueCustomerDetailModel>> getCustomer(
    String venueId,
    String customerKey,
  ) => _guard(() => apiService.getCustomer(venueId, customerKey));

  @override
  Future<ApiResult<void>> addNote(
    String venueId,
    String customerKey,
    String text,
  ) => _guard(
    () => apiService.addNote(venueId, customerKey, {'text': text.trim()}),
  );

  @override
  Future<ApiResult<void>> deleteNote(
    String venueId,
    String customerKey,
    String noteId,
  ) => _guard(() => apiService.deleteNote(venueId, customerKey, noteId));
}
