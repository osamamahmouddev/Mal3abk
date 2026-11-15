import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_constants.dart';
import '../models/notification_page_model.dart';
import '../models/notification_preference_model.dart';
import '../models/unread_count_model.dart';
import '../models/update_notification_preference_request_body.dart';

part 'notifications_api_service.g.dart';

/// The player app's own notifications (bookings, teams, matches) plus the account-wide ones (security, support). One
/// account can also work at a venue; the API keeps those notifications for the venue dashboard.
const int playerNotificationSurface = 0;

@RestApi()
abstract class NotificationsApiService {
  factory NotificationsApiService(Dio dio, {String? baseUrl}) =
      _NotificationsApiService;

  @GET(ApiConstants.notifications)
  Future<NotificationPageModel> getNotifications({
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 20,
    @Query('surface') int surface = playerNotificationSurface,
  });

  @GET(ApiConstants.notificationsUnreadCount)
  Future<UnreadCountModel> getUnreadCount({
    @Query('surface') int surface = playerNotificationSurface,
  });

  @POST(ApiConstants.notificationRead)
  Future<void> markRead(@Path('id') String notificationId);

  @POST(ApiConstants.notificationsReadAll)
  Future<void> markAllRead({
    @Query('surface') int surface = playerNotificationSurface,
  });

  @GET(ApiConstants.notificationPreferences)
  Future<List<NotificationPreferenceModel>> getPreferences();

  @PUT(ApiConstants.notificationPreference)
  Future<List<NotificationPreferenceModel>> updatePreference(
    @Path('category') String category,
    @Body() UpdateNotificationPreferenceRequestBody body,
  );

  @POST(ApiConstants.registerPushToken)
  Future<void> registerPushToken(@Body() Map<String, dynamic> body);

  @DELETE(ApiConstants.unregisterPushToken)
  Future<void> unregisterPushToken(@Body() Map<String, dynamic> body);
}
