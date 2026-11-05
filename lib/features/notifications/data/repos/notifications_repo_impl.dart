import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/notifications_repo.dart';
import '../apis/notifications_api_service.dart';
import '../models/notification_page_model.dart';
import '../models/notification_preference_model.dart';
import '../models/update_notification_preference_request_body.dart';

class NotificationsRepoImpl implements NotificationsRepo {
  NotificationsRepoImpl({required this.notificationsApiService});

  final NotificationsApiService notificationsApiService;

  Future<ApiResult<T>> _guard<T>(Future<T> Function() call) async {
    try {
      return ApiResult.success(await call());
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<NotificationPageModel>> getNotifications({int page = 1}) =>
      _guard(() => notificationsApiService.getNotifications(page: page));

  @override
  Future<ApiResult<int>> getUnreadCount() => _guard(
    () async => (await notificationsApiService.getUnreadCount()).unreadCount,
  );

  @override
  Future<ApiResult<void>> markRead(String notificationId) =>
      _guard(() => notificationsApiService.markRead(notificationId));

  @override
  Future<ApiResult<void>> markAllRead() =>
      _guard(notificationsApiService.markAllRead);

  @override
  Future<ApiResult<List<NotificationPreferenceModel>>> getPreferences() =>
      _guard(notificationsApiService.getPreferences);

  @override
  Future<ApiResult<List<NotificationPreferenceModel>>> updatePreference(
    String category, {
    required bool inAppEnabled,
    required bool pushEnabled,
  }) => _guard(
    () => notificationsApiService.updatePreference(
      category,
      UpdateNotificationPreferenceRequestBody(
        inAppEnabled: inAppEnabled,
        pushEnabled: pushEnabled,
      ),
    ),
  );
}
