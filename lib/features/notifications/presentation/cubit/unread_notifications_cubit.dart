import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/notifications_repo.dart';

/// Unread count for the bell badge; stays at the last known value on failure.
class UnreadNotificationsCubit extends Cubit<int> with SafeEmitCubitMixin<int> {
  UnreadNotificationsCubit({required this.notificationsRepo}) : super(0);

  final NotificationsRepo notificationsRepo;

  Future<void> refresh() async {
    final result = await notificationsRepo.getUnreadCount();
    result.maybeWhen(success: emitIfOpen, orElse: () {});
  }
}
