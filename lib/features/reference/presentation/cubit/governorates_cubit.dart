import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/reference_repo.dart';
import 'governorates_state.dart';

class GovernoratesCubit extends Cubit<GovernoratesState>
    with SafeEmitCubitMixin<GovernoratesState> {
  GovernoratesCubit({required this.referenceRepo})
    : super(const GovernoratesState.initial());

  final ReferenceRepo referenceRepo;

  Future<void> load() async {
    emitIfOpen(const GovernoratesState.loading());
    final result = await referenceRepo.getGovernorates();
    result.when(
      success: (items) => emitIfOpen(GovernoratesState.success(items)),
      failure: (failure) =>
          emitIfOpen(GovernoratesState.error(failure.message)),
    );
  }
}
