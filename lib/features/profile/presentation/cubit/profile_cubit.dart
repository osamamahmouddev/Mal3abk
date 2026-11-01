import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/get_my_profile_use_case.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState>
    with SafeEmitCubitMixin<ProfileState> {
  ProfileCubit({required this.getMyProfileUseCase})
    : super(const ProfileState.initial());

  final GetMyProfileUseCase getMyProfileUseCase;

  Future<void> fetchProfile() async {
    emitIfOpen(const ProfileState.loading());
    final result = await getMyProfileUseCase();
    result.when(
      success: (profile) => emitIfOpen(ProfileState.success(profile)),
      failure: (failure) => emitIfOpen(ProfileState.error(failure.message)),
    );
  }
}
