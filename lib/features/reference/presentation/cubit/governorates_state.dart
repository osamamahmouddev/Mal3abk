import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/governorate_model.dart';

part 'governorates_state.freezed.dart';

@freezed
sealed class GovernoratesState with _$GovernoratesState {
  const factory GovernoratesState.initial() = GovernoratesInitial;
  const factory GovernoratesState.loading() = GovernoratesLoading;
  const factory GovernoratesState.success(List<GovernorateModel> governorates) =
      GovernoratesSuccess;
  const factory GovernoratesState.error(String message) = GovernoratesError;
}
