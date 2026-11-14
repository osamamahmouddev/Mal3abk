import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/create_team_request_body.dart';
import '../../domain/use_cases/create_team_use_case.dart';
import 'create_team_state.dart';

class CreateTeamCubit extends Cubit<CreateTeamState>
    with SafeEmitCubitMixin<CreateTeamState> {
  CreateTeamCubit({required this.createTeamUseCase})
    : super(const CreateTeamState.initial());

  final CreateTeamUseCase createTeamUseCase;

  Future<void> create(
    CreateTeamRequestBody body, {
    required bool isPublic,
  }) async {
    if (state is CreateTeamLoading) return;
    emitIfOpen(const CreateTeamState.loading());
    final result = await createTeamUseCase(body, isPublic: isPublic);
    result.when(
      success: (created) => emitIfOpen(
        CreateTeamState.success(
          created.team,
          settingsSaved: created.settingsSaved,
        ),
      ),
      failure: (failure) => emitIfOpen(CreateTeamState.error(failure.message)),
    );
  }
}
