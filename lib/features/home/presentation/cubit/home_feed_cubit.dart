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

  /// The area the player picked on the home screen. It lasts until they pick
  /// another (or all of Egypt), so pull-to-refresh keeps showing it.
  String? _chosenCity;
  String? _chosenArea;

  Future<void> fetchFeed({String? city, String? area}) async {
    if (city != null) {
      _chosenCity = city;
      _chosenArea = area;
    }
    await _load();
  }

  /// Drops the picked area: the feed shows every pitch in Egypt.
  Future<void> showAllEgypt() {
    _chosenCity = null;
    _chosenArea = null;
    return _load();
  }

  Future<void> _load() async {
    if (state is! HomeFeedSuccess) emitIfOpen(const HomeFeedState.loading());
    final result = await getHomeFeedUseCase(
      city: _chosenCity,
      area: _chosenArea,
    );
    result.when(
      success: (located) => emitIfOpen(HomeFeedState.success(located)),
      failure: (failure) => emitIfOpen(HomeFeedState.error(failure.message)),
    );
  }
}
