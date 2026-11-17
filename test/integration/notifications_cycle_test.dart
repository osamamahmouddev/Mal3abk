@Tags(['integration'])
library;

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/local_stack.dart';

/// Notifications end to end against the local stack: a real event in one
/// module reaches another player's inbox through the outbox, the bell count
/// follows it, reading works, preferences are honoured and push tokens are
/// bound to the signed-in session.
///
///     flutter test test/integration/notifications_cycle_test.dart
void main() {
  late bool stackUp;
  setUpAll(() async => stackUp = await LocalStack.start());

  /// A captain's team invites [player] by id, which notifies them.
  Future<String> inviteDirectly(LocalPlayer captain, LocalPlayer player) async {
    final team = await LocalStack.createTeam(captain);
    await captain.dio.post<dynamic>(
      '/api/v1/teams/${team.id}/invitations',
      data: {'validityDays': 7, 'invitedPlayerId': player.id},
    );
    return team.id;
  }

  group('notifications cycle', () {
    test('an invitation reaches the player with a working link', () async {
      if (!LocalStack.ready(stackUp)) return;
      final captain = await LocalStack.newPlayer('Notif Captain');
      final player = await LocalStack.newPlayer('Notif Player');

      final teamId = await inviteDirectly(captain, player);
      final n = await LocalStack.notificationFor(
        player,
        'team.invitation_received',
      );

      expect(n.isRead, isFalse);
      expect(n.title, isNotEmpty);
      expect(n.deepLink, isNotNull, reason: 'a tap must open the team');
      expect(n.deepLink, contains(teamId));
      // The inviting captain is not notified about their own action.
      expect(await LocalStack.countOf(captain, 'team.invitation_received'), 0);
    });

    test('the bell count follows new, read and read-all', () async {
      if (!LocalStack.ready(stackUp)) return;
      final captain = await LocalStack.newPlayer('Bell Captain');
      final player = await LocalStack.newPlayer('Bell Player');
      expect(ok(await player.notifications.getUnreadCount(), 'count'), 0);

      await inviteDirectly(captain, player);
      await inviteDirectly(captain, player);
      await LocalStack.notificationFor(
        player,
        'team.invitation_received',
        where: (_) => true,
      );
      final deadline = DateTime.now().add(const Duration(seconds: 30));
      var unread = 0;
      while (DateTime.now().isBefore(deadline)) {
        unread = ok(await player.notifications.getUnreadCount(), 'count');
        if (unread == 2) break;
        await Future<void>.delayed(const Duration(milliseconds: 500));
      }
      expect(unread, 2);

      final page = ok(await player.notifications.getNotifications(), 'list');
      expect(page.unreadCount, 2);
      ok(await player.notifications.markRead(page.items.first.id), 'read one');
      expect(ok(await player.notifications.getUnreadCount(), 'count'), 1);

      ok(await player.notifications.markAllRead(), 'read all');
      expect(ok(await player.notifications.getUnreadCount(), 'count'), 0);
      final after = ok(await player.notifications.getNotifications(), 'list');
      expect(after.items.every((n) => n.isRead), isTrue);
    });

    test(
      'a player cannot read or mark another player\'s notification',
      () async {
        if (!LocalStack.ready(stackUp)) return;
        final captain = await LocalStack.newPlayer('Owner Captain');
        final player = await LocalStack.newPlayer('Owner Player');
        final stranger = await LocalStack.newPlayer('Stranger');

        await inviteDirectly(captain, player);
        final n = await LocalStack.notificationFor(
          player,
          'team.invitation_received',
        );

        // Marking someone else's notification must not touch it.
        await stranger.notifications.markRead(n.id);
        final mine = ok(await player.notifications.getNotifications(), 'list');
        expect(mine.items.firstWhere((x) => x.id == n.id).isRead, isFalse);
        final theirs = ok(
          await stranger.notifications.getNotifications(),
          'list',
        );
        expect(theirs.items.map((x) => x.id), isNot(contains(n.id)));
      },
    );

    test('turning a category off stops new in-app notifications', () async {
      if (!LocalStack.ready(stackUp)) return;
      final captain = await LocalStack.newPlayer('Pref Captain');
      final player = await LocalStack.newPlayer('Pref Player');

      await inviteDirectly(captain, player);
      final first = await LocalStack.notificationFor(
        player,
        'team.invitation_received',
      );
      final prefs = ok(await player.notifications.getPreferences(), 'prefs');
      final pref = prefs.firstWhere(
        (p) => p.category.toLowerCase() == first.category.toLowerCase(),
        orElse: () => throw TestFailure(
          'no preference for category ${first.category}: '
          '${prefs.map((p) => p.category).join(', ')}',
        ),
      );
      if (!pref.canDisable) {
        markTestSkipped('${first.category} cannot be turned off');
        return;
      }

      final updated = ok(
        await player.notifications.updatePreference(
          pref.category,
          inAppEnabled: false,
          pushEnabled: false,
        ),
        'turn category off',
      );
      final saved = updated.firstWhere((p) => p.category == pref.category);
      expect(saved.inAppEnabled, isFalse);
      expect(saved.pushEnabled, isFalse);

      await inviteDirectly(captain, player);
      // Give the outbox time to run; nothing new may arrive.
      await Future<void>.delayed(const Duration(seconds: 12));
      expect(await LocalStack.countOf(player, 'team.invitation_received'), 1);

      // Back on, the next one arrives again.
      ok(
        await player.notifications.updatePreference(
          pref.category,
          inAppEnabled: true,
          pushEnabled: true,
        ),
        'turn category on',
      );
      await inviteDirectly(captain, player);
      await LocalStack.notificationFor(
        player,
        'team.invitation_received',
        where: (n) => n.id != first.id,
      );
    }, timeout: const Timeout(Duration(minutes: 2)));

    test(
      'push tokens: register, re-register, reject junk, unregister',
      () async {
        if (!LocalStack.ready(stackUp)) return;
        final player = await LocalStack.newPlayer('Token Player');
        final token = 'cycle-token-${LocalStack.runId}-${player.id}';

        // Android = 0 in the API enum.
        var response = await player.dio.post<dynamic>(
          '/api/v1/me/devices/push-token',
          data: {'token': token, 'platform': 0},
        );
        expect(response.statusCode, 204);
        // Registering again (app restart) is fine.
        response = await player.dio.post<dynamic>(
          '/api/v1/me/devices/push-token',
          data: {'token': token, 'platform': 0},
        );
        expect(response.statusCode, 204);

        final junk = await player.dio.post<dynamic>(
          '/api/v1/me/devices/push-token',
          data: {'token': '', 'platform': 0},
          options: Options(validateStatus: (_) => true),
        );
        expect(junk.statusCode, 400);

        response = await player.dio.delete<dynamic>(
          '/api/v1/me/devices/push-token',
          data: {'token': token},
        );
        expect(response.statusCode, 204);
      },
    );

    test('notifications need a signed-in player', () async {
      if (!LocalStack.ready(stackUp)) return;
      final anonymous = await LocalStack.plain.get<dynamic>(
        '${LocalStack.apiUrl}/api/v1/me/notifications',
        options: Options(validateStatus: (_) => true),
      );
      expect(anonymous.statusCode, 401);
    });
  });
}
