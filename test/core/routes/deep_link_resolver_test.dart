import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/routes/deep_link_resolver.dart';
import 'package:mal3abk/core/routes/routes.dart';

void main() {
  test('opens the screen for each server link', () {
    final cases = {
      'malabak://booking/b-1': (AppRoutes.bookingDetails, 'b-1'),
      'malabak://venue/v-1': (AppRoutes.venueProfile, 'v-1'),
      'malabak://team/t-1': (AppRoutes.teamProfile, 't-1'),
      'malabak://match/m-1': (AppRoutes.matchDetails, 'm-1'),
      'malabak://challenge/c-1': (AppRoutes.challengeDetails, 'c-1'),
    };
    for (final MapEntry(key: link, value: (route, id)) in cases.entries) {
      final target = DeepLinkResolver.resolve(link);
      expect((target?.route, target?.arguments), (route, id), reason: link);
    }
    expect(
      DeepLinkResolver.resolve('malabak://settings/security')?.route,
      AppRoutes.settings,
    );
  });

  test('ignores foreign, malformed and unsupported links', () {
    for (final link in [
      null,
      '',
      'https://evil.example/team/t-1',
      'malabak://team',
      'malabak://team/t-1/extra',
      'malabak://booking/create?matchId=m-1',
      'malabak://venue-manager/venue/v-1',
    ]) {
      expect(DeepLinkResolver.resolve(link), isNull, reason: '$link');
    }
  });
}
