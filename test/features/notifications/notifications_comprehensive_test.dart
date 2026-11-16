import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/core/styles/app_colors.dart';
import 'package:mal3abk/features/notifications/data/apis/notifications_api_service.dart';
import 'package:mal3abk/features/notifications/data/models/notification_model.dart';
import 'package:mal3abk/features/notifications/data/models/notification_page_model.dart';
import 'package:mal3abk/features/notifications/data/models/notification_preference_model.dart';
import 'package:mal3abk/features/notifications/data/models/unread_count_model.dart';
import 'package:mal3abk/features/notifications/data/models/update_notification_preference_request_body.dart';
import 'package:mal3abk/features/notifications/data/repos/notifications_repo_impl.dart';
import 'package:mal3abk/features/notifications/domain/repos/notifications_repo.dart';
import 'package:mal3abk/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:mal3abk/features/notifications/presentation/cubit/notifications_state.dart';
import 'package:mal3abk/features/notifications/presentation/cubit/unread_notifications_cubit.dart';
import 'package:mal3abk/features/notifications/presentation/widgets/notification_category_icon.dart';

class MockNotificationsApiService extends Mock implements NotificationsApiService {}
class MockNotificationsRepo extends Mock implements NotificationsRepo {}

void main() {
  setUpAll(() {
    registerFallbackValue(const UpdateNotificationPreferenceRequestBody(
      inAppEnabled: true,
      pushEnabled: true,
    ));
  });

  group('NotificationModel Tests', () {
    test('1. fromJson parses complete notification model', () {
      final json = {
        'id': 'notif-1',
        'type': 'BookingConfirmed',
        'category': 'Bookings',
        'title': 'تم تأكيد حجزك',
        'body': 'حجزك في ملعب النجوم مؤكد',
        'deepLink': 'mal3abk://bookings/123',
        'isRead': false,
        'createdAtUtc': '2026-05-01T12:00:00Z',
      };
      final model = NotificationModel.fromJson(json);
      expect(model.id, 'notif-1');
      expect(model.type, 'BookingConfirmed');
      expect(model.category, 'Bookings');
      expect(model.title, 'تم تأكيد حجزك');
      expect(model.body, 'حجزك في ملعب النجوم مؤكد');
      expect(model.deepLink, 'mal3abk://bookings/123');
      expect(model.isRead, isFalse);
      expect(model.createdAtUtc, DateTime.utc(2026, 5, 1, 12));
    });

    test('2. toJson serializes all fields correctly', () {
      final model = NotificationModel(
        id: 'notif-2',
        type: 'TeamChallenge',
        category: 'Teams',
        title: 'New Challenge',
        body: 'Team Falcons challenged you',
        deepLink: null,
        isRead: true,
        createdAtUtc: DateTime.utc(2026, 5, 2, 10),
      );
      final json = model.toJson();
      expect(json['id'], 'notif-2');
      expect(json['deepLink'], isNull);
      expect(json['isRead'], isTrue);
    });

    test('3. markedRead returns new instance with isRead true and preserves other fields', () {
      final model = NotificationModel(
        id: 'notif-3',
        type: 'MatchResult',
        category: 'Teams',
        title: 'نتيجة المباراة',
        body: 'سجل النتيجة الآن',
        deepLink: 'mal3abk://matches/456',
        isRead: false,
        createdAtUtc: DateTime.utc(2026, 5, 3),
      );
      final read = model.markedRead();
      expect(read.isRead, isTrue);
      expect(read.id, model.id);
      expect(read.type, model.type);
      expect(read.category, model.category);
      expect(read.title, model.title);
      expect(read.body, model.body);
      expect(read.deepLink, model.deepLink);
      expect(read.createdAtUtc, model.createdAtUtc);
    });

    test('4. markedRead on already read notification remains read', () {
      final model = NotificationModel(
        id: 'notif-4',
        type: 'General',
        category: 'Venues',
        title: 'T',
        body: 'B',
        isRead: true,
        createdAtUtc: DateTime.utc(2026, 5, 4),
      );
      expect(model.markedRead().isRead, isTrue);
    });

    test('5. NotificationModel handles null deepLink in fromJson', () {
      final json = {
        'id': 'notif-5',
        'type': 'Security',
        'category': 'Security',
        'title': 'Security Alert',
        'body': 'New login from Chrome',
        'isRead': false,
        'createdAtUtc': '2026-05-01T00:00:00Z',
      };
      final model = NotificationModel.fromJson(json);
      expect(model.deepLink, isNull);
    });
  });

  group('NotificationPageModel Tests', () {
    test('6. fromJson parses page model with items', () {
      final json = {
        'items': [
          {
            'id': 'n-1',
            'type': 'T',
            'category': 'Bookings',
            'title': 'Title',
            'body': 'Body',
            'isRead': false,
            'createdAtUtc': '2026-05-01T00:00:00Z',
          }
        ],
        'page': 1,
        'pageSize': 10,
        'totalCount': 25,
        'unreadCount': 5,
      };
      final page = NotificationPageModel.fromJson(json);
      expect(page.items.length, 1);
      expect(page.page, 1);
      expect(page.pageSize, 10);
      expect(page.totalCount, 25);
      expect(page.unreadCount, 5);
      expect(page.hasMore, isTrue);
    });

    test('7. hasMore is false when page * pageSize >= totalCount', () {
      const page = NotificationPageModel(
        items: [],
        page: 3,
        pageSize: 10,
        totalCount: 25,
        unreadCount: 0,
      );
      expect(page.hasMore, isFalse);
    });

    test('8. hasMore is false when page * pageSize == totalCount', () {
      const page = NotificationPageModel(
        items: [],
        page: 2,
        pageSize: 10,
        totalCount: 20,
        unreadCount: 0,
      );
      expect(page.hasMore, isFalse);
    });

    test('9. hasMore is false when totalCount is 0', () {
      const page = NotificationPageModel(
        items: [],
        page: 1,
        pageSize: 10,
        totalCount: 0,
        unreadCount: 0,
      );
      expect(page.hasMore, isFalse);
    });

    test('10. fromJson defaults items to empty list if missing', () {
      final json = {
        'page': 1,
        'pageSize': 10,
        'totalCount': 0,
        'unreadCount': 0,
      };
      final page = NotificationPageModel.fromJson(json);
      expect(page.items, isEmpty);
    });

    test('11. toJson serializes all page fields properly', () {
      const page = NotificationPageModel(
        items: [],
        page: 1,
        pageSize: 20,
        totalCount: 0,
        unreadCount: 0,
      );
      final json = page.toJson();
      expect(json['page'], 1);
      expect(json['pageSize'], 20);
    });
  });

  group('UnreadCountModel & Preferences Models Tests', () {
    test('12. UnreadCountModel fromJson and toJson with zero', () {
      final json = {'unreadCount': 0};
      final model = UnreadCountModel.fromJson(json);
      expect(model.unreadCount, 0);
      expect(model.toJson()['unreadCount'], 0);
    });

    test('13. UnreadCountModel fromJson with positive count', () {
      final json = {'unreadCount': 17};
      final model = UnreadCountModel.fromJson(json);
      expect(model.unreadCount, 17);
    });

    test('14. NotificationPreferenceModel fromJson and toJson', () {
      final json = {
        'category': 'Bookings',
        'inAppEnabled': true,
        'pushEnabled': true,
        'canDisable': true,
      };
      final model = NotificationPreferenceModel.fromJson(json);
      expect(model.category, 'Bookings');
      expect(model.inAppEnabled, isTrue);
      expect(model.pushEnabled, isTrue);
      expect(model.canDisable, isTrue);
      expect(model.toJson()['category'], 'Bookings');
    });

    test('15. NotificationPreferenceModel non-disableable category', () {
      final json = {
        'category': 'Security',
        'inAppEnabled': true,
        'pushEnabled': true,
        'canDisable': false,
      };
      final model = NotificationPreferenceModel.fromJson(json);
      expect(model.canDisable, isFalse);
    });

    test('16. UpdateNotificationPreferenceRequestBody fromJson and toJson', () {
      final json = {'inAppEnabled': false, 'pushEnabled': true};
      final body = UpdateNotificationPreferenceRequestBody.fromJson(json);
      expect(body.inAppEnabled, isFalse);
      expect(body.pushEnabled, isTrue);
      expect(body.toJson()['inAppEnabled'], isFalse);
      expect(body.toJson()['pushEnabled'], isTrue);
    });
  });

  group('NotificationCategoryIcon Mapping Tests', () {
    test('17. Bookings category returns event icon and green color', () {
      final (icon, color) = NotificationCategoryIcon.of('Bookings');
      expect(icon, Icons.event_available_rounded);
      expect(color, AppColors.successGreen);
    });

    test('18. Payments category returns receipt icon and gold color', () {
      final (icon, color) = NotificationCategoryIcon.of('Payments');
      expect(icon, Icons.receipt_long_rounded);
      expect(color, AppColors.goldDark);
    });

    test('19. Teams category returns soccer icon and navy color', () {
      final (icon, color) = NotificationCategoryIcon.of('Teams');
      expect(icon, Icons.sports_soccer_rounded);
      expect(color, AppColors.brandNavy);
    });

    test('20. Security category returns shield icon and red color', () {
      final (icon, color) = NotificationCategoryIcon.of('Security');
      expect(icon, Icons.shield_rounded);
      expect(color, AppColors.brandRed);
    });

    test('21. Venues category returns stadium icon and navy color', () {
      final (icon, color) = NotificationCategoryIcon.of('Venues');
      expect(icon, Icons.stadium_rounded);
      expect(color, AppColors.brandNavy);
    });

    test('22. Unknown category falls back to bell icon and offlineBanner color', () {
      final (icon, color) = NotificationCategoryIcon.of('AnyOtherUnknown');
      expect(icon, Icons.notifications_rounded);
      expect(color, AppColors.offlineBanner);
    });
  });

  group('NotificationsRepoImpl Comprehensive Tests', () {
    late MockNotificationsApiService mockApi;
    late NotificationsRepoImpl repo;

    setUp(() {
      mockApi = MockNotificationsApiService();
      repo = NotificationsRepoImpl(notificationsApiService: mockApi);
    });

    test('23. getNotifications calls api and returns success', () async {
      const pageModel = NotificationPageModel(
        items: [],
        page: 1,
        pageSize: 10,
        totalCount: 0,
        unreadCount: 0,
      );
      when(() => mockApi.getNotifications(page: 1)).thenAnswer((_) async => pageModel);

      final res = await repo.getNotifications(page: 1);
      expect(res, isA<Success<NotificationPageModel>>());
      expect((res as Success<NotificationPageModel>).data, pageModel);
      verify(() => mockApi.getNotifications(page: 1)).called(1);
    });

    test('24. getNotifications maps DioException to failure', () async {
      when(() => mockApi.getNotifications(page: 1)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/notifications'),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: '/notifications'),
          ),
        ),
      );

      final res = await repo.getNotifications(page: 1);
      expect(res, isA<ApiFailure>());
    });

    test('25. getUnreadCount extracts unreadCount integer successfully', () async {
      when(() => mockApi.getUnreadCount()).thenAnswer((_) async => const UnreadCountModel(unreadCount: 8));

      final res = await repo.getUnreadCount();
      expect(res, isA<Success<int>>());
      expect((res as Success<int>).data, 8);
      verify(() => mockApi.getUnreadCount()).called(1);
    });

    test('26. getUnreadCount handles server error', () async {
      when(() => mockApi.getUnreadCount()).thenThrow(Exception('Server error'));

      final res = await repo.getUnreadCount();
      expect(res, isA<ApiFailure>());
    });

    test('27. markRead calls api with notificationId', () async {
      when(() => mockApi.markRead('notif-99')).thenAnswer((_) async {});

      final res = await repo.markRead('notif-99');
      expect(res, isA<Success<void>>());
      verify(() => mockApi.markRead('notif-99')).called(1);
    });

    test('28. markRead handles failure', () async {
      when(() => mockApi.markRead('notif-99')).thenThrow(Exception('Fail'));

      final res = await repo.markRead('notif-99');
      expect(res, isA<ApiFailure>());
    });

    test('29. markAllRead calls api successfully', () async {
      when(() => mockApi.markAllRead()).thenAnswer((_) async {});

      final res = await repo.markAllRead();
      expect(res, isA<Success<void>>());
      verify(() => mockApi.markAllRead()).called(1);
    });

    test('30. markAllRead handles failure', () async {
      when(() => mockApi.markAllRead()).thenThrow(Exception('Fail'));

      final res = await repo.markAllRead();
      expect(res, isA<ApiFailure>());
    });

    test('31. getPreferences calls api and returns list', () async {
      const prefs = [
        NotificationPreferenceModel(
          category: 'Bookings',
          inAppEnabled: true,
          pushEnabled: true,
          canDisable: true,
        )
      ];
      when(() => mockApi.getPreferences()).thenAnswer((_) async => prefs);

      final res = await repo.getPreferences();
      expect(res, isA<Success<List<NotificationPreferenceModel>>>());
      expect((res as Success<List<NotificationPreferenceModel>>).data, prefs);
      verify(() => mockApi.getPreferences()).called(1);
    });

    test('32. updatePreference passes body and category to api', () async {
      const updatedList = [
        NotificationPreferenceModel(
          category: 'Bookings',
          inAppEnabled: false,
          pushEnabled: false,
          canDisable: true,
        )
      ];
      when(() => mockApi.updatePreference(any(), any())).thenAnswer((_) async => updatedList);

      final res = await repo.updatePreference('Bookings', inAppEnabled: false, pushEnabled: false);
      expect(res, isA<Success<List<NotificationPreferenceModel>>>());
      expect((res as Success<List<NotificationPreferenceModel>>).data, updatedList);
      verify(() => mockApi.updatePreference(
            'Bookings',
            any(that: isA<UpdateNotificationPreferenceRequestBody>()),
          )).called(1);
    });
  });

  group('NotificationsCubit Comprehensive Tests', () {
    late MockNotificationsRepo mockRepo;

    final n1 = NotificationModel(
      id: 'n-1',
      type: 'T',
      category: 'Bookings',
      title: 'T1',
      body: 'B1',
      isRead: false,
      createdAtUtc: DateTime.utc(2026, 5, 1),
    );

    final n2 = NotificationModel(
      id: 'n-2',
      type: 'T',
      category: 'Teams',
      title: 'T2',
      body: 'B2',
      isRead: false,
      createdAtUtc: DateTime.utc(2026, 5, 2),
    );

    setUp(() {
      mockRepo = MockNotificationsRepo();
    });

    test('33. Initial state is NotificationsState.initial()', () {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      expect(cubit.state, const NotificationsState.initial());
      cubit.close();
    });

    test('34. load emits [loading, success]', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final pageModel = NotificationPageModel(
        items: [n1],
        page: 1,
        pageSize: 10,
        totalCount: 1,
        unreadCount: 1,
      );
      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(pageModel));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const NotificationsState.loading(),
          NotificationsState.success(
            items: [n1],
            unreadCount: 1,
            hasMore: false,
            page: 1,
          ),
        ]),
      );

      await cubit.load();
      cubit.close();
    });

    test('35. load emits [loading, error] on failure', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      when(() => mockRepo.getNotifications(page: 1))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.server')));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const NotificationsState.loading(),
          const NotificationsState.error('errors.server'),
        ]),
      );

      await cubit.load();
      cubit.close();
    });

    test('36. refresh does not emit loading if state is already success', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final pageModel = NotificationPageModel(
        items: [n1],
        page: 1,
        pageSize: 10,
        totalCount: 1,
        unreadCount: 1,
      );
      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(pageModel));

      await cubit.load();
      expect(cubit.state, isA<NotificationsSuccess>());

      final states = <NotificationsState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.load();
      expect(states.whereType<NotificationsLoading>(), isEmpty);
      await sub.cancel();
      cubit.close();
    });

    test('37. loadMore returns early if state is not success', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      await cubit.loadMore();
      expect(cubit.state, const NotificationsState.initial());
      verifyNever(() => mockRepo.getNotifications(page: any(named: 'page')));
      cubit.close();
    });

    test('38. loadMore returns early if hasMore is false', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final pageModel = NotificationPageModel(
        items: [n1],
        page: 1,
        pageSize: 10,
        totalCount: 1,
        unreadCount: 1,
      );
      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(pageModel));

      await cubit.load();
      await cubit.loadMore();

      verify(() => mockRepo.getNotifications(page: 1)).called(1);
      verifyNever(() => mockRepo.getNotifications(page: 2));
      cubit.close();
    });

    test('39. loadMore appends items and increments page', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final page1 = NotificationPageModel(
        items: [n1],
        page: 1,
        pageSize: 1,
        totalCount: 2,
        unreadCount: 2,
      );
      final page2 = NotificationPageModel(
        items: [n2],
        page: 2,
        pageSize: 1,
        totalCount: 2,
        unreadCount: 2,
      );

      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(page1));
      when(() => mockRepo.getNotifications(page: 2)).thenAnswer((_) async => ApiResult.success(page2));

      await cubit.load();
      await cubit.loadMore();

      final state = cubit.state as NotificationsSuccess;
      expect(state.items.length, 2);
      expect(state.items.map((n) => n.id), ['n-1', 'n-2']);
      expect(state.page, 2);
      expect(state.hasMore, isFalse);
      cubit.close();
    });

    test('40. loadMore handles failure gracefully and resets isLoadingMore', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final page1 = NotificationPageModel(
        items: [n1],
        page: 1,
        pageSize: 1,
        totalCount: 2,
        unreadCount: 1,
      );

      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(page1));
      when(() => mockRepo.getNotifications(page: 2))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.timeout')));

      await cubit.load();
      await cubit.loadMore();

      final state = cubit.state as NotificationsSuccess;
      expect(state.items.length, 1);
      expect(state.isLoadingMore, isFalse);
      cubit.close();
    });

    test('41. markRead marks target notification read and decrements unreadCount', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final page1 = NotificationPageModel(
        items: [n1, n2],
        page: 1,
        pageSize: 10,
        totalCount: 2,
        unreadCount: 2,
      );

      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(page1));
      when(() => mockRepo.markRead('n-1')).thenAnswer((_) async => const ApiResult.success(null));

      await cubit.load();
      await cubit.markRead('n-1');

      final state = cubit.state as NotificationsSuccess;
      expect(state.items.first.isRead, isTrue);
      expect(state.items.last.isRead, isFalse);
      expect(state.unreadCount, 1);
      verify(() => mockRepo.markRead('n-1')).called(1);
      cubit.close();
    });

    test('42. markRead does nothing if notificationId not found', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final page1 = NotificationPageModel(
        items: [n1],
        page: 1,
        pageSize: 10,
        totalCount: 1,
        unreadCount: 1,
      );

      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(page1));

      await cubit.load();
      await cubit.markRead('non-existent');

      final state = cubit.state as NotificationsSuccess;
      expect(state.unreadCount, 1);
      verifyNever(() => mockRepo.markRead(any()));
      cubit.close();
    });

    test('43. markRead does nothing if notification is already read', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final readNotification = n1.markedRead();
      final page1 = NotificationPageModel(
        items: [readNotification],
        page: 1,
        pageSize: 10,
        totalCount: 1,
        unreadCount: 0,
      );

      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(page1));

      await cubit.load();
      await cubit.markRead('n-1');

      verifyNever(() => mockRepo.markRead(any()));
      cubit.close();
    });

    test('44. markRead clamps unreadCount to 0', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      // unreadCount was somehow 0 even though item was unread
      final page1 = NotificationPageModel(
        items: [n1],
        page: 1,
        pageSize: 10,
        totalCount: 1,
        unreadCount: 0,
      );

      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(page1));
      when(() => mockRepo.markRead('n-1')).thenAnswer((_) async => const ApiResult.success(null));

      await cubit.load();
      await cubit.markRead('n-1');

      final state = cubit.state as NotificationsSuccess;
      expect(state.unreadCount, 0);
      cubit.close();
    });

    test('45. markAllRead sets all items to isRead true and unreadCount to 0', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final page1 = NotificationPageModel(
        items: [n1, n2],
        page: 1,
        pageSize: 10,
        totalCount: 2,
        unreadCount: 2,
      );

      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(page1));
      when(() => mockRepo.markAllRead()).thenAnswer((_) async => const ApiResult.success(null));

      await cubit.load();
      await cubit.markAllRead();

      final state = cubit.state as NotificationsSuccess;
      expect(state.items.every((n) => n.isRead), isTrue);
      expect(state.unreadCount, 0);
      verify(() => mockRepo.markAllRead()).called(1);
      cubit.close();
    });

    test('46. markAllRead does nothing if unreadCount is already 0', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final page1 = NotificationPageModel(
        items: [n1.markedRead()],
        page: 1,
        pageSize: 10,
        totalCount: 1,
        unreadCount: 0,
      );

      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(page1));

      await cubit.load();
      await cubit.markAllRead();

      verifyNever(() => mockRepo.markAllRead());
      cubit.close();
    });

    test('47. markAllRead reloads from repo when markAllRead fails', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final page1 = NotificationPageModel(
        items: [n1],
        page: 1,
        pageSize: 10,
        totalCount: 1,
        unreadCount: 1,
      );

      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(page1));
      when(() => mockRepo.markAllRead())
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.server')));

      await cubit.load();
      await cubit.markAllRead();

      // verify load was triggered again to reconcile state
      verify(() => mockRepo.getNotifications(page: 1)).called(2);
      cubit.close();
    });
  });

  group('UnreadNotificationsCubit Tests', () {
    late MockNotificationsRepo mockRepo;

    setUp(() {
      mockRepo = MockNotificationsRepo();
    });

    test('48. Initial state is 0', () {
      final cubit = UnreadNotificationsCubit(notificationsRepo: mockRepo);
      expect(cubit.state, 0);
      cubit.close();
    });

    test('49. refresh updates state on success', () async {
      final cubit = UnreadNotificationsCubit(notificationsRepo: mockRepo);
      when(() => mockRepo.getUnreadCount()).thenAnswer((_) async => const ApiResult.success(5));

      await cubit.refresh();
      expect(cubit.state, 5);
      cubit.close();
    });

    test('50. refresh preserves current count on failure', () async {
      final cubit = UnreadNotificationsCubit(notificationsRepo: mockRepo);
      when(() => mockRepo.getUnreadCount()).thenAnswer((_) async => const ApiResult.success(3));
      await cubit.refresh();
      expect(cubit.state, 3);

      when(() => mockRepo.getUnreadCount())
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'err')));
      await cubit.refresh();
      expect(cubit.state, 3);
      cubit.close();
    });

    test('51. multiple sequential refreshes reflect updated counts', () async {
      final cubit = UnreadNotificationsCubit(notificationsRepo: mockRepo);
      when(() => mockRepo.getUnreadCount()).thenAnswer((_) async => const ApiResult.success(10));
      await cubit.refresh();
      expect(cubit.state, 10);

      when(() => mockRepo.getUnreadCount()).thenAnswer((_) async => const ApiResult.success(0));
      await cubit.refresh();
      expect(cubit.state, 0);
      cubit.close();
    });
  });

  group('Notification State CopyWith & Edge Cases', () {
    late MockNotificationsRepo mockRepo;
    late MockNotificationsApiService mockApi;
    late NotificationsRepoImpl repo;

    setUp(() {
      mockRepo = MockNotificationsRepo();
      mockApi = MockNotificationsApiService();
      repo = NotificationsRepoImpl(notificationsApiService: mockApi);
    });

    test('52. NotificationsSuccess copyWith partial updates', () {
      const state = NotificationsSuccess(
        items: [],
        unreadCount: 2,
        hasMore: true,
        page: 1,
        isLoadingMore: false,
      );

      final updated = state.copyWith(isLoadingMore: true);
      expect(updated.isLoadingMore, isTrue);
      expect(updated.unreadCount, 2);
      expect(updated.hasMore, isTrue);
      expect(updated.page, 1);
    });

    test('53. NotificationsSuccess copyWith items and unreadCount', () {
      const state = NotificationsSuccess(
        items: [],
        unreadCount: 5,
        hasMore: false,
        page: 1,
      );

      final updated = state.copyWith(unreadCount: 0);
      expect(updated.unreadCount, 0);
      expect(updated.items, isEmpty);
    });

    test('54. NotificationPreferenceModel copyWith like equality', () {
      const p1 = NotificationPreferenceModel(
        category: 'Teams',
        inAppEnabled: true,
        pushEnabled: false,
        canDisable: true,
      );
      expect(p1.category, 'Teams');
      expect(p1.inAppEnabled, isTrue);
      expect(p1.pushEnabled, isFalse);
      expect(p1.canDisable, isTrue);
    });

    test('55. NotificationsInitial state equality', () {
      const s1 = NotificationsInitial();
      const s2 = NotificationsInitial();
      expect(s1, equals(s2));
    });

    test('56. NotificationsLoading state equality', () {
      const s1 = NotificationsLoading();
      const s2 = NotificationsLoading();
      expect(s1, equals(s2));
    });

    test('57. NotificationsError state message', () {
      const err = NotificationsError('common.network_error');
      expect(err.message, 'common.network_error');
    });

    test('58. NotificationPageModel hasMore when totalCount exceeds page * pageSize by 1', () {
      const page = NotificationPageModel(
        items: [],
        page: 1,
        pageSize: 10,
        totalCount: 11,
        unreadCount: 0,
      );
      expect(page.hasMore, isTrue);
    });

    test('59. NotificationPageModel hasMore when page is 0', () {
      const page = NotificationPageModel(
        items: [],
        page: 0,
        pageSize: 10,
        totalCount: 1,
        unreadCount: 0,
      );
      expect(page.hasMore, isTrue);
    });

    test('60. NotificationModel date formatting UTC', () {
      final now = DateTime.utc(2026, 12, 25, 18, 30);
      final model = NotificationModel(
        id: 'x',
        type: 'General',
        category: 'System',
        title: 'Title',
        body: 'Body',
        isRead: false,
        createdAtUtc: now,
      );
      expect(model.createdAtUtc.isUtc, isTrue);
      expect(model.createdAtUtc.year, 2026);
      expect(model.createdAtUtc.month, 12);
      expect(model.createdAtUtc.day, 25);
    });

    test('61. NotificationModel multiple markedRead chains preserve immutability', () {
      final orig = NotificationModel(
        id: 'c1',
        type: 'T',
        category: 'C',
        title: 'T',
        body: 'B',
        isRead: false,
        createdAtUtc: DateTime.utc(2026, 1, 1),
      );
      final r1 = orig.markedRead();
      final r2 = r1.markedRead();
      expect(orig.isRead, isFalse);
      expect(r1.isRead, isTrue);
      expect(r2.isRead, isTrue);
    });

    test('62. UpdateNotificationPreferenceRequestBody both true', () {
      const b = UpdateNotificationPreferenceRequestBody(inAppEnabled: true, pushEnabled: true);
      expect(b.inAppEnabled, isTrue);
      expect(b.pushEnabled, isTrue);
    });

    test('63. UpdateNotificationPreferenceRequestBody both false', () {
      const b = UpdateNotificationPreferenceRequestBody(inAppEnabled: false, pushEnabled: false);
      expect(b.inAppEnabled, isFalse);
      expect(b.pushEnabled, isFalse);
    });

    test('64. NotificationsCubit loadMore does nothing if already loading more', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final page1 = NotificationPageModel(
        items: [
          NotificationModel(
            id: '1',
            type: 'T',
            category: 'C',
            title: 'T',
            body: 'B',
            isRead: false,
            createdAtUtc: DateTime.utc(2026, 1, 1),
          )
        ],
        page: 1,
        pageSize: 1,
        totalCount: 5,
        unreadCount: 1,
      );
      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(page1));

      await cubit.load();
      // Emulate loading more already underway by emitting isLoadingMore: true
      cubit.emitIfOpen((cubit.state as NotificationsSuccess).copyWith(isLoadingMore: true));

      await cubit.loadMore();
      // Should not call page 2 because isLoadingMore is true
      verifyNever(() => mockRepo.getNotifications(page: 2));
      cubit.close();
    });

    test('65. NotificationsCubit markRead returns early when state is not success', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      await cubit.markRead('1');
      expect(cubit.state, const NotificationsState.initial());
      verifyNever(() => mockRepo.markRead(any()));
      cubit.close();
    });

    test('66. NotificationsCubit markAllRead returns early when state is not success', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      await cubit.markAllRead();
      expect(cubit.state, const NotificationsState.initial());
      verifyNever(() => mockRepo.markAllRead());
      cubit.close();
    });

    test('67. NotificationCategoryIcon with null or empty string returns default', () {
      final (icon, color) = NotificationCategoryIcon.of('');
      expect(icon, Icons.notifications_rounded);
      expect(color, AppColors.offlineBanner);
    });

    test('68. NotificationCategoryIcon case sensitivity check', () {
      final (icon, color) = NotificationCategoryIcon.of('bookings'); // lowercase
      expect(icon, Icons.notifications_rounded);
      expect(color, AppColors.offlineBanner);
    });

    test('69. NotificationPageModel serialization round trip', () {
      final json = {
        'items': <dynamic>[],
        'page': 4,
        'pageSize': 15,
        'totalCount': 100,
        'unreadCount': 12,
      };
      final parsed = NotificationPageModel.fromJson(json);
      expect(parsed.toJson(), json);
    });

    test('70. UnreadCountModel serialization round trip', () {
      final json = {'unreadCount': 42};
      final parsed = UnreadCountModel.fromJson(json);
      expect(parsed.toJson(), json);
    });

    test('71. NotificationPreferenceModel serialization round trip', () {
      final json = {
        'category': 'Payments',
        'inAppEnabled': false,
        'pushEnabled': true,
        'canDisable': true,
      };
      final parsed = NotificationPreferenceModel.fromJson(json);
      expect(parsed.toJson(), json);
    });

    test('72. UpdateNotificationPreferenceRequestBody serialization round trip', () {
      final json = {'inAppEnabled': true, 'pushEnabled': false};
      final parsed = UpdateNotificationPreferenceRequestBody.fromJson(json);
      expect(parsed.toJson(), json);
    });

    test('73. NotificationModel serialization round trip with deepLink', () {
      final json = {
        'id': 'dl-1',
        'type': 'Deep',
        'category': 'Teams',
        'title': 'Link',
        'body': 'Link body',
        'deepLink': 'app://deep/link',
        'isRead': false,
        'createdAtUtc': '2026-05-01T12:00:00.000Z',
      };
      final parsed = NotificationModel.fromJson(json);
      expect(parsed.deepLink, 'app://deep/link');
      expect(parsed.toJson()['deepLink'], 'app://deep/link');
    });

    test('74. NotificationsState error message retrieval', () {
      const err = NotificationsState.error('network_timeout');
      expect(err, isA<NotificationsError>());
      expect((err as NotificationsError).message, 'network_timeout');
    });

    test('75. NotificationsSuccess initial isLoadingMore is false', () {
      const s = NotificationsSuccess(items: [], unreadCount: 0, hasMore: false, page: 1);
      expect(s.isLoadingMore, isFalse);
    });

    test('76. UnreadNotificationsCubit handles zero count update', () async {
      final cubit = UnreadNotificationsCubit(notificationsRepo: mockRepo);
      when(() => mockRepo.getUnreadCount()).thenAnswer((_) async => const ApiResult.success(0));
      await cubit.refresh();
      expect(cubit.state, 0);
      cubit.close();
    });

    test('77. UnreadNotificationsCubit handles negative or unexpected count gracefully', () async {
      final cubit = UnreadNotificationsCubit(notificationsRepo: mockRepo);
      when(() => mockRepo.getUnreadCount()).thenAnswer((_) async => const ApiResult.success(-1));
      await cubit.refresh();
      expect(cubit.state, -1);
      cubit.close();
    });

    test('78. NotificationsCubit loadMore preserves unreadCount across pages', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final notif1 = NotificationModel(
        id: '1',
        type: 'T',
        category: 'C',
        title: 'T',
        body: 'B',
        isRead: false,
        createdAtUtc: DateTime.utc(2026, 1, 1),
      );
      final notif2 = NotificationModel(
        id: '2',
        type: 'T',
        category: 'C',
        title: 'T',
        body: 'B',
        isRead: true,
        createdAtUtc: DateTime.utc(2026, 1, 2),
      );

      final p1 = NotificationPageModel(items: [notif1], page: 1, pageSize: 1, totalCount: 2, unreadCount: 1);
      final p2 = NotificationPageModel(items: [notif2], page: 2, pageSize: 1, totalCount: 2, unreadCount: 1);

      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(p1));
      when(() => mockRepo.getNotifications(page: 2)).thenAnswer((_) async => ApiResult.success(p2));

      await cubit.load();
      await cubit.loadMore();

      final state = cubit.state as NotificationsSuccess;
      expect(state.unreadCount, 1);
      cubit.close();
    });

    test('79. NotificationCategoryIcon returns distinct icons for distinct categories', () {
      final (bIcon, _) = NotificationCategoryIcon.of('Bookings');
      final (pIcon, _) = NotificationCategoryIcon.of('Payments');
      final (tIcon, _) = NotificationCategoryIcon.of('Teams');
      final (sIcon, _) = NotificationCategoryIcon.of('Security');
      final (vIcon, _) = NotificationCategoryIcon.of('Venues');

      expect(bIcon, isNot(equals(pIcon)));
      expect(pIcon, isNot(equals(tIcon)));
      expect(tIcon, isNot(equals(sIcon)));
      expect(sIcon, isNot(equals(vIcon)));
    });

    test('80. NotificationCategoryIcon returns distinct colors for distinct categories', () {
      final (_, bColor) = NotificationCategoryIcon.of('Bookings');
      final (_, pColor) = NotificationCategoryIcon.of('Payments');
      final (_, sColor) = NotificationCategoryIcon.of('Security');
      final (_, defColor) = NotificationCategoryIcon.of('Other');

      expect(bColor, AppColors.successGreen);
      expect(pColor, AppColors.goldDark);
      expect(sColor, AppColors.brandRed);
      expect(defColor, AppColors.offlineBanner);
    });

    test('81. NotificationsRepoImpl getNotifications default page is 1', () async {
      const pageModel = NotificationPageModel(items: [], page: 1, pageSize: 10, totalCount: 0, unreadCount: 0);
      when(() => mockApi.getNotifications(page: 1)).thenAnswer((_) async => pageModel);

      final res = await repo.getNotifications();
      expect(res, isA<Success<NotificationPageModel>>());
      verify(() => mockApi.getNotifications(page: 1)).called(1);
    });

    test('82. NotificationsRepoImpl updatePreference with pushEnabled true inApp false', () async {
      when(() => mockApi.updatePreference(any(), any())).thenAnswer((_) async => []);

      final res = await repo.updatePreference('Security', inAppEnabled: false, pushEnabled: true);
      expect(res, isA<Success<List<NotificationPreferenceModel>>>());
      verify(() => mockApi.updatePreference(
            'Security',
            any(
              that: isA<UpdateNotificationPreferenceRequestBody>()
                  .having((b) => b.inAppEnabled, 'inAppEnabled', isFalse)
                  .having((b) => b.pushEnabled, 'pushEnabled', isTrue),
            ),
          )).called(1);
    });

    test('83. NotificationsRepoImpl updatePreference handles network error', () async {
      when(() => mockApi.updatePreference(any(), any())).thenThrow(Exception('Dio error'));

      final res = await repo.updatePreference('Security', inAppEnabled: true, pushEnabled: true);
      expect(res, isA<ApiFailure>());
    });

    test('84. NotificationPageModel hasMore is false when totalCount is less than pageSize', () {
      const page = NotificationPageModel(items: [], page: 1, pageSize: 20, totalCount: 5, unreadCount: 1);
      expect(page.hasMore, isFalse);
    });

    test('85. NotificationModel markedRead returns same instance values except isRead', () {
      final date = DateTime.utc(2026, 7, 7, 7, 7);
      final item = NotificationModel(
        id: 'id-77',
        type: 'TypeX',
        category: 'CatY',
        title: 'TitleZ',
        body: 'BodyW',
        deepLink: 'app://target',
        isRead: false,
        createdAtUtc: date,
      );
      final marked = item.markedRead();
      expect(marked.id, item.id);
      expect(marked.type, item.type);
      expect(marked.category, item.category);
      expect(marked.title, item.title);
      expect(marked.body, item.body);
      expect(marked.deepLink, item.deepLink);
      expect(marked.createdAtUtc, item.createdAtUtc);
      expect(marked.isRead, isTrue);
    });

    test('86. NotificationsCubit markRead with multiple items only modifies target', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final it1 = NotificationModel(id: '1', type: 'T', category: 'C', title: 'T', body: 'B', isRead: false, createdAtUtc: DateTime.utc(2026, 1, 1));
      final it2 = NotificationModel(id: '2', type: 'T', category: 'C', title: 'T', body: 'B', isRead: false, createdAtUtc: DateTime.utc(2026, 1, 1));
      final it3 = NotificationModel(id: '3', type: 'T', category: 'C', title: 'T', body: 'B', isRead: false, createdAtUtc: DateTime.utc(2026, 1, 1));

      final p = NotificationPageModel(items: [it1, it2, it3], page: 1, pageSize: 10, totalCount: 3, unreadCount: 3);
      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(p));
      when(() => mockRepo.markRead('2')).thenAnswer((_) async => const ApiResult.success(null));

      await cubit.load();
      await cubit.markRead('2');

      final state = cubit.state as NotificationsSuccess;
      expect(state.items[0].isRead, isFalse);
      expect(state.items[1].isRead, isTrue);
      expect(state.items[2].isRead, isFalse);
      expect(state.unreadCount, 2);
      cubit.close();
    });

    test('87. NotificationsCubit load failure preserves previous state if any', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      when(() => mockRepo.getNotifications(page: 1))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'error_first')));

      await cubit.load();
      expect(cubit.state, const NotificationsState.error('error_first'));
      cubit.close();
    });

    test('88. NotificationModel deepLink equals check', () {
      final nWithLink = NotificationModel(id: '1', type: 'T', category: 'C', title: 'T', body: 'B', deepLink: 'link://a', isRead: false, createdAtUtc: DateTime.utc(2026, 1, 1));
      final nWithoutLink = NotificationModel(id: '2', type: 'T', category: 'C', title: 'T', body: 'B', deepLink: null, isRead: false, createdAtUtc: DateTime.utc(2026, 1, 1));
      expect(nWithLink.deepLink, isNotNull);
      expect(nWithoutLink.deepLink, isNull);
    });

    test('89. NotificationPreferenceModel canDisable true vs false', () {
      const pTrue = NotificationPreferenceModel(category: 'A', inAppEnabled: true, pushEnabled: true, canDisable: true);
      const pFalse = NotificationPreferenceModel(category: 'B', inAppEnabled: true, pushEnabled: true, canDisable: false);
      expect(pTrue.canDisable, isTrue);
      expect(pFalse.canDisable, isFalse);
    });

    test('90. UnreadNotificationsCubit safe when closed during call', () async {
      final cubit = UnreadNotificationsCubit(notificationsRepo: mockRepo);
      when(() => mockRepo.getUnreadCount()).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        return const ApiResult.success(5);
      });

      final future = cubit.refresh();
      await cubit.close();
      await future;
      // Should not throw Bad state: Cannot emit new states after calling close
      expect(cubit.isClosed, isTrue);
    });

    test('91. NotificationsCubit safe when closed during load', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        return const ApiResult.success(NotificationPageModel(items: [], page: 1, pageSize: 10, totalCount: 0, unreadCount: 0));
      });

      final future = cubit.load();
      await cubit.close();
      await future;
      expect(cubit.isClosed, isTrue);
    });

    test('92. NotificationsCubit safe when closed during markAllRead', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final p = NotificationPageModel(
        items: [NotificationModel(id: '1', type: 'T', category: 'C', title: 'T', body: 'B', isRead: false, createdAtUtc: DateTime.utc(2026, 1, 1))],
        page: 1,
        pageSize: 10,
        totalCount: 1,
        unreadCount: 1,
      );
      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(p));
      when(() => mockRepo.markAllRead()).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        return const ApiResult.failure(AppApiFailure(message: 'fail'));
      });

      await cubit.load();
      final future = cubit.markAllRead();
      await cubit.close();
      await future;
      expect(cubit.isClosed, isTrue);
    });

    test('93. NotificationsCubit safe when closed during markRead', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final p = NotificationPageModel(
        items: [NotificationModel(id: '1', type: 'T', category: 'C', title: 'T', body: 'B', isRead: false, createdAtUtc: DateTime.utc(2026, 1, 1))],
        page: 1,
        pageSize: 10,
        totalCount: 1,
        unreadCount: 1,
      );
      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(p));
      when(() => mockRepo.markRead('1')).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        return const ApiResult.success(null);
      });

      await cubit.load();
      final future = cubit.markRead('1');
      await cubit.close();
      await future;
      expect(cubit.isClosed, isTrue);
    });

    test('94. NotificationsCubit safe when closed during loadMore', () async {
      final cubit = NotificationsCubit(notificationsRepo: mockRepo);
      final p = NotificationPageModel(
        items: [NotificationModel(id: '1', type: 'T', category: 'C', title: 'T', body: 'B', isRead: false, createdAtUtc: DateTime.utc(2026, 1, 1))],
        page: 1,
        pageSize: 1,
        totalCount: 5,
        unreadCount: 1,
      );
      when(() => mockRepo.getNotifications(page: 1)).thenAnswer((_) async => ApiResult.success(p));
      when(() => mockRepo.getNotifications(page: 2)).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        return ApiResult.success(p);
      });

      await cubit.load();
      final future = cubit.loadMore();
      await cubit.close();
      await future;
      expect(cubit.isClosed, isTrue);
    });

    test('95. NotificationModel markedRead retains identical id and deepLink', () {
      final model = NotificationModel(
        id: 'custom-id',
        type: 'CustomType',
        category: 'CustomCategory',
        title: 'Title',
        body: 'Body',
        deepLink: 'custom://path/to/resource',
        isRead: false,
        createdAtUtc: DateTime.utc(2026, 3, 15, 14, 30),
      );
      final read = model.markedRead();
      expect(read.id, 'custom-id');
      expect(read.deepLink, 'custom://path/to/resource');
      expect(read.isRead, isTrue);
    });

    test('96. NotificationPageModel unreadCount matches manual filter count', () {
      final items = [
        NotificationModel(id: '1', type: 'T', category: 'C', title: 'T', body: 'B', isRead: false, createdAtUtc: DateTime.utc(2026, 1, 1)),
        NotificationModel(id: '2', type: 'T', category: 'C', title: 'T', body: 'B', isRead: true, createdAtUtc: DateTime.utc(2026, 1, 1)),
        NotificationModel(id: '3', type: 'T', category: 'C', title: 'T', body: 'B', isRead: false, createdAtUtc: DateTime.utc(2026, 1, 1)),
      ];
      final p = NotificationPageModel(
        items: items,
        page: 1,
        pageSize: 10,
        totalCount: 3,
        unreadCount: items.where((i) => !i.isRead).length,
      );
      expect(p.unreadCount, 2);
    });

    test('97. NotificationPageModel hasMore when page 2 of 3 with pageSize 10 and totalCount 25', () {
      const page = NotificationPageModel(items: [], page: 2, pageSize: 10, totalCount: 25, unreadCount: 0);
      expect(page.hasMore, isTrue); // 2 * 10 = 20 < 25
    });

    test('98. NotificationPageModel hasMore is false on last page (page 3 of 3 with pageSize 10 and totalCount 25)', () {
      const page = NotificationPageModel(items: [], page: 3, pageSize: 10, totalCount: 25, unreadCount: 0);
      expect(page.hasMore, isFalse); // 3 * 10 = 30 >= 25
    });
  });
}
