import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../profile/data/models/complete_profile_request_body.dart';
import '../../../profile/domain/use_cases/save_profile_use_case.dart';
import 'profile_setup_state.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState>
    with SafeEmitCubitMixin<ProfileSetupState> {
  ProfileSetupCubit({required this.saveProfileUseCase})
    : super(const ProfileSetupState.initial());

  final SaveProfileUseCase saveProfileUseCase;

  Future<void> save(
    CompleteProfileRequestBody body, {
    required bool isOnboarding,
  }) async {
    if (state is ProfileSetupLoading) return;
    emitIfOpen(const ProfileSetupState.loading());
    final result = await saveProfileUseCase(body, isOnboarding: isOnboarding);
    result.when(
      success: (profile) => emitIfOpen(ProfileSetupState.success(profile)),
      failure: (failure) =>
          emitIfOpen(ProfileSetupState.error(failure.message)),
    );
  }
}
