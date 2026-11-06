import 'package:freezed_annotation/freezed_annotation.dart';

part 'avatar_state.freezed.dart';

@freezed
sealed class AvatarState with _$AvatarState {
  const factory AvatarState.idle({String? avatarUrl}) = AvatarIdle;
  const factory AvatarState.uploading({String? avatarUrl}) = AvatarUploading;
  const factory AvatarState.error(String message, {String? avatarUrl}) =
      AvatarError;
}
