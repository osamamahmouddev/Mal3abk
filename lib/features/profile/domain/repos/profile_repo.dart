import 'dart:typed_data';

import '../../../../core/network/api_result.dart';
import '../../data/models/complete_profile_request_body.dart';
import '../../data/models/my_profile_model.dart';
import '../../data/models/public_player_profile_model.dart';

abstract class ProfileRepo {
  Future<ApiResult<MyProfileModel>> getMyProfile();

  Future<ApiResult<PublicPlayerProfileModel>> getPlayerProfile(String userId);

  Future<ApiResult<MyProfileModel>> completeProfile(
    CompleteProfileRequestBody body,
  );

  Future<ApiResult<MyProfileModel>> updateProfile(
    CompleteProfileRequestBody body,
  );

  /// Uploads an already sanitized JPEG and makes it the avatar.
  Future<ApiResult<MyProfileModel>> uploadAvatar(
    Uint8List jpeg, {
    required String contentType,
  });

  Future<ApiResult<MyProfileModel>> removeAvatar();
}
