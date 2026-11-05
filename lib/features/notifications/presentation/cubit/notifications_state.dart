import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/notification_model.dart';

part 'notifications_state.freezed.dart';

@freezed
sealed class NotificationsState with _$NotificationsState {
  const factory NotificationsState.initial() = NotificationsInitial;
  const factory NotificationsState.loading() = NotificationsLoading;
  const factory NotificationsState.success({
    required List<NotificationModel> items,
    required int unreadCount,
    required bool hasMore,
    required int page,
    @Default(false) bool isLoadingMore,
  }) = NotificationsSuccess;
  const factory NotificationsState.error(String message) = NotificationsError;
}
