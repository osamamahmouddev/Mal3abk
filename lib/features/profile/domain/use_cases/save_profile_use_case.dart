import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../data/models/complete_profile_request_body.dart';
import '../../data/models/my_profile_model.dart';
import '../repos/profile_repo.dart';

/// Validates the profile like the server does, then completes onboarding or
/// updates an existing profile.
class SaveProfileUseCase {
  SaveProfileUseCase({required this.profileRepo});

  static const int minNameLength = 2;
  static const int maxNameLength = 100;
  static const int maxPlaceLength = 100;
  static const int maxPositions = 4;

  final ProfileRepo profileRepo;

  Future<ApiResult<MyProfileModel>> call(
    CompleteProfileRequestBody body, {
    required bool isOnboarding,
  }) async {
    final name = body.fullName.trim().replaceAll(RegExp(r'\s+'), ' ');
    final city = body.city.trim();
    final area = body.area.trim();
    if (name.length < minNameLength || name.length > maxNameLength) {
      return const ApiResult.failure(
        AppApiFailure(message: 'errors.profile.invalid_name'),
      );
    }
    if (city.isEmpty ||
        area.isEmpty ||
        city.length > maxPlaceLength ||
        area.length > maxPlaceLength) {
      return const ApiResult.failure(
        AppApiFailure(message: 'errors.profile.invalid_place'),
      );
    }
    if (body.positions.length > maxPositions) {
      return const ApiResult.failure(
        AppApiFailure(message: 'errors.profile.invalid_positions'),
      );
    }

    final clean = CompleteProfileRequestBody(
      fullName: name,
      city: city,
      area: area,
      positions: body.positions.toSet().toList(growable: false),
      skillLevel: body.skillLevel,
      language: body.language,
    );
    return isOnboarding
        ? profileRepo.completeProfile(clean)
        : profileRepo.updateProfile(clean);
  }
}
