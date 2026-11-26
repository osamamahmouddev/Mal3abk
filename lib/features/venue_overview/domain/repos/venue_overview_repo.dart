import '../../../../core/network/api_result.dart';
import '../../data/models/venue_approval_model.dart';
import '../../data/models/venue_dashboard_model.dart';

abstract class VenueOverviewRepo {
  Future<ApiResult<VenueDashboardModel>> getDashboard(String venueId);

  Future<ApiResult<VenueApprovalModel>> getApproval(String venueId);
}
