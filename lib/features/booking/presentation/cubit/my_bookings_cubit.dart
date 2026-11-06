import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/use_cases/get_my_bookings_use_case.dart';
import 'my_bookings_state.dart';
import 'my_bookings_tab.dart';

class MyBookingsCubit extends Cubit<MyBookingsState>
    with SafeEmitCubitMixin<MyBookingsState> {
  MyBookingsCubit({required this.getMyBookingsUseCase})
    : super(const MyBookingsState.initial());

  static const int pageSize = 10;

  final GetMyBookingsUseCase getMyBookingsUseCase;

  Future<void> load(MyBookingsTab tab) async {
    final current = state;
    if (current is! MyBookingsSuccess || current.tab != tab) {
      emitIfOpen(MyBookingsState.loading(tab));
    }
    final result = await getMyBookingsUseCase(
      tab: tab.query,
      page: 1,
      pageSize: pageSize,
    );
    result.when(
      success: (data) => emitIfOpen(
        MyBookingsState.success(
          tab: tab,
          items: data.items,
          page: data.page,
          hasMore: data.page * data.pageSize < data.totalCount,
        ),
      ),
      failure: (failure) =>
          emitIfOpen(MyBookingsState.error(tab, failure.message)),
    );
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! MyBookingsSuccess ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }
    emitIfOpen(current.copyWith(isLoadingMore: true));
    final result = await getMyBookingsUseCase(
      tab: current.tab.query,
      page: current.page + 1,
      pageSize: pageSize,
    );
    final latest = state;
    if (latest is! MyBookingsSuccess || latest.tab != current.tab) return;
    result.when(
      success: (data) => emitIfOpen(
        latest.copyWith(
          items: [...latest.items, ...data.items],
          page: data.page,
          hasMore: data.page * data.pageSize < data.totalCount,
          isLoadingMore: false,
        ),
      ),
      failure: (_) => emitIfOpen(latest.copyWith(isLoadingMore: false)),
    );
  }
}
