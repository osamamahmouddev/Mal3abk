import '../../../../core/network/api_result.dart';
import '../../data/models/my_permissions_model.dart';
import '../../data/models/venue_model.dart';

abstract class VenueShellRepo {
  Future<ApiResult<List<VenueModel>>> getVenues();

  Future<ApiResult<MyPermissionsModel>> getPermissions();

  /// The venue picked last on this device, or null.
  Future<String?> readSelectedVenueId();

  Future<void> saveSelectedVenueId(String venueId);
}
