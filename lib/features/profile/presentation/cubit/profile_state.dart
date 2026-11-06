import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/profile_overview_model.dart';

part 'profile_state.freezed.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileInitial;
  const factory ProfileState.loading() = ProfileLoading;
  const factory ProfileState.success(ProfileOverviewModel overview) =
      ProfileSuccess;
  const factory ProfileState.error(String message) = ProfileError;
}
