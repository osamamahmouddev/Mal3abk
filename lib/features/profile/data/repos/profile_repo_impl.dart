import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/profile_repo.dart';
import '../apis/profile_api_service.dart';
import '../models/avatar_request_body.dart';
import '../models/complete_profile_request_body.dart';
import '../models/create_upload_request_body.dart';
import '../models/my_profile_model.dart';
import '../models/public_player_profile_model.dart';

class ProfileRepoImpl implements ProfileRepo {
  ProfileRepoImpl({required this.profileApiService, required this.dio});

  final ProfileApiService profileApiService;
  final Dio dio;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<MyProfileModel>> getMyProfile() =>
      _guard(profileApiService.getMyProfile);

  @override
  Future<ApiResult<PublicPlayerProfileModel>> getPlayerProfile(String userId) =>
      _guard(() => profileApiService.getPlayerProfile(userId));

  @override
  Future<ApiResult<MyProfileModel>> completeProfile(
    CompleteProfileRequestBody body,
  ) => _guard(() => profileApiService.completeProfile(body));

  @override
  Future<ApiResult<MyProfileModel>> updateProfile(
    CompleteProfileRequestBody body,
  ) => _guard(() => profileApiService.updateProfile(body));

  @override
  Future<ApiResult<MyProfileModel>> uploadAvatar(
    Uint8List jpeg, {
    required String contentType,
  }) => _guard(() async {
    final ticket = await profileApiService.createUpload(
      const CreateUploadRequestBody(purpose: MediaPurpose.avatar),
    );
    await dio.put<void>(
      ticket.uploadUrl,
      data: jpeg,
      options: Options(
        headers: {
          Headers.contentTypeHeader: contentType,
          Headers.contentLengthHeader: jpeg.length,
        },
      ),
    );
    return profileApiService.setAvatar(
      AvatarRequestBody(mediaId: ticket.mediaId),
    );
  });

  @override
  Future<ApiResult<MyProfileModel>> removeAvatar() =>
      _guard(profileApiService.removeAvatar);
}
