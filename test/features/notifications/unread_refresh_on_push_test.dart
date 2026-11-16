import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/notifications/domain/repos/notifications_repo.dart';
import 'package:mal3abk/features/notifications/presentation/cubit/unread_notifications_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationsRepo extends Mock implements NotificationsRepo {}

/// A push that arrives while the app is open must update the bell badge
/// without the player reopening the screen.
void main() {
  late MockNotificationsRepo repo;
  late StreamController<void> pushes;

  setUp(() {
    repo = MockNotificationsRepo();
    pushes = StreamController<void>.broadcast();
  });

  tearDown(() => pushes.close());

  test('a foreground push refreshes the unread count', () async {
    when(
      () => repo.getUnreadCount(),
    ).thenAnswer((_) async => const ApiResult.success(3));
    final cubit = UnreadNotificationsCubit(
      notificationsRepo: repo,
      pushes: pushes.stream,
    );
    addTearDown(cubit.close);

    pushes.add(null);
    await expectLater(cubit.stream, emits(3));

    verify(() => repo.getUnreadCount()).called(1);
  });

  test('stops listening once closed', () async {
    when(
      () => repo.getUnreadCount(),
    ).thenAnswer((_) async => const ApiResult.success(1));
    final cubit = UnreadNotificationsCubit(
      notificationsRepo: repo,
      pushes: pushes.stream,
    );
    await cubit.close();

    pushes.add(null);
    await Future<void>.delayed(Duration.zero);

    verifyNever(() => repo.getUnreadCount());
  });
}
