import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/get_home_feed_use_case.dart';
import 'home_feed_state.dart';

class HomeFeedCubit extends Cubit<HomeFeedState>
    with SafeEmitCubitMixin<HomeFeedState> {
  HomeFeedCubit({required this.getHomeFeedUseCase})
    : super(const HomeFeedState.initial());

  final GetHomeFeedUseCase getHomeFeedUseCase;

  Future<void> fetchFeed({String? city, String? area}) async {
    if (state is! HomeFeedSuccess) emitIfOpen(const HomeFeedState.loading());
    final result = await getHomeFeedUseCase(city: city, area: area);
    result.when(
      success: (located) => emitIfOpen(HomeFeedState.success(located)),
      failure: (failure) => emitIfOpen(HomeFeedState.error(failure.message)),
    );
  }
}
