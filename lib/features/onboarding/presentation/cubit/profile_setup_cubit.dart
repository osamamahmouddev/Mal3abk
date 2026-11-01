import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../profile/data/models/complete_profile_request_body.dart';
import '../../../profile/domain/use_cases/complete_profile_use_case.dart';
import 'profile_setup_state.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState>
    with SafeEmitCubitMixin<ProfileSetupState> {
  ProfileSetupCubit({required this.completeProfileUseCase})
    : super(const ProfileSetupState.initial());

  final CompleteProfileUseCase completeProfileUseCase;

  Future<void> completeProfile({
    required String fullName,
    required String city,
    required String area,
    List<String>? positions,
    String? skillLevel,
    String? language,
  }) async {
    emitIfOpen(const ProfileSetupState.loading());
    final result = await completeProfileUseCase(
      CompleteProfileRequestBody(
        fullName: fullName,
        city: city,
        area: area,
        positions: positions,
        skillLevel: skillLevel,
        language: language,
      ),
    );
    result.when(
      success: (profile) => emitIfOpen(ProfileSetupState.success(profile)),
      failure: (failure) =>
          emitIfOpen(ProfileSetupState.error(failure.message)),
    );
  }
}
