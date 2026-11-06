import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/reference_repo.dart';
import 'filter_options_state.dart';

class FilterOptionsCubit extends Cubit<FilterOptionsState>
    with SafeEmitCubitMixin<FilterOptionsState> {
  FilterOptionsCubit({required this.referenceRepo})
    : super(const FilterOptionsState.loading());

  final ReferenceRepo referenceRepo;

  Future<void> load() async {
    emitIfOpen(const FilterOptionsState.loading());
    final result = await referenceRepo.getFilterOptions();
    result.when(
      success: (options) => emitIfOpen(FilterOptionsState.success(options)),
      failure: (failure) =>
          emitIfOpen(FilterOptionsState.error(failure.message)),
    );
  }
}
