import '../../../../core/network/api_result.dart';
import '../../data/models/notification_page_model.dart';
import '../../data/models/notification_preference_model.dart';

abstract class NotificationsRepo {
  Future<ApiResult<NotificationPageModel>> getNotifications({int page = 1});

  Future<ApiResult<int>> getUnreadCount();

  Future<ApiResult<void>> markRead(String notificationId);

  Future<ApiResult<void>> markAllRead();

  Future<ApiResult<List<NotificationPreferenceModel>>> getPreferences();

  Future<ApiResult<List<NotificationPreferenceModel>>> updatePreference(
    String category, {
    required bool inAppEnabled,
    required bool pushEnabled,
  });
}
