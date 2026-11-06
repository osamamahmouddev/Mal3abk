import 'dart:typed_data';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../../../core/utils/image_sanitizer.dart';
import '../../data/models/my_profile_model.dart';
import '../repos/profile_repo.dart';

/// Rejects anything that isn't a real JPEG/PNG/WebP photo and strips its
/// metadata before uploading it as the avatar.
class UploadAvatarUseCase {
  UploadAvatarUseCase({
    required this.profileRepo,
    this.imageSanitizer = const ImageSanitizer(),
  });

  final ProfileRepo profileRepo;
  final ImageSanitizer imageSanitizer;

  Future<ApiResult<MyProfileModel>> call(Uint8List pickedBytes) async {
    final clean = await imageSanitizer.sanitize(pickedBytes);
    if (clean == null) {
      return const ApiResult.failure(
        AppApiFailure(message: 'errors.media.invalid_image'),
      );
    }
    return profileRepo.uploadAvatar(
      clean,
      contentType: ImageSanitizer.contentType,
    );
  }
}
