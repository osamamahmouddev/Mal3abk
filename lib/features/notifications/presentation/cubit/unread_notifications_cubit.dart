import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/services/push_notification_service.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/notifications_repo.dart';

/// Unread count for the bell badge; stays at the last known value on failure.
/// A push that arrives while the app is open refreshes it.
class UnreadNotificationsCubit extends Cubit<int> with SafeEmitCubitMixin<int> {
  UnreadNotificationsCubit({
    required this.notificationsRepo,
    Stream<void>? pushes,
  }) : super(0) {
    _pushes = (pushes ?? PushNotificationService.received).listen(
      (_) => refresh(),
    );
  }

  final NotificationsRepo notificationsRepo;
  late final StreamSubscription<void> _pushes;

  Future<void> refresh() async {
    final result = await notificationsRepo.getUnreadCount();
    result.maybeWhen(success: emitIfOpen, orElse: () {});
  }

  @override
  Future<void> close() async {
    await _pushes.cancel();
    return super.close();
  }
}
