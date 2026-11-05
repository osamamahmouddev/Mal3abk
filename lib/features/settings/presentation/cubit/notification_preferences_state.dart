import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../notifications/data/models/notification_preference_model.dart';

part 'notification_preferences_state.freezed.dart';

@freezed
sealed class NotificationPreferencesState with _$NotificationPreferencesState {
  const factory NotificationPreferencesState.initial() =
      NotificationPreferencesInitial;
  const factory NotificationPreferencesState.loading() =
      NotificationPreferencesLoading;

  /// [failure] is set once when a change was rolled back.
  const factory NotificationPreferencesState.success(
    List<NotificationPreferenceModel> preferences, {
    String? failure,
  }) = NotificationPreferencesSuccess;
  const factory NotificationPreferencesState.error(String message) =
      NotificationPreferencesError;
}
