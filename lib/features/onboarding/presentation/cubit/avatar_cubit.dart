import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/media_url.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../profile/data/models/my_profile_model.dart';
import '../../../profile/domain/repos/profile_repo.dart';
import '../../../profile/domain/use_cases/upload_avatar_use_case.dart';
import 'avatar_state.dart';

class AvatarCubit extends Cubit<AvatarState>
    with SafeEmitCubitMixin<AvatarState> {
  AvatarCubit({
    required this.uploadAvatarUseCase,
    required this.profileRepo,
    required this.mediaBaseUrl,
  }) : super(const AvatarState.idle());

  final UploadAvatarUseCase uploadAvatarUseCase;
  final ProfileRepo profileRepo;
  final String mediaBaseUrl;

  /// Shows the avatar the player already has.
  void seed(String? avatarPath) =>
      emitIfOpen(AvatarState.idle(avatarUrl: _resolve(avatarPath)));

  String? _resolve(String? path) =>
      MediaUrl.resolve(path, baseUrl: mediaBaseUrl);

  Future<void> upload(Uint8List pickedBytes) =>
      _run(() => uploadAvatarUseCase(pickedBytes));

  Future<void> remove() => _run(profileRepo.removeAvatar);

  Future<void> _run(Future<ApiResult<MyProfileModel>> Function() call) async {
    if (state is AvatarUploading) return;
    final previous = state.avatarUrl;
    emitIfOpen(AvatarState.uploading(avatarUrl: previous));
    final result = await call();
    result.when(
      success: (profile) =>
          emitIfOpen(AvatarState.idle(avatarUrl: _resolve(profile.avatarUrl))),
      failure: (failure) =>
          emitIfOpen(AvatarState.error(failure.message, avatarUrl: previous)),
    );
  }
}
