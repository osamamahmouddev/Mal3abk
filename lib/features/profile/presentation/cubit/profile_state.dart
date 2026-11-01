import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/my_profile_model.dart';

part 'profile_state.freezed.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileInitial;
  const factory ProfileState.loading() = ProfileLoading;
  const factory ProfileState.success(MyProfileModel profile) = ProfileSuccess;
  const factory ProfileState.error(String message) = ProfileError;
}
