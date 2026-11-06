import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/notification_page_model.dart';
import '../models/notification_preference_model.dart';
import '../models/unread_count_model.dart';
import '../models/update_notification_preference_request_body.dart';

part 'notifications_api_service.g.dart';

@RestApi()
abstract class NotificationsApiService {
  factory NotificationsApiService(Dio dio, {String? baseUrl}) =
      _NotificationsApiService;

  @GET(ApiConstants.notifications)
  Future<NotificationPageModel> getNotifications({
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 20,
  });

  @GET(ApiConstants.notificationsUnreadCount)
  Future<UnreadCountModel> getUnreadCount();

  @POST(ApiConstants.notificationRead)
  Future<void> markRead(@Path('id') String notificationId);

  @POST(ApiConstants.notificationsReadAll)
  Future<void> markAllRead();

  @GET(ApiConstants.notificationPreferences)
  Future<List<NotificationPreferenceModel>> getPreferences();

  @PUT(ApiConstants.notificationPreference)
  Future<List<NotificationPreferenceModel>> updatePreference(
    @Path('category') String category,
    @Body() UpdateNotificationPreferenceRequestBody body,
  );
}
