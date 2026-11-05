import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/notifications_repo.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState>
    with SafeEmitCubitMixin<NotificationsState> {
  NotificationsCubit({required this.notificationsRepo})
    : super(const NotificationsState.initial());

  final NotificationsRepo notificationsRepo;

  Future<void> load() async {
    if (state is! NotificationsSuccess) {
      emitIfOpen(const NotificationsState.loading());
    }
    final result = await notificationsRepo.getNotifications();
    result.when(
      success: (page) => emitIfOpen(
        NotificationsState.success(
          items: page.items,
          unreadCount: page.unreadCount,
          hasMore: page.hasMore,
          page: page.page,
        ),
      ),
      failure: (failure) =>
          emitIfOpen(NotificationsState.error(failure.message)),
    );
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! NotificationsSuccess ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }
    emitIfOpen(current.copyWith(isLoadingMore: true));
    final result = await notificationsRepo.getNotifications(
      page: current.page + 1,
    );
    result.when(
      success: (page) => emitIfOpen(
        current.copyWith(
          items: [...current.items, ...page.items],
          unreadCount: page.unreadCount,
          hasMore: page.hasMore,
          page: page.page,
          isLoadingMore: false,
        ),
      ),
      failure: (_) => emitIfOpen(current.copyWith(isLoadingMore: false)),
    );
  }

  /// Marks one notification read straight away; the server call is
  /// best-effort and the next refresh reconciles any failure.
  Future<void> markRead(String notificationId) async {
    final current = state;
    if (current is! NotificationsSuccess) return;
    final index = current.items.indexWhere((n) => n.id == notificationId);
    if (index < 0 || current.items[index].isRead) return;
    final items = [...current.items]
      ..[index] = current.items[index].markedRead();
    emitIfOpen(
      current.copyWith(
        items: items,
        unreadCount: (current.unreadCount - 1).clamp(0, current.unreadCount),
      ),
    );
    await notificationsRepo.markRead(notificationId);
  }

  Future<void> markAllRead() async {
    final current = state;
    if (current is! NotificationsSuccess || current.unreadCount == 0) return;
    emitIfOpen(
      current.copyWith(
        items: [for (final n in current.items) n.markedRead()],
        unreadCount: 0,
      ),
    );
    final result = await notificationsRepo.markAllRead();
    if (result is ApiFailure) await load();
  }
}
