import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../notifications/data/apis/notifications_api_service.dart';
import '../../../notifications/data/models/notification_model.dart';

part 'venue_notifications_cubit.freezed.dart';

/// The venue dashboard's notifications (payment proofs, venue status, staff,
/// payouts), kept apart from the player app's.
const int venueNotificationSurface = 1;

@freezed
abstract class VenueNotificationsState with _$VenueNotificationsState {
  const factory VenueNotificationsState({
    @Default([]) List<NotificationModel> items,
    @Default(0) int unreadCount,
    @Default(1) int page,
    @Default(false) bool hasMore,
    @Default(true) bool loading,
    @Default(false) bool loadingMore,
    String? error,
  }) = _VenueNotificationsState;
}

class VenueNotificationsCubit extends Cubit<VenueNotificationsState>
    with SafeEmitCubitMixin<VenueNotificationsState> {
  VenueNotificationsCubit({required this.notificationsApiService})
    : super(const VenueNotificationsState());

  final NotificationsApiService notificationsApiService;

  Future<void> load() async {
    try {
      final page = await notificationsApiService.getNotifications(
        surface: venueNotificationSurface,
      );
      emitIfOpen(
        state.copyWith(
          items: page.items,
          unreadCount: page.unreadCount,
          page: 1,
          hasMore: page.hasMore,
          loading: false,
          error: null,
        ),
      );
    } catch (e, st) {
      emitIfOpen(
        state.copyWith(
          loading: false,
          error: ApiFailureMapper.map(e, st).message,
        ),
      );
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.loadingMore) return;
    emitIfOpen(state.copyWith(loadingMore: true));
    try {
      final page = await notificationsApiService.getNotifications(
        page: state.page + 1,
        surface: venueNotificationSurface,
      );
      emitIfOpen(
        state.copyWith(
          items: [...state.items, ...page.items],
          page: state.page + 1,
          hasMore: page.hasMore,
          loadingMore: false,
        ),
      );
    } catch (_) {
      emitIfOpen(state.copyWith(loadingMore: false));
    }
  }

  Future<void> markRead(NotificationModel n) async {
    if (n.isRead) return;
    try {
      await notificationsApiService.markRead(n.id);
      emitIfOpen(
        state.copyWith(
          items: [
            for (final i in state.items)
              if (i.id == n.id) i.markedRead() else i,
          ],
          unreadCount: (state.unreadCount - 1).clamp(0, 1 << 30),
        ),
      );
    } catch (_) {}
  }

  Future<void> markAllRead() async {
    try {
      await notificationsApiService.markAllRead(
        surface: venueNotificationSurface,
      );
      emitIfOpen(
        state.copyWith(
          items: [for (final i in state.items) i.markedRead()],
          unreadCount: 0,
        ),
      );
    } catch (_) {}
  }

  /// Where a notification leads in the venue app, like the web dashboard.
  static String? targetOf(String type) {
    if (type == 'payment.proof_submitted' ||
        type.startsWith('dispute.') ||
        type.startsWith('booking.')) {
      return 'bookings';
    }
    if (type == 'staff.invitation_accepted') return 'staff';
    if (type == 'payout.recorded') return 'payouts';
    if (type.startsWith('subscription.') || type.startsWith('support.')) {
      return 'overview';
    }
    if (type == 'venue.info_requested' || type == 'venue.rejected') {
      return 'setup';
    }
    if (type == 'venue.approved') return 'overview';
    if (type.startsWith('venue.') || type.startsWith('security.')) {
      return 'settings';
    }
    return null;
  }
}
