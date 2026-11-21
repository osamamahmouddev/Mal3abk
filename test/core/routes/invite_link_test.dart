import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/routes/app_navigator.dart';
import 'package:mal3abk/core/routes/invite_link.dart';
import 'package:mal3abk/core/routes/invite_link_observer.dart';
import 'package:mal3abk/core/routes/routes.dart';

/// A team invite link only ever opens the join screen with a well-formed
/// code; everything else is ignored.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const hosts = {'mal3abk.runasp.net'};

  group('InviteLink.codeFrom accepts', () {
    const accepted = {
      '/join/BJYFLU': 'BJYFLU',
      '/join/bjyflu': 'BJYFLU',
      '/join/BJYFLU/': 'BJYFLU',
      'malabak://app/join/BJYFLU': 'BJYFLU',
      'http://mal3abk.runasp.net/join/BJYFLU': 'BJYFLU',
      'https://mal3abk.runasp.net/join/BJYFLU': 'BJYFLU',
      'https://MAL3ABK.runasp.net/join/BJYFLU': 'BJYFLU',
      'https://mal3abk.runasp.net/join/BJYFLU?utm=x#y': 'BJYFLU',
    };
    accepted.forEach((link, code) {
      test(link, () {
        expect(InviteLink.codeFrom(link, webHosts: hosts), code);
      });
    });
  });

  group('InviteLink.codeFrom ignores', () {
    const rejected = <String?>[
      null,
      '',
      '/join',
      '/join/',
      '/join/BJYFL',
      '/join/BJYFLUX',
      '/join/BJYFL1',
      '/join/%3Cscrip',
      '/join/BJYFLU/extra',
      '/teams/BJYFLU',
      '/JOIN/BJYFLU',
      'https://evil.example/join/BJYFLU',
      'https://mal3abk.runasp.net.evil.example/join/BJYFLU',
      'https://user@mal3abk.runasp.net/join/BJYFLU',
      'malabak://join/BJYFLU',
      'malabak://evil/join/BJYFLU',
      'intent://app/join/BJYFLU',
      'javascript:alert(1)',
      'file:///join/BJYFLU',
      '//mal3abk.runasp.net/join/BJYFLU',
    ];
    for (final link in rejected) {
      test('$link', () {
        expect(InviteLink.codeFrom(link, webHosts: hosts), isNull);
      });
    }
  });

  test('the shared link is the API host with only the join path', () {
    expect(
      InviteLink.share('http://mal3abk.runasp.net', 'BJYFLU'),
      'http://mal3abk.runasp.net/join/BJYFLU',
    );
    expect(
      InviteLink.share('http://10.0.2.2:5000', 'ABC234'),
      'http://10.0.2.2:5000/join/ABC234',
    );
  });

  group('InviteLinkObserver', () {
    setUp(AppNavigator.reset);
    tearDown(AppNavigator.reset);

    test('takes an invite link and waits for the shell', () async {
      final observer = InviteLinkObserver(webHosts: hosts);

      final handled = await observer.didPushRouteInformation(
        RouteInformation(uri: Uri.parse('/join/BJYFLU')),
      );

      expect(handled, isTrue);
      expect(AppNavigator.pendingLink?.route, AppRoutes.joinTeamByCode);
      expect(AppNavigator.pendingLink?.arguments, 'BJYFLU');
    });

    test('hands every other link on', () async {
      final observer = InviteLinkObserver(webHosts: hosts);

      final handled = await observer.didPushRouteInformation(
        RouteInformation(uri: Uri.parse('/recover-phone?token=x')),
      );

      expect(handled, isFalse);
      expect(AppNavigator.pendingLink, isNull);
    });
  });
}
