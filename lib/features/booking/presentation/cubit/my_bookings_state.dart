import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/player_booking_summary_model.dart';
import 'my_bookings_tab.dart';

part 'my_bookings_state.freezed.dart';

@freezed
sealed class MyBookingsState with _$MyBookingsState {
  const factory MyBookingsState.initial() = MyBookingsInitial;
  const factory MyBookingsState.loading(MyBookingsTab tab) = MyBookingsLoading;
  const factory MyBookingsState.success({
    required MyBookingsTab tab,
    required List<PlayerBookingSummaryModel> items,
    required int page,
    required bool hasMore,
    @Default(false) bool isLoadingMore,
  }) = MyBookingsSuccess;
  const factory MyBookingsState.error(MyBookingsTab tab, String message) =
      MyBookingsError;
}
