import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../venue_calendar/data/models/venue_customer_model.dart';
import '../../data/models/venue_customer_detail_model.dart';
import '../../domain/repos/venue_customers_repo.dart';

part 'venue_customers_cubit.freezed.dart';

enum VenueCustomersFilter { all, regular, noShow }

@freezed
abstract class VenueCustomersState with _$VenueCustomersState {
  const factory VenueCustomersState({
    @Default([]) List<VenueCustomerModel> items,
    @Default(0) int totalCount,
    @Default(1) int page,
    @Default('') String search,
    @Default(VenueCustomersFilter.all) VenueCustomersFilter filter,
    @Default(true) bool loading,
    String? error,
  }) = _VenueCustomersState;
}

extension VenueCustomersStateX on VenueCustomersState {
  /// The filter applies to the page shown, like the web page.
  List<VenueCustomerModel> get visible => [
    for (final c in items)
      if (filter == VenueCustomersFilter.all ||
          (filter == VenueCustomersFilter.regular && c.totalBookings >= 10) ||
          (filter == VenueCustomersFilter.noShow && c.noShows > 0))
        c,
  ];

  int get pages =>
      (totalCount / VenueCustomersCubit.pageSize).ceil().clamp(1, 1 << 30);
}

/// Customers who booked at this venue, only theirs.
class VenueCustomersCubit extends Cubit<VenueCustomersState>
    with SafeEmitCubitMixin<VenueCustomersState> {
  VenueCustomersCubit({
    required this.venueCustomersRepo,
    required this.venueId,
    this.debounce = const Duration(milliseconds: 300),
  }) : super(const VenueCustomersState());

  final VenueCustomersRepo venueCustomersRepo;
  final String venueId;
  final Duration debounce;
  static const int pageSize = 25;
  Timer? _timer;
  int _generation = 0;

  Future<void> load({int? page}) async {
    final generation = ++_generation;
    emitIfOpen(
      state.copyWith(loading: true, error: null, page: page ?? state.page),
    );
    final result = await venueCustomersRepo.getCustomers(
      venueId,
      search: state.search,
      page: state.page,
      pageSize: pageSize,
    );
    if (generation != _generation) return;
    result.when(
      success: (p) => emitIfOpen(
        state.copyWith(
          items: p.items,
          totalCount: p.totalCount,
          loading: false,
        ),
      ),
      failure: (f) =>
          emitIfOpen(state.copyWith(loading: false, error: f.message)),
    );
  }

  void setSearch(String text) {
    _timer?.cancel();
    _timer = Timer(debounce, () {
      emitIfOpen(state.copyWith(search: text.trim()));
      load(page: 1);
    });
  }

  void setFilter(VenueCustomersFilter filter) =>
      emitIfOpen(state.copyWith(filter: filter));

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

/// One customer's profile: numbers, last bookings and staff notes.
class VenueCustomerDetailCubit
    extends Cubit<ApiResult<VenueCustomerDetailModel>?>
    with SafeEmitCubitMixin<ApiResult<VenueCustomerDetailModel>?> {
  VenueCustomerDetailCubit({
    required this.venueCustomersRepo,
    required this.venueId,
    required this.customerKey,
  }) : super(null);

  final VenueCustomersRepo venueCustomersRepo;
  final String venueId;
  final String customerKey;

  Future<void> load() async =>
      emitIfOpen(await venueCustomersRepo.getCustomer(venueId, customerKey));

  /// Returns the failure key, or null once saved.
  Future<String?> addNote(String text) async {
    if (text.trim().isEmpty) return 'venue.customers.note_empty';
    final result = await venueCustomersRepo.addNote(venueId, customerKey, text);
    return result.when(
      success: (_) {
        load();
        return null;
      },
      failure: (f) => f.message,
    );
  }

  Future<String?> deleteNote(String noteId) async {
    final result = await venueCustomersRepo.deleteNote(
      venueId,
      customerKey,
      noteId,
    );
    return result.when(
      success: (_) {
        load();
        return null;
      },
      failure: (f) => f.message,
    );
  }
}
