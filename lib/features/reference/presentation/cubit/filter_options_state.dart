import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/filter_options_model.dart';

part 'filter_options_state.freezed.dart';

@freezed
sealed class FilterOptionsState with _$FilterOptionsState {
  const factory FilterOptionsState.loading() = FilterOptionsLoading;
  const factory FilterOptionsState.success(FilterOptionsModel options) =
      FilterOptionsSuccess;
  const factory FilterOptionsState.error(String message) = FilterOptionsError;
}
