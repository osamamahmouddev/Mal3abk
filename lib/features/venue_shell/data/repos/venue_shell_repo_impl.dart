import '../../../../core/local_storage/secure_storage.dart';
import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/venue_shell_repo.dart';
import '../apis/venue_shell_api_service.dart';
import '../models/my_permissions_model.dart';
import '../models/venue_model.dart';

class VenueShellRepoImpl implements VenueShellRepo {
  VenueShellRepoImpl({required this.apiService});

  final VenueShellApiService apiService;

  /// Not a secret: only which of the user's venues was open last.
  static const String _selectedVenueKey = 'venue_selected_id';

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<List<VenueModel>>> getVenues() =>
      _guard(apiService.getVenues);

  @override
  Future<ApiResult<MyPermissionsModel>> getPermissions() =>
      _guard(apiService.getPermissions);

  @override
  Future<String?> readSelectedVenueId() async {
    final id = await SharedPrefHelper.getString(_selectedVenueKey);
    return id.isEmpty ? null : id;
  }

  @override
  Future<void> saveSelectedVenueId(String venueId) =>
      SharedPrefHelper.setData(_selectedVenueKey, venueId);
}
