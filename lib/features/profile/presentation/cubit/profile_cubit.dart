import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/get_profile_overview_use_case.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState>
    with SafeEmitCubitMixin<ProfileState> {
  ProfileCubit({required this.getProfileOverviewUseCase})
    : super(const ProfileState.initial());

  final GetProfileOverviewUseCase getProfileOverviewUseCase;

  Future<void> fetchProfile() async {
    if (state is! ProfileSuccess) emitIfOpen(const ProfileState.loading());
    final result = await getProfileOverviewUseCase();
    result.when(
      success: (overview) => emitIfOpen(ProfileState.success(overview)),
      failure: (failure) => emitIfOpen(ProfileState.error(failure.message)),
    );
  }
}
