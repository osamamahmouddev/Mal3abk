import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/venue_calendar_repo.dart';
import '../apis/venue_calendar_api_service.dart';
import '../models/calendar_slot_model.dart';
import '../models/manual_booking_request_body.dart';
import '../models/operating_schedule_model.dart';
import '../models/venue_customer_model.dart';

class VenueCalendarRepoImpl implements VenueCalendarRepo {
  VenueCalendarRepoImpl({required this.apiService});

  final VenueCalendarApiService apiService;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  static String _iso(DateTime value) => value.toUtc().toIso8601String();

  @override
  Future<ApiResult<List<CalendarSlotModel>>> getCalendar(
    String venueId, {
    required DateTime fromUtc,
    required DateTime toUtc,
    String? pitchId,
  }) => _guard(
    () => apiService.getCalendar(
      venueId,
      rangeStartUtc: _iso(fromUtc),
      rangeEndUtc: _iso(toUtc),
      pitchId: pitchId,
    ),
  );

  @override
  Future<ApiResult<List<OperatingScheduleModel>>> getSchedules(
    String venueId,
  ) => _guard(() => apiService.getSchedules(venueId));

  @override
  Future<ApiResult<void>> blockSlot(
    String venueId, {
    required String pitchId,
    required DateTime startUtc,
    required DateTime endUtc,
    required String reason,
  }) => _guard(
    () => apiService.blockSlot(venueId, {
      'pitchId': pitchId,
      'startUtc': _iso(startUtc),
      'endUtc': _iso(endUtc),
      'reason': reason.trim(),
    }),
  );

  @override
  Future<ApiResult<void>> unblockSlot(String venueId, String slotId) =>
      _guard(() => apiService.unblockSlot(venueId, slotId));

  @override
  Future<ApiResult<void>> createManualBooking(
    String venueId,
    ManualBookingRequestBody body,
  ) => _guard(() => apiService.createManualBooking(venueId, body));

  @override
  Future<ApiResult<BulkOutcome>> bulkBook(
    String venueId, {
    required List<CalendarHour> hours,
    required ManualPaymentStatus status,
    String? customerName,
    String? customerPhone,
    double? pricePerHour,
  }) => _guard(() async {
    final json = await apiService.bulkBook(venueId, {
      'slots': [for (final h in hours) h.toJson()],
      'paymentStatus': status.value,
      'customerName': ?customerName,
      'customerPhone': ?customerPhone,
      'pricePerHour': ?pricePerHour,
    });
    return BulkOutcome.fromBookJson(
      json is Map<String, dynamic> ? json : const {},
    );
  });

  @override
  Future<ApiResult<BulkOutcome>> release(
    String venueId, {
    required List<String> bookingIds,
    required List<String> blockedSlotIds,
  }) => _guard(() async {
    var freed = 0;
    var failed = 0;
    if (bookingIds.isNotEmpty) {
      final json = await apiService.bulkRelease(venueId, {
        'bookingIds': bookingIds,
      });
      final outcome = BulkOutcome.fromReleaseJson(
        json is Map<String, dynamic> ? json : const {},
      );
      freed += outcome.succeeded;
      failed += outcome.failed;
    }
    for (final id in blockedSlotIds) {
      try {
        await apiService.unblockSlot(venueId, id);
        freed++;
      } catch (_) {
        failed++;
      }
    }
    return BulkOutcome(succeeded: freed, failed: failed);
  });

  @override
  Future<ApiResult<List<VenueCustomerModel>>> searchCustomers(
    String venueId,
    String search,
  ) => _guard(() async {
    final page = await apiService.getCustomers(
      venueId,
      search: search.trim().isEmpty ? null : search.trim(),
    );
    return page.items;
  });

  @override
  Future<double?> previewPrice(
    String venueId, {
    required String pitchId,
    required DateTime startUtc,
    required DateTime endUtc,
  }) async {
    try {
      final json = await apiService.previewPrice(venueId, {
        'pitchId': pitchId,
        'startUtc': _iso(startUtc),
        'endUtc': _iso(endUtc),
      });
      if (json is! Map) return null;
      final current = json['current'];
      final total = current is Map ? current['total'] : null;
      return total is num ? total.toDouble() : null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ApiResult<void>> confirmManual(String venueId, String bookingId) =>
      _guard(() => apiService.confirmManual(venueId, bookingId, const {}));

  @override
  Future<ApiResult<void>> cancelBooking(
    String venueId,
    String bookingId,
    String reason,
  ) => _guard(
    () =>
        apiService.cancelBooking(venueId, bookingId, {'reason': reason.trim()}),
  );
}
