import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/home_feed_model.dart';

part 'home_feed_state.freezed.dart';

@freezed
sealed class HomeFeedState with _$HomeFeedState {
  const factory HomeFeedState.initial() = HomeFeedInitial;
  const factory HomeFeedState.loading() = HomeFeedLoading;
  const factory HomeFeedState.success(HomeFeedModel feed) = HomeFeedSuccess;
  const factory HomeFeedState.error(String message) = HomeFeedError;
}
