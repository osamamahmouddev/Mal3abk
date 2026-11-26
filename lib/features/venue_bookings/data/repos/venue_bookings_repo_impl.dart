import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/venue_bookings_repo.dart';
import '../apis/venue_bookings_api_service.dart';
import '../models/venue_booking_detail_model.dart';
import '../models/venue_booking_item_model.dart';
import '../models/venue_bookings_query.dart';

class VenueBookingsRepoImpl implements VenueBookingsRepo {
  VenueBookingsRepoImpl({required this.apiService});

  final VenueBookingsApiService apiService;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<VenueBookingPageModel>> getBookings(
    String venueId,
    VenueBookingsQuery query, {
    VenueBookingsTab? tab,
    int page = 1,
    int pageSize = 20,
  }) => _guard(() {
    final statuses = VenueBookingsQuery.statusesOf(tab ?? query.tab);
    final window = query.utcWindow;
    return apiService.getBookings(
      venueId,
      statuses: statuses.isEmpty ? null : statuses,
      search: query.search.isEmpty ? null : query.search,
      pitchId: query.pitchId,
      startDateUtc: window?.$1,
      endDateUtc: window?.$2,
      manual: query.manualValue,
      sort: query.sortValue,
      page: page,
      pageSize: pageSize,
    );
  });

  @override
  Future<ApiResult<VenueBookingDetailModel>> getBooking(
    String venueId,
    String bookingId,
  ) => _guard(() => apiService.getBooking(venueId, bookingId));

  @override
  Future<ApiResult<void>> confirmManual(String venueId, String bookingId) =>
      _guard(() => apiService.confirmManual(venueId, bookingId, const {}));

  @override
  Future<ApiResult<void>> cancel(
    String venueId,
    String bookingId,
    String reason,
  ) => _guard(
    () => apiService.cancel(venueId, bookingId, {'reason': reason.trim()}),
  );

  @override
  Future<ApiResult<void>> markNoShow(
    String venueId,
    String bookingId,
    String reason,
  ) => _guard(
    () => apiService.markNoShow(venueId, bookingId, {'reason': reason.trim()}),
  );
}
