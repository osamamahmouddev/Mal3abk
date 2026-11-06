import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/explore_venues_use_case.dart';
import 'explore_list_state.dart';

class ExploreListCubit extends Cubit<ExploreListState>
    with SafeEmitCubitMixin<ExploreListState> {
  ExploreListCubit({required this.exploreVenuesUseCase})
    : super(const ExploreListState.initial());

  final ExploreVenuesUseCase exploreVenuesUseCase;

  Future<void> fetchVenues({
    String? city,
    String? area,
    int? page,
    int? pageSize,
  }) async {
    if (state is! ExploreListSuccess) {
      emitIfOpen(const ExploreListState.loading());
    }
    final result = await exploreVenuesUseCase(
      city: city,
      area: area,
      page: page,
      pageSize: pageSize,
    );
    result.when(
      success: (data) => emitIfOpen(ExploreListState.success(data)),
      failure: (failure) => emitIfOpen(ExploreListState.error(failure.message)),
    );
  }
}
