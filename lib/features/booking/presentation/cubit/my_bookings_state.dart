import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/player_booking_summary_model.dart';

part 'my_bookings_state.freezed.dart';

@freezed
sealed class MyBookingsState with _$MyBookingsState {
  const factory MyBookingsState.initial() = MyBookingsInitial;
  const factory MyBookingsState.loading() = MyBookingsLoading;
  const factory MyBookingsState.success(PlayerBookingsPagedListModel data) =
      MyBookingsSuccess;
  const factory MyBookingsState.error(String message) = MyBookingsError;
}
