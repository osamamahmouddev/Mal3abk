import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/notifications/data/models/notification_preference_model.dart';
import 'package:mal3abk/features/notifications/domain/repos/notifications_repo.dart';
import 'package:mal3abk/features/settings/data/models/session_model.dart';
import 'package:mal3abk/features/settings/domain/repos/account_repo.dart';
import 'package:mal3abk/features/settings/presentation/cubit/notification_preferences_cubit.dart';
import 'package:mal3abk/features/settings/presentation/cubit/notification_preferences_state.dart';
import 'package:mal3abk/features/settings/presentation/cubit/sessions_cubit.dart';
import 'package:mal3abk/features/settings/presentation/cubit/sessions_state.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationsRepo extends Mock implements NotificationsRepo {}

class MockAccountRepo extends Mock implements AccountRepo {}

NotificationPreferenceModel preference(
  String category, {
  bool enabled = true,
  bool canDisable = true,
}) => NotificationPreferenceModel(
  category: category,
  inAppEnabled: enabled,
  pushEnabled: enabled,
  canDisable: canDisable,
);

SessionModel session(String id, {bool current = false, int minutesAgo = 0}) =>
    SessionModel(
      sessionId: id,
      ipAddress: '10.0.0.1',
      userAgent: 'Malabak/1.0',
      createdAtUtc: DateTime.utc(2026, 11, 1),
      lastActivityAtUtc: DateTime.utc(
        2026,
        11,
        5,
      ).subtract(Duration(minutes: minutesAgo)),
      isCurrent: current,
    );

void main() {
  group('NotificationPreferencesCubit', () {
    late MockNotificationsRepo repo;
    late NotificationPreferencesCubit cubit;

    setUp(() {
      repo = MockNotificationsRepo();
      cubit = NotificationPreferencesCubit(notificationsRepo: repo);
      when(() => repo.getPreferences()).thenAnswer(
        (_) async => ApiResult.success([
          preference('Bookings'),
          preference('Venues'),
          preference('Security', canDisable: false),
        ]),
      );
    });

    tearDown(() => cubit.close());

    test('shows only the player categories', () async {
      await cubit.load();

      final state = cubit.state as NotificationPreferencesSuccess;
      expect(state.preferences.map((p) => p.category), [
        'Bookings',
        'Security',
      ]);
    });

    test('rolls a toggle back when saving fails', () async {
      when(
        () => repo.updatePreference(
          'Bookings',
          inAppEnabled: false,
          pushEnabled: false,
        ),
      ).thenAnswer(
        (_) async =>
            const ApiResult.failure(AppApiFailure(message: 'errors.network')),
      );
      await cubit.load();

      await cubit.toggle('Bookings', enabled: false);

      final state = cubit.state as NotificationPreferencesSuccess;
      expect(state.preferences.first.inAppEnabled, isTrue);
      expect(state.failure, 'errors.network');
    });

    test('never turns off a locked category', () async {
      await cubit.load();

      await cubit.toggle('Security', enabled: false);

      verifyNever(
        () => repo.updatePreference(
          any(),
          inAppEnabled: any(named: 'inAppEnabled'),
          pushEnabled: any(named: 'pushEnabled'),
        ),
      );
    });
  });

  group('SessionsCubit', () {
    late MockAccountRepo repo;
    late SessionsCubit cubit;

    setUp(() {
      repo = MockAccountRepo();
      cubit = SessionsCubit(accountRepo: repo);
    });

    tearDown(() => cubit.close());

    test('lists this device first, then the most recent', () async {
      when(() => repo.getSessions()).thenAnswer(
        (_) async => ApiResult.success([
          session('old', minutesAgo: 90),
          session('me', current: true, minutesAgo: 5),
          session('recent', minutesAgo: 1),
        ]),
      );

      await cubit.load();

      expect(
        (cubit.state as SessionsSuccess).sessions.map((s) => s.sessionId),
        ['me', 'recent', 'old'],
      );
    });

    test('reloads after signing out another device', () async {
      when(() => repo.getSessions()).thenAnswer(
        (_) async => ApiResult.success([session('me', current: true)]),
      );
      when(
        () => repo.revokeSession('other'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      await cubit.load();

      await cubit.revoke('other');

      verify(() => repo.getSessions()).called(2);
      expect((cubit.state as SessionsSuccess).busy, isFalse);
    });
  });
}
