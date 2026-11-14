import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/location/location_service.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/explore_filter_model.dart';
import '../../domain/use_cases/explore_venues_use_case.dart';
import 'explore_list_state.dart';

class ExploreListCubit extends Cubit<ExploreListState>
    with SafeEmitCubitMixin<ExploreListState> {
  ExploreListCubit({
    required this.exploreVenuesUseCase,
    required this.locationService,
  }) : super(const ExploreListState.initial());

  final ExploreVenuesUseCase exploreVenuesUseCase;
  final LocationService locationService;

  ExploreFilterModel filter = const ExploreFilterModel();

  /// Where the player is, when they allowed it; enables "nearest first".
  GeoPoint? near;

  /// First load: uses the location only if it was already allowed, sorting
  /// nearest first, and never prompts.
  Future<void> start() async {
    near = await locationService.current();
    if (near != null) {
      filter = filter.copyWith(sort: ExploreSortOption.distance);
    }
    await fetchVenues();
  }

  /// "Near me": asks for the location if needed, then sorts nearest first.
  Future<bool> useMyLocation() async {
    final point = await locationService.current(ask: true);
    if (point == null) return false;
    near = point;
    await applyFilter(filter.copyWith(sort: ExploreSortOption.distance));
    return true;
  }

  /// A search asked for from another tab: its day and kick-off hour replace
  /// the current "when", and the other filters the player set are kept.
  Future<void> applyRequest(ExploreFilterModel request) => applyFilter(
    filter.copyWith(
      day: () => request.day,
      startHour: () => request.startHour,
      timeWindow: () => request.startHour == null ? request.timeWindow : null,
    ),
  );

  Future<void> applyFilter(ExploreFilterModel next) {
    filter = next;
    emitIfOpen(const ExploreListState.loading());
    return fetchVenues();
  }

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
      near: near,
      city: city,
      area: area,
      filter: filter,
      page: page,
      pageSize: pageSize,
    );
    result.when(
      success: (data) => emitIfOpen(ExploreListState.success(data)),
      failure: (failure) => emitIfOpen(ExploreListState.error(failure.message)),
    );
  }
}
