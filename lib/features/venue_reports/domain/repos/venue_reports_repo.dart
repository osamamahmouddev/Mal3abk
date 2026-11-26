import '../../../../core/network/api_result.dart';
import '../../data/models/venue_report_models.dart';

abstract class VenueReportsRepo {
  Future<ApiResult<VenueReportModel>> getReport(
    String venueId, {
    required String from,
    required String to,
    required int groupBy,
    String? pitchId,
  });

  /// The bookings of the period as CSV bytes.
  Future<ApiResult<List<int>>> exportBookingsCsv(
    String venueId, {
    required String from,
    required String to,
    String? pitchId,
  });

  Future<ApiResult<VenuePayoutStatementModel>> getPayouts(String venueId);
}
