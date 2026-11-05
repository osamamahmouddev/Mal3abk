import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../notifications/data/models/notification_preference_model.dart';
import '../../../notifications/domain/repos/notifications_repo.dart';
import 'notification_preferences_state.dart';

class NotificationPreferencesCubit extends Cubit<NotificationPreferencesState>
    with SafeEmitCubitMixin<NotificationPreferencesState> {
  NotificationPreferencesCubit({required this.notificationsRepo})
    : super(const NotificationPreferencesState.initial());

  /// Categories a player sees; venue alerts belong to owners and marketing
  /// follows the marketing consent.
  static const Set<String> playerCategories = {
    'Bookings',
    'Payments',
    'Teams',
    'Security',
  };

  final NotificationsRepo notificationsRepo;

  Future<void> load() async {
    emitIfOpen(const NotificationPreferencesState.loading());
    final result = await notificationsRepo.getPreferences();
    result.when(
      success: (all) =>
          emitIfOpen(NotificationPreferencesState.success(_forPlayer(all))),
      failure: (failure) =>
          emitIfOpen(NotificationPreferencesState.error(failure.message)),
    );
  }

  Future<void> toggle(String category, {required bool enabled}) async {
    final current = state;
    if (current is! NotificationPreferencesSuccess) return;
    final previous = current.preferences;
    final target = previous.where((p) => p.category == category).firstOrNull;
    if (target == null || !target.canDisable) return;

    emitIfOpen(
      NotificationPreferencesState.success([
        for (final p in previous)
          p.category == category
              ? NotificationPreferenceModel(
                  category: p.category,
                  inAppEnabled: enabled,
                  pushEnabled: enabled,
                  canDisable: p.canDisable,
                )
              : p,
      ]),
    );
    final result = await notificationsRepo.updatePreference(
      category,
      inAppEnabled: enabled,
      pushEnabled: enabled,
    );
    result.when(
      success: (all) =>
          emitIfOpen(NotificationPreferencesState.success(_forPlayer(all))),
      failure: (failure) => emitIfOpen(
        NotificationPreferencesState.success(
          previous,
          failure: failure.message,
        ),
      ),
    );
  }

  List<NotificationPreferenceModel> _forPlayer(
    List<NotificationPreferenceModel> all,
  ) => all
      .where((p) => playerCategories.contains(p.category))
      .toList(growable: false);
}
