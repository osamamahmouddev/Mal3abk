import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../profile/data/models/my_profile_model.dart';

part 'profile_setup_state.freezed.dart';

@freezed
sealed class ProfileSetupState with _$ProfileSetupState {
  const factory ProfileSetupState.initial() = ProfileSetupInitial;
  const factory ProfileSetupState.loading() = ProfileSetupLoading;
  const factory ProfileSetupState.success(MyProfileModel profile) =
      ProfileSetupSuccess;
  const factory ProfileSetupState.error(String message) = ProfileSetupError;
}
