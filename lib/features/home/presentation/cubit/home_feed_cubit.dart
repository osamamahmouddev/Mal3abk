import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/location/location_service.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/get_home_feed_use_case.dart';
import 'home_feed_state.dart';

class HomeFeedCubit extends Cubit<HomeFeedState>
    with SafeEmitCubitMixin<HomeFeedState> {
  HomeFeedCubit({
    required this.getHomeFeedUseCase,
    this.locationService = const LocationService(),
  }) : super(const HomeFeedState.initial());

  final GetHomeFeedUseCase getHomeFeedUseCase;
  final LocationService locationService;

  /// The place the player picked on the home screen: an area, their own
  /// location, or (by default) all of Egypt. It lasts until they pick another,
  /// so pull-to-refresh keeps showing it.
  String? _chosenCity;
  String? _chosenArea;
  bool _nearMe = false;
  GeoPoint? _position;

  Future<void> fetchFeed({String? city, String? area}) async {
    if (city != null) {
      _chosenCity = city;
      _chosenArea = area;
      _nearMe = false;
    }
    await _load();
  }

  /// Drops the picked area: the feed shows every pitch in Egypt.
  Future<void> showAllEgypt() {
    _chosenCity = null;
    _chosenArea = null;
    _nearMe = false;
    return _load();
  }

  /// Shows pitches around where the player is now. Returns false, leaving the
  /// feed as it was, when location is off or not allowed.
  Future<bool> showNearMe() async {
    final point = await locationService.current(ask: true);
    if (point == null) return false;
    _position = point;
    _nearMe = true;
    _chosenCity = null;
    _chosenArea = null;
    await _load();
    return true;
  }

  Future<void> _load() async {
    if (state is! HomeFeedSuccess) emitIfOpen(const HomeFeedState.loading());
    if (_nearMe) _position = await locationService.current() ?? _position;
    final result = await getHomeFeedUseCase(
      city: _chosenCity,
      area: _chosenArea,
      near: _nearMe ? _position : null,
    );
    result.when(
      success: (located) => emitIfOpen(HomeFeedState.success(located)),
      failure: (failure) => emitIfOpen(HomeFeedState.error(failure.message)),
    );
  }
}
