import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/explore_result_model.dart';

part 'explore_list_state.freezed.dart';

@freezed
sealed class ExploreListState with _$ExploreListState {
  const factory ExploreListState.initial() = ExploreListInitial;
  const factory ExploreListState.loading() = ExploreListLoading;
  const factory ExploreListState.success(ExploreResultModel result) =
      ExploreListSuccess;
  const factory ExploreListState.error(String message) = ExploreListError;
}
