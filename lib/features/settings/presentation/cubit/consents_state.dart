import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/consents_model.dart';

part 'consents_state.freezed.dart';

@freezed
sealed class ConsentsState with _$ConsentsState {
  const factory ConsentsState.initial() = ConsentsInitial;
  const factory ConsentsState.loading() = ConsentsLoading;

  /// [failure] is set once when a change was rolled back.
  const factory ConsentsState.success(
    ConsentsModel consents, {
    String? failure,
  }) = ConsentsSuccess;
  const factory ConsentsState.error(String message) = ConsentsError;
}
