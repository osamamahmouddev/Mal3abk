import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/teams/data/models/create_team_request_body.dart';
import 'package:mal3abk/features/teams/data/models/created_team_model.dart';
import 'package:mal3abk/features/teams/data/models/team_detail_model.dart';
import 'package:mal3abk/features/teams/data/models/update_team_settings_request_body.dart';
import 'package:mal3abk/features/teams/domain/repos/teams_repo.dart';
import 'package:mal3abk/features/teams/domain/use_cases/create_team_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/teams_fixtures.dart';

class MockTeamsRepo extends Mock implements TeamsRepo {}

CreateTeamRequestBody body({
  String name = 'فريق النجوم',
  String city = 'Nasr City',
  String governorate = 'Cairo',
  String? description,
  String? district,
  String? logoUrl,
}) => CreateTeamRequestBody(
  name: name,
  city: city,
  governorate: governorate,
  description: description,
  district: district,
  logoUrl: logoUrl,
);

/// Matches a created team with its privacy-saved flag.
Matcher createdWith(TeamDetailModel team, {required bool saved}) =>
    isA<Success<CreatedTeamModel>>()
        .having((r) => r.data.team, 'team', team)
        .having((r) => r.data.settingsSaved, 'settingsSaved', saved);

void main() {
  late MockTeamsRepo repo;
  late CreateTeamUseCase createTeam;

  setUpAll(() {
    registerFallbackValue(body());
    registerFallbackValue(
      const UpdateTeamSettingsRequestBody(
        isPublic: true,
        isRecruiting: true,
        isOpenForChallenges: true,
      ),
    );
  });

  setUp(() {
    repo = MockTeamsRepo();
    createTeam = CreateTeamUseCase(teamsRepo: repo);
    when(
      () => repo.createTeam(any()),
    ).thenAnswer((_) async => const ApiResult.success(teamDetail));
    when(
      () => repo.updateSettings(any(), any()),
    ).thenAnswer((_) async => const ApiResult.success(null));
  });

  CreateTeamRequestBody sentBody() =>
      verify(() => repo.createTeam(captureAny())).captured.single
          as CreateTeamRequestBody;

  UpdateTeamSettingsRequestBody sentSettings() =>
      verify(
            () => repo.updateSettings(testTeamId, captureAny()),
          ).captured.single
          as UpdateTeamSettingsRequestBody;

  group('team name', () {
    final valid = {
      'exactly the minimum (3)': 'abc',
      'exactly the maximum (40)': 'a' * 40,
      'arabic': 'فريق الصقور',
      'with digits': 'Team 2026',
      'padded to fit after trimming': '   abc   ',
    };
    valid.forEach((label, name) {
      test('accepts $label', () async {
        expect(
          await createTeam(body(name: name), isPublic: true),
          createdWith(teamDetail, saved: true),
        );
      });
    });

    final invalid = {
      'empty': '',
      'only spaces': '     ',
      'below the minimum (2)': 'ab',
      'below the minimum after trimming': '  ab  ',
      'above the maximum (41)': 'a' * 41,
    };
    invalid.forEach((label, name) {
      test('rejects $label without a request', () async {
        expect(
          await createTeam(body(name: name), isPublic: true),
          isFailureWith('errors.teams.invalid_name'),
        );
        verifyNever(() => repo.createTeam(any()));
        verifyNever(() => repo.updateSettings(any(), any()));
      });
    });

    test('is sent trimmed', () async {
      await createTeam(body(name: '  فريق النجوم  '), isPublic: true);
      expect(sentBody().name, 'فريق النجوم');
    });
  });

  group('location', () {
    final invalid = {
      'empty governorate': body(governorate: ''),
      'blank governorate': body(governorate: '   '),
      'empty city': body(city: ''),
      'blank city': body(city: '  '),
      'both empty': body(city: '', governorate: ''),
    };
    invalid.forEach((label, request) {
      test('rejects $label without a request', () async {
        expect(
          await createTeam(request, isPublic: true),
          isFailureWith('errors.teams.invalid_location'),
        );
        verifyNever(() => repo.createTeam(any()));
      });
    });

    test('the name is checked before the location', () async {
      expect(
        await createTeam(body(name: 'a', city: ''), isPublic: true),
        isFailureWith('errors.teams.invalid_name'),
      );
    });

    test('city, governorate and district are sent as given', () async {
      await createTeam(
        body(city: 'Maadi', governorate: 'Cairo', district: 'Degla'),
        isPublic: true,
      );
      final sent = sentBody();
      expect(sent.city, 'Maadi');
      expect(sent.governorate, 'Cairo');
      expect(sent.district, 'Degla');
    });
  });

  group('description', () {
    test('a blank description is sent as null', () async {
      await createTeam(body(description: '    '), isPublic: true);
      expect(sentBody().description, isNull);
    });

    test('an empty description is sent as null', () async {
      await createTeam(body(description: ''), isPublic: true);
      expect(sentBody().description, isNull);
    });

    test('a missing description stays null', () async {
      await createTeam(body(), isPublic: true);
      expect(sentBody().description, isNull);
    });

    test('a description is sent trimmed', () async {
      await createTeam(body(description: '  نلعب كل جمعة  '), isPublic: true);
      expect(sentBody().description, 'نلعب كل جمعة');
    });

    test('the logo url is passed through', () async {
      await createTeam(
        body(logoUrl: 'https://cdn.malabak.app/l.png'),
        isPublic: true,
      );
      expect(sentBody().logoUrl, 'https://cdn.malabak.app/l.png');
    });
  });

  group('settings after creation', () {
    test('a private choice is sent with the create request', () async {
      await createTeam(body(), isPublic: false);
      final sent = sentBody();
      expect(sent.isPublic, isFalse);
      expect(sent.isRecruiting, isTrue);
      expect(sent.isOpenForChallenges, isFalse);
    });

    test('a public choice is sent with the create request', () async {
      await createTeam(body(), isPublic: true);
      final sent = sentBody();
      expect(sent.isPublic, isTrue);
      expect(sent.isRecruiting, isTrue);
      expect(sent.isOpenForChallenges, isTrue);
    });

    test('the create request carries the privacy fields in json', () async {
      await createTeam(body(), isPublic: false);
      final json = sentBody().toJson();
      expect(json['isPublic'], isFalse);
      expect(json['isRecruiting'], isTrue);
      expect(json['isOpenForChallenges'], isFalse);
    });

    test('a public team is recruiting and open for challenges', () async {
      await createTeam(body(), isPublic: true);
      final settings = sentSettings();
      expect(settings.isPublic, isTrue);
      expect(settings.isRecruiting, isTrue);
      expect(settings.isOpenForChallenges, isTrue);
    });

    test('a private team is recruiting but closed for challenges', () async {
      await createTeam(body(), isPublic: false);
      final settings = sentSettings();
      expect(settings.isPublic, isFalse);
      expect(settings.isRecruiting, isTrue);
      expect(settings.isOpenForChallenges, isFalse);
    });

    test('settings go to the team the server just created', () async {
      await createTeam(body(), isPublic: true);
      verify(() => repo.updateSettings(testTeamId, any())).called(1);
    });

    test('a failed save is retried and the team is kept', () async {
      var calls = 0;
      when(() => repo.updateSettings(any(), any())).thenAnswer((_) async {
        calls++;
        return calls == 1
            ? const ApiResult.failure(AppApiFailure(message: 'errors.network'))
            : const ApiResult.success(null);
      });
      expect(
        await createTeam(body(), isPublic: false),
        createdWith(teamDetail, saved: true),
      );
      expect(calls, 2);
    });

    test('a save that keeps failing is reported, not hidden', () async {
      when(() => repo.updateSettings(any(), any())).thenAnswer(
        (_) async =>
            const ApiResult.failure(AppApiFailure(message: 'errors.server')),
      );
      expect(
        await createTeam(body(), isPublic: false),
        createdWith(teamDetail, saved: false),
      );
      verify(
        () => repo.updateSettings(testTeamId, any()),
      ).called(CreateTeamUseCase.settingsAttempts);
    });

    test('a save that works first time is not repeated', () async {
      await createTeam(body(), isPublic: true);
      verify(() => repo.updateSettings(testTeamId, any())).called(1);
    });

    test('settings are sent after the team is created', () async {
      await createTeam(body(), isPublic: true);
      verifyInOrder([
        () => repo.createTeam(any()),
        () => repo.updateSettings(testTeamId, any()),
      ]);
    });
  });

  group('server failures', () {
    const keys = [
      'errors.teams.max_player_teams_exceeded',
      'errors.teams.name_already_exists',
      'errors.teams.invalid_name',
      'errors.forbidden',
      'errors.network',
    ];
    for (final key in keys) {
      test('$key is returned and no settings are sent', () async {
        when(() => repo.createTeam(any())).thenAnswer(
          (_) async => ApiResult.failure(AppApiFailure(message: key)),
        );

        expect(await createTeam(body(), isPublic: true), isFailureWith(key));
        verifyNever(() => repo.updateSettings(any(), any()));
      });
    }
  });
}
