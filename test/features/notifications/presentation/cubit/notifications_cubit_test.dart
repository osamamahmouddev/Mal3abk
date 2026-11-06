import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/notifications/data/models/notification_model.dart';
import 'package:mal3abk/features/notifications/data/models/notification_page_model.dart';
import 'package:mal3abk/features/notifications/domain/repos/notifications_repo.dart';
import 'package:mal3abk/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:mal3abk/features/notifications/presentation/cubit/notifications_state.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationsRepo extends Mock implements NotificationsRepo {}

NotificationModel notification(String id, {bool isRead = false}) =>
    NotificationModel(
      id: id,
      type: 'ChallengeReceived',
      category: 'Teams',
      title: 'تحدي جديد',
      body: 'فريق الصقور بيتحداكم',
      isRead: isRead,
      createdAtUtc: DateTime.utc(2026, 11, 5),
    );

NotificationPageModel page(
  List<NotificationModel> items, {
  int page = 1,
  int total = 2,
}) => NotificationPageModel(
  items: items,
  page: page,
  pageSize: 1,
  totalCount: total,
  unreadCount: items.where((n) => !n.isRead).length,
);

void main() {
  late MockNotificationsRepo repo;
  late NotificationsCubit cubit;

  setUp(() {
    repo = MockNotificationsRepo();
    cubit = NotificationsCubit(notificationsRepo: repo);
    when(
      () => repo.getNotifications(),
    ).thenAnswer((_) async => ApiResult.success(page([notification('n-1')])));
  });

  tearDown(() => cubit.close());

  test('appends the next page', () async {
    when(() => repo.getNotifications(page: 2)).thenAnswer(
      (_) async => ApiResult.success(page([notification('n-2')], page: 2)),
    );
    await cubit.load();

    await cubit.loadMore();

    final state = cubit.state as NotificationsSuccess;
    expect(state.items.map((n) => n.id), ['n-1', 'n-2']);
    expect(state.hasMore, isFalse);
  });

  test('marks a notification read before the server answers', () async {
    when(
      () => repo.markRead('n-1'),
    ).thenAnswer((_) async => const ApiResult.success(null));
    await cubit.load();

    final pending = cubit.markRead('n-1');

    final state = cubit.state as NotificationsSuccess;
    expect(state.items.single.isRead, isTrue);
    expect(state.unreadCount, 0);
    await pending;
  });

  test('reloads when marking all read fails', () async {
    when(() => repo.markAllRead()).thenAnswer(
      (_) async =>
          const ApiResult.failure(AppApiFailure(message: 'errors.network')),
    );
    await cubit.load();

    await cubit.markAllRead();

    verify(() => repo.getNotifications()).called(2);
    expect((cubit.state as NotificationsSuccess).unreadCount, 1);
  });
}
