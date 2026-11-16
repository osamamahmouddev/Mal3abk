import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/matches/data/models/challenge_details_model.dart';
import 'package:mal3abk/features/matches/data/models/match_details_model.dart';
import 'package:mal3abk/features/matches/data/models/match_model.dart';
import 'package:mal3abk/features/matches/data/models/match_page_model.dart';
import 'package:mal3abk/features/matches/data/models/respond_to_challenge_request_body.dart';
import 'package:mal3abk/features/matches/data/models/send_challenge_request_body.dart';
import 'package:mal3abk/features/matches/data/models/submit_match_result_request_body.dart';
import 'package:mal3abk/features/matches/data/models/team_challenge_model.dart';
import 'package:mal3abk/features/matches/data/models/verify_match_result_request_body.dart';
import 'package:mal3abk/features/matches/domain/repos/matches_repo.dart';
import 'package:mal3abk/features/matches/domain/use_cases/challenge_schedule_rules.dart';
import 'package:mal3abk/features/matches/domain/use_cases/get_challenge_details_use_case.dart';
import 'package:mal3abk/features/matches/domain/use_cases/get_match_details_use_case.dart';
import 'package:mal3abk/features/matches/domain/use_cases/respond_to_challenge_use_case.dart';
import 'package:mal3abk/features/matches/domain/use_cases/send_challenge_use_case.dart';
import 'package:mal3abk/features/matches/presentation/cubit/challenge_details_cubit.dart';
import 'package:mal3abk/features/matches/presentation/cubit/challenge_details_state.dart';
import 'package:mal3abk/features/matches/presentation/cubit/challenge_response_cubit.dart';
import 'package:mal3abk/features/matches/presentation/cubit/challenge_response_state.dart';
import 'package:mal3abk/features/matches/presentation/cubit/match_details_cubit.dart';
import 'package:mal3abk/features/matches/presentation/cubit/match_details_state.dart';
import 'package:mal3abk/features/matches/presentation/cubit/send_challenge_cubit.dart';
import 'package:mal3abk/features/matches/presentation/cubit/send_challenge_state.dart';
import 'package:mal3abk/features/teams/data/models/team_summary_model.dart';
import '../../helpers/matches_fixtures.dart';
import '../../helpers/teams_fixtures.dart';

class MockMatchesRepo extends Mock implements MatchesRepo {}
class MockSendChallengeUseCase extends Mock implements SendChallengeUseCase {}
class MockRespondToChallengeUseCase extends Mock implements RespondToChallengeUseCase {}
class MockGetMatchDetailsUseCase extends Mock implements GetMatchDetailsUseCase {}
class MockGetChallengeDetailsUseCase extends Mock implements GetChallengeDetailsUseCase {}

TeamSummaryModel _teamSummary({required String id, String name = 'N', int? myRole}) {
  return TeamSummaryModel(
    id: id,
    name: name,
    city: 'Cairo',
    governorate: 'Cairo',
    captainId: 'captain-1',
    memberCount: 5,
    rating: 1500,
    matchesPlayed: 1,
    isRecruiting: false,
    isOpenForChallenges: true,
    myRole: myRole,
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(SendChallengeRequestBody(
      challengerTeamId: '',
      challengedTeamId: '',
      proposedDateUtc: DateTime.utc(2026, 1, 1),
      durationMinutes: 60,
    ));
    registerFallbackValue(const RespondToChallengeRequestBody(
      respondingTeamId: 't-1',
      action: ChallengeResponseAction.accept,
    ));
  });

  group('MatchModel & MatchPageModel Tests', () {
    test('1. MatchModel fromJson and toJson', () {
      final json = {
        'id': 'm-1',
        'homeTeamId': 't-1',
        'homeTeamName': 'Stars',
        'awayTeamId': 't-2',
        'awayTeamName': 'Falcons',
        'scheduledStartUtc': '2026-05-01T18:00:00Z',
        'scheduledEndUtc': '2026-05-01T19:30:00Z',
        'durationMinutes': 90,
        'status': 'Scheduled',
        'outcome': 'None',
        'resultStatus': 'None',
        'venueName': 'Camp Nou Arena',
      };
      final match = MatchModel.fromJson(json);
      expect(match.id, 'm-1');
      expect(match.homeTeamId, 't-1');
      expect(match.homeTeamName, 'Stars');
      expect(match.awayTeamId, 't-2');
      expect(match.awayTeamName, 'Falcons');
      expect(match.durationMinutes, 90);
      expect(match.venueName, 'Camp Nou Arena');
      expect(match.toJson()['id'], 'm-1');
    });

    test('2. MatchModel isAwaitingResult is true when Scheduled or InProgress and resultNone', () {
      final matchScheduled = testMatch(status: MatchModel.scheduled, resultStatus: MatchModel.resultNone);
      expect(matchScheduled.isAwaitingResult, isTrue);

      final matchInProgress = testMatch(status: MatchModel.inProgress, resultStatus: MatchModel.resultNone);
      expect(matchInProgress.isAwaitingResult, isTrue);
    });

    test('3. MatchModel isAwaitingResult is false when result is pending or completed', () {
      final matchPending = testMatch(status: MatchModel.completed, resultStatus: MatchModel.resultPending);
      expect(matchPending.isAwaitingResult, isFalse);

      final matchDone = testMatch(status: MatchModel.completed, resultStatus: 'Confirmed');
      expect(matchDone.isAwaitingResult, isFalse);
    });

    test('4. MatchModel isPendingVerification check', () {
      final matchPending = testMatch(resultStatus: MatchModel.resultPending);
      expect(matchPending.isPendingVerification, isTrue);

      final matchNone = testMatch(resultStatus: MatchModel.resultNone);
      expect(matchNone.isPendingVerification, isFalse);
    });

    test('5. MatchModel isDisputed check', () {
      final matchDisputed = testMatch(status: MatchModel.disputed);
      expect(matchDisputed.isDisputed, isTrue);

      final matchScheduled = testMatch(status: MatchModel.scheduled);
      expect(matchScheduled.isDisputed, isFalse);
    });

    test('6. MatchModel resultFor calculates win, draw, loss for home team', () {
      final winMatch = testMatch(homeTeamId: 'my-team', homeScore: 3, awayScore: 1, status: MatchModel.completed);
      expect(winMatch.resultFor('my-team'), MatchResultForTeam.win);

      final drawMatch = testMatch(homeTeamId: 'my-team', homeScore: 2, awayScore: 2, status: MatchModel.completed);
      expect(drawMatch.resultFor('my-team'), MatchResultForTeam.draw);

      final lossMatch = testMatch(homeTeamId: 'my-team', homeScore: 0, awayScore: 2, status: MatchModel.completed);
      expect(lossMatch.resultFor('my-team'), MatchResultForTeam.loss);
    });

    test('7. MatchModel resultFor calculates win, draw, loss for away team', () {
      final winMatch = testMatch(homeTeamId: 'other-team', awayTeamId: 'my-team', homeScore: 1, awayScore: 4, status: MatchModel.completed);
      expect(winMatch.resultFor('my-team'), MatchResultForTeam.win);

      final lossMatch = testMatch(homeTeamId: 'other-team', awayTeamId: 'my-team', homeScore: 3, awayScore: 1, status: MatchModel.completed);
      expect(lossMatch.resultFor('my-team'), MatchResultForTeam.loss);
    });

    test('8. MatchModel resultFor returns pending when scores are missing', () {
      final pendingMatch = testMatch(homeTeamId: 'my-team', homeScore: null, awayScore: null);
      expect(pendingMatch.resultFor('my-team'), MatchResultForTeam.pending);
    });

    test('9. MatchPageModel fromJson and toJson', () {
      final json = {
        'items': [
          {
            'id': 'm-1',
            'homeTeamId': 't1',
            'homeTeamName': 'H',
            'awayTeamId': 't2',
            'awayTeamName': 'A',
            'scheduledStartUtc': '2026-05-01T18:00:00Z',
            'scheduledEndUtc': '2026-05-01T19:00:00Z',
            'durationMinutes': 60,
            'status': 'Scheduled',
            'outcome': 'None',
            'resultStatus': 'None',
          }
        ],
        'totalCount': 1,
        'page': 1,
        'pageSize': 10,
      };
      final page = MatchPageModel.fromJson(json);
      expect(page.items.length, 1);
      expect(page.totalCount, 1);
      expect(page.page, 1);
      expect(page.pageSize, 10);
      expect(page.toJson()['totalCount'], 1);
    });
  });

  group('TeamChallengeModel Tests', () {
    test('10. TeamChallengeModel fromJson parses all fields', () {
      final json = {
        'id': 'ch-1',
        'challengerTeamId': 't-1',
        'challengerTeamName': 'Team Alpha',
        'challengedTeamId': 't-2',
        'challengedTeamName': 'Team Beta',
        'proposedDateUtc': '2026-05-01T20:00:00Z',
        'proposedDurationMinutes': 90,
        'proposedVenueName': 'Zamalek Pitch',
        'notes': 'Looking forward',
        'status': 1, // pending
        'currentTurnTeamId': 't-2',
        'isMyTurn': true,
      };
      final challenge = TeamChallengeModel.fromJson(json);
      expect(challenge.id, 'ch-1');
      expect(challenge.challengerTeamId, 't-1');
      expect(challenge.challengerTeamName, 'Team Alpha');
      expect(challenge.challengedTeamId, 't-2');
      expect(challenge.challengedTeamName, 'Team Beta');
      expect(challenge.proposedDurationMinutes, 90);
      expect(challenge.status, ChallengeStatus.pending);
      expect(challenge.isOpen, isTrue);
      expect(challenge.isMyTurn, isTrue);
      expect(challenge.toJson()['challengerTeamId'], 't-1');
    });

    test('11. TeamChallengeModel isOpen is true for pending and counterProposed', () {
      final pending = testChallenge(status: ChallengeStatus.pending);
      expect(pending.isOpen, isTrue);

      final counter = testChallenge(status: ChallengeStatus.counterProposed);
      expect(counter.isOpen, isTrue);
    });

    test('12. TeamChallengeModel isOpen is false for accepted, declined, cancelled, expired', () {
      expect(testChallenge(status: ChallengeStatus.accepted).isOpen, isFalse);
      expect(testChallenge(status: ChallengeStatus.declined).isOpen, isFalse);
      expect(testChallenge(status: ChallengeStatus.cancelled).isOpen, isFalse);
      expect(testChallenge(status: ChallengeStatus.expired).isOpen, isFalse);
    });
  });

  group('ChallengeScheduleRules Tests', () {
    final now = DateTime.utc(2026, 5, 1, 12, 0);

    test('13. accepts valid future date and standard duration', () {
      final proposed = now.add(const Duration(hours: 4));
      final error = ChallengeScheduleRules.check(
        proposedUtc: proposed,
        durationMinutes: 90,
        nowUtc: now,
      );
      expect(error, isNull);
    });

    test('14. rejects duration less than 30 minutes', () {
      final proposed = now.add(const Duration(hours: 4));
      final error = ChallengeScheduleRules.check(
        proposedUtc: proposed,
        durationMinutes: 20,
        nowUtc: now,
      );
      expect(error?.message, 'errors.matches.invalid_duration');
    });

    test('15. rejects duration greater than 180 minutes', () {
      final proposed = now.add(const Duration(hours: 4));
      final error = ChallengeScheduleRules.check(
        proposedUtc: proposed,
        durationMinutes: 200,
        nowUtc: now,
      );
      expect(error?.message, 'errors.matches.invalid_duration');
    });

    test('16. accepts boundary duration of 30 minutes', () {
      final proposed = now.add(const Duration(hours: 1));
      final error = ChallengeScheduleRules.check(
        proposedUtc: proposed,
        durationMinutes: 30,
        nowUtc: now,
      );
      expect(error, isNull);
    });

    test('17. accepts boundary duration of 180 minutes', () {
      final proposed = now.add(const Duration(hours: 1));
      final error = ChallengeScheduleRules.check(
        proposedUtc: proposed,
        durationMinutes: 180,
        nowUtc: now,
      );
      expect(error, isNull);
    });

    test('18. rejects proposed date in past', () {
      final inPast = now.subtract(const Duration(minutes: 1));
      final error = ChallengeScheduleRules.check(
        proposedUtc: inPast,
        durationMinutes: 60,
        nowUtc: now,
      );
      expect(error?.message, 'errors.matches.date_in_past');
    });

    test('19. rejects proposed date equal to now', () {
      final error = ChallengeScheduleRules.check(
        proposedUtc: now,
        durationMinutes: 60,
        nowUtc: now,
      );
      expect(error?.message, 'errors.matches.date_in_past');
    });
  });

  group('MatchDetailsModel & ChallengeDetailsModel Role Permissions Tests', () {
    final now = DateTime.utc(2026, 5, 1, 15, 0);

    test('20. MatchDetailsModel canLead is true when caller is captain or co-captain', () {
      final match = testMatch();
      final leaderTeam = _teamSummary(id: 'team-1', name: 'N', myRole: 1); // captain
      final details = MatchDetailsModel(match: match, myTeam: leaderTeam);
      expect(details.canLead, isTrue);
    });

    test('21. MatchDetailsModel canLead is false when caller is normal player', () {
      final match = testMatch();
      final playerTeam = _teamSummary(id: 'team-1', name: 'N', myRole: 3); // player
      final details = MatchDetailsModel(match: match, myTeam: playerTeam);
      expect(details.canLead, isFalse);
    });

    test('22. MatchDetailsModel canSubmitResult requires leader, awaiting result, and past start time', () {
      final pastStart = now.subtract(const Duration(hours: 1));
      final match = testMatch(startUtc: pastStart, status: MatchModel.inProgress, resultStatus: MatchModel.resultNone);
      final details = MatchDetailsModel(match: match, myTeam: myTeam);
      expect(details.canSubmitResult(now), isTrue);
    });

    test('23. MatchDetailsModel canSubmitResult is false before kick-off', () {
      final futureStart = now.add(const Duration(hours: 2));
      final match = testMatch(startUtc: futureStart, status: MatchModel.scheduled, resultStatus: MatchModel.resultNone);
      final details = MatchDetailsModel(match: match, myTeam: myTeam);
      expect(details.canSubmitResult(now), isFalse);
    });

    test('24. MatchDetailsModel canVerifyResult only allowed for opponent team leader', () {
      final match = testMatch(
        homeTeamId: 'team-1',
        awayTeamId: 'team-2',
        resultStatus: MatchModel.resultPending,
        submittedBy: 'team-1',
      );
      // Opponent team (team-2)
      final opponentLeader = _teamSummary(id: 'team-2', name: 'Falcons', myRole: 1);
      final detailsOpponent = MatchDetailsModel(match: match, myTeam: opponentLeader);
      expect(detailsOpponent.canVerifyResult, isTrue);

      // Submitting team leader cannot verify their own submission
      final detailsSubmitting = MatchDetailsModel(match: match, myTeam: myTeam); // team-1
      expect(detailsSubmitting.canVerifyResult, isFalse);
    });

    test('25. ChallengeDetailsModel canRespond requires open, my turn, leader, and matching team id', () {
      final challenge = testChallenge(
        status: ChallengeStatus.pending,
        isMyTurn: true,
        currentTurnTeamId: testTeamId,
      );
      final details = ChallengeDetailsModel(challenge: challenge, myTeam: myTeam);
      expect(details.canRespond, isTrue);
    });

    test('26. ChallengeDetailsModel canRespond is false when not my turn', () {
      final challenge = testChallenge(
        status: ChallengeStatus.pending,
        isMyTurn: false,
        currentTurnTeamId: 'other-team',
      );
      final details = ChallengeDetailsModel(challenge: challenge, myTeam: myTeam);
      expect(details.canRespond, isFalse);
    });

    test('27. ChallengeDetailsModel canRespond is false for ordinary member', () {
      final challenge = testChallenge(
        status: ChallengeStatus.pending,
        isMyTurn: true,
        currentTurnTeamId: testTeamId,
      );
      final ordinaryTeam = _teamSummary(id: testTeamId, name: 'N', myRole: 3);
      final details = ChallengeDetailsModel(challenge: challenge, myTeam: ordinaryTeam);
      expect(details.canRespond, isFalse);
    });
  });

  group('Request Bodies Serialization Tests', () {
    test('28. SendChallengeRequestBody fromJson and toJson', () {
      final json = {
        'challengerTeamId': 't-1',
        'challengedTeamId': 't-2',
        'proposedDateUtc': '2026-05-01T18:00:00.000Z',
        'durationMinutes': 60,
        'proposedVenueName': 'Arena',
        'notes': 'Friendly match',
      };
      final body = SendChallengeRequestBody.fromJson(json);
      expect(body.challengerTeamId, 't-1');
      expect(body.challengedTeamId, 't-2');
      expect(body.durationMinutes, 60);
      expect(body.proposedVenueName, 'Arena');
      expect(body.notes, 'Friendly match');
      expect(body.toJson()['challengerTeamId'], 't-1');
    });

    test('29. RespondToChallengeRequestBody accept toJson', () {
      const body = RespondToChallengeRequestBody(
        respondingTeamId: 't-1',
        action: ChallengeResponseAction.accept,
      );
      expect(body.toJson()['action'], 1);
    });

    test('30. RespondToChallengeRequestBody decline toJson', () {
      const body = RespondToChallengeRequestBody(
        respondingTeamId: 't-1',
        action: ChallengeResponseAction.decline,
        declineReason: 'Busy',
      );
      final json = body.toJson();
      expect(json['action'], 2);
      expect(json['declineReason'], 'Busy');
    });

    test('31. RespondToChallengeRequestBody counterPropose toJson', () {
      final date = DateTime.utc(2026, 5, 2, 19);
      final body = RespondToChallengeRequestBody(
        respondingTeamId: 't-1',
        action: ChallengeResponseAction.counterPropose,
        newProposedDateUtc: date,
        newDurationMinutes: 90,
      );
      final json = body.toJson();
      expect(json['action'], 3);
      expect(json['newDurationMinutes'], 90);
    });

    test('32. SubmitMatchResultRequestBody fromJson and toJson', () {
      final json = {'homeScore': 3, 'awayScore': 2};
      final body = SubmitMatchResultRequestBody.fromJson(json);
      expect(body.homeScore, 3);
      expect(body.awayScore, 2);
      expect(body.toJson()['homeScore'], 3);
    });

    test('33. VerifyMatchResultRequestBody confirm toJson', () {
      const body = VerifyMatchResultRequestBody(
        action: MatchVerificationAction.confirm,
      );
      expect(body.toJson()['action'], 1);
    });

    test('34. VerifyMatchResultRequestBody dispute toJson', () {
      const body = VerifyMatchResultRequestBody(
        action: MatchVerificationAction.dispute,
        disputeReason: 'Wrong score',
      );
      final json = body.toJson();
      expect(json['action'], 2);
      expect(json['disputeReason'], 'Wrong score');
    });
  });

  group('SendChallengeCubit Tests', () {
    late MockSendChallengeUseCase mockUseCase;

    setUp(() {
      mockUseCase = MockSendChallengeUseCase();
    });

    test('35. Initial state is SendChallengeInitial', () {
      final cubit = SendChallengeCubit(sendChallengeUseCase: mockUseCase);
      expect(cubit.state, const SendChallengeState.initial());
      cubit.close();
    });

    test('36. send emits [loading, success]', () async {
      final cubit = SendChallengeCubit(sendChallengeUseCase: mockUseCase);
      final body = SendChallengeRequestBody(
        challengerTeamId: 't1',
        challengedTeamId: 't2',
        proposedDateUtc: DateTime.utc(2026, 5, 1, 18),
        durationMinutes: 60,
      );
      final challenge = testChallenge();
      when(() => mockUseCase(body)).thenAnswer((_) async => ApiResult.success(challenge));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const SendChallengeState.loading(),
          SendChallengeState.success(challenge),
        ]),
      );

      await cubit.send(body);
      cubit.close();
    });

    test('37. send emits [loading, error] on failure', () async {
      final cubit = SendChallengeCubit(sendChallengeUseCase: mockUseCase);
      final body = SendChallengeRequestBody(
        challengerTeamId: 't1',
        challengedTeamId: 't2',
        proposedDateUtc: DateTime.utc(2026, 5, 1, 18),
        durationMinutes: 60,
      );
      when(() => mockUseCase(body))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.challenge_rejected')));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const SendChallengeState.loading(),
          const SendChallengeState.error('errors.challenge_rejected'),
        ]),
      );

      await cubit.send(body);
      cubit.close();
    });

    test('38. send ignores call if already in loading state', () async {
      final cubit = SendChallengeCubit(sendChallengeUseCase: mockUseCase);
      final body = SendChallengeRequestBody(
        challengerTeamId: 't1',
        challengedTeamId: 't2',
        proposedDateUtc: DateTime.utc(2026, 5, 1, 18),
        durationMinutes: 60,
      );
      when(() => mockUseCase(body)).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return ApiResult.success(testChallenge());
      });

      final f1 = cubit.send(body);
      final f2 = cubit.send(body);
      await Future.wait([f1, f2]);

      verify(() => mockUseCase(body)).called(1);
      cubit.close();
    });
  });

  group('ChallengeResponseCubit Tests', () {
    late MockRespondToChallengeUseCase mockUseCase;

    setUp(() {
      mockUseCase = MockRespondToChallengeUseCase();
    });

    test('39. Initial state is ChallengeResponseInitial', () {
      final cubit = ChallengeResponseCubit(respondToChallengeUseCase: mockUseCase);
      expect(cubit.state, const ChallengeResponseState.initial());
      cubit.close();
    });

    test('40. accept emits [loading, success]', () async {
      final cubit = ChallengeResponseCubit(respondToChallengeUseCase: mockUseCase);
      final challenge = testChallenge(status: ChallengeStatus.accepted);
      when(() => mockUseCase.accept('ch-1', 't-1')).thenAnswer((_) async => ApiResult.success(challenge));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const ChallengeResponseState.loading(),
          ChallengeResponseState.success(challenge, ChallengeResponseAction.accept),
        ]),
      );

      await cubit.accept('ch-1', 't-1');
      cubit.close();
    });

    test('41. decline emits [loading, success]', () async {
      final cubit = ChallengeResponseCubit(respondToChallengeUseCase: mockUseCase);
      final challenge = testChallenge(status: ChallengeStatus.declined);
      when(() => mockUseCase.decline('ch-1', 't-1')).thenAnswer((_) async => ApiResult.success(challenge));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const ChallengeResponseState.loading(),
          ChallengeResponseState.success(challenge, ChallengeResponseAction.decline),
        ]),
      );

      await cubit.decline('ch-1', 't-1');
      cubit.close();
    });

    test('42. counterPropose emits [loading, success]', () async {
      final cubit = ChallengeResponseCubit(respondToChallengeUseCase: mockUseCase);
      final date = DateTime.utc(2026, 5, 2, 20);
      final challenge = testChallenge(status: ChallengeStatus.counterProposed);
      when(() => mockUseCase.counterPropose('ch-1', 't-1', proposedUtc: date, durationMinutes: 90))
          .thenAnswer((_) async => ApiResult.success(challenge));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const ChallengeResponseState.loading(),
          ChallengeResponseState.success(challenge, ChallengeResponseAction.counterPropose),
        ]),
      );

      await cubit.counterPropose('ch-1', 't-1', proposedUtc: date, durationMinutes: 90);
      cubit.close();
    });

    test('43. counterPropose emits [loading, error] on validation failure', () async {
      final cubit = ChallengeResponseCubit(respondToChallengeUseCase: mockUseCase);
      final date = DateTime.utc(2026, 5, 2, 20);
      when(() => mockUseCase.counterPropose(any(), any(), proposedUtc: any(named: 'proposedUtc'), durationMinutes: any(named: 'durationMinutes')))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.matches.invalid_duration')));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const ChallengeResponseState.loading(),
          const ChallengeResponseState.error('errors.matches.invalid_duration'),
        ]),
      );

      await cubit.counterPropose('ch-1', 't-1', proposedUtc: date, durationMinutes: 10);
      cubit.close();
    });
  });

  group('MatchDetailsCubit & ChallengeDetailsCubit Tests', () {
    late MockGetMatchDetailsUseCase mockMatchUseCase;
    late MockGetChallengeDetailsUseCase mockChallengeUseCase;

    setUp(() {
      mockMatchUseCase = MockGetMatchDetailsUseCase();
      mockChallengeUseCase = MockGetChallengeDetailsUseCase();
    });

    test('44. MatchDetailsCubit initial state is MatchDetailsInitial', () {
      final cubit = MatchDetailsCubit(getMatchDetailsUseCase: mockMatchUseCase);
      expect(cubit.state, const MatchDetailsState.initial());
      cubit.close();
    });

    test('45. MatchDetailsCubit load emits [loading, success]', () async {
      final cubit = MatchDetailsCubit(getMatchDetailsUseCase: mockMatchUseCase);
      final details = MatchDetailsModel(match: testMatch(), myTeam: myTeam);
      when(() => mockMatchUseCase('m-1')).thenAnswer((_) async => ApiResult.success(details));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const MatchDetailsState.loading(),
          MatchDetailsState.success(details),
        ]),
      );

      await cubit.load('m-1');
      cubit.close();
    });

    test('46. MatchDetailsCubit load emits [loading, error] on failure', () async {
      final cubit = MatchDetailsCubit(getMatchDetailsUseCase: mockMatchUseCase);
      when(() => mockMatchUseCase('m-err'))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.not_found')));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const MatchDetailsState.loading(),
          const MatchDetailsState.error('errors.not_found'),
        ]),
      );

      await cubit.load('m-err');
      cubit.close();
    });

    test('47. ChallengeDetailsCubit initial state is ChallengeDetailsInitial', () {
      final cubit = ChallengeDetailsCubit(getChallengeDetailsUseCase: mockChallengeUseCase);
      expect(cubit.state, const ChallengeDetailsState.initial());
      cubit.close();
    });

    test('48. ChallengeDetailsCubit load emits [loading, success]', () async {
      final cubit = ChallengeDetailsCubit(getChallengeDetailsUseCase: mockChallengeUseCase);
      final details = ChallengeDetailsModel(challenge: testChallenge(), myTeam: myTeam);
      when(() => mockChallengeUseCase('ch-1')).thenAnswer((_) async => ApiResult.success(details));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const ChallengeDetailsState.loading(),
          ChallengeDetailsState.success(details),
        ]),
      );

      await cubit.load('ch-1');
      cubit.close();
    });

    test('49. ChallengeDetailsCubit load emits [loading, error] on failure', () async {
      final cubit = ChallengeDetailsCubit(getChallengeDetailsUseCase: mockChallengeUseCase);
      when(() => mockChallengeUseCase('ch-err'))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.not_found')));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const ChallengeDetailsState.loading(),
          const ChallengeDetailsState.error('errors.not_found'),
        ]),
      );

      await cubit.load('ch-err');
      cubit.close();
    });
  });

  group('Matches Extra Edge Cases Tests', () {
    late MockSendChallengeUseCase mockUseCase;
    late MockRespondToChallengeUseCase mockRespondUseCase;
    late MockGetMatchDetailsUseCase mockMatchUseCase;
    late MockGetChallengeDetailsUseCase mockChallengeUseCase;

    setUp(() {
      mockUseCase = MockSendChallengeUseCase();
      mockRespondUseCase = MockRespondToChallengeUseCase();
      mockMatchUseCase = MockGetMatchDetailsUseCase();
      mockChallengeUseCase = MockGetChallengeDetailsUseCase();
    });

    test('50. MatchModel handles null venueName and bookingId', () {
      final match = testMatch(id: 'm-null');
      expect(match.venueName, isNull);
      expect(match.bookingId, isNull);
    });

    test('51. MatchModel disputeReason and notes can be null', () {
      final match = testMatch();
      expect(match.disputeReason, isNull);
      expect(match.notes, isNull);
    });

    test('52. MatchModel handles positive scores', () {
      final match = testMatch(homeScore: 5, awayScore: 4);
      expect(match.homeScore, 5);
      expect(match.awayScore, 4);
    });

    test('53. MatchModel handles 0-0 draw', () {
      final match = testMatch(homeTeamId: 't1', homeScore: 0, awayScore: 0, status: MatchModel.completed);
      expect(match.resultFor('t1'), MatchResultForTeam.draw);
    });

    test('54. TeamChallengeModel notes null vs present', () {
      final c1 = testChallenge();
      expect(c1.notes, isNull);
      final json = c1.toJson();
      expect(json['notes'], isNull);
    });

    test('55. TeamChallengeModel declinedReason is parsed', () {
      final json = {
        'id': 'ch-d',
        'challengerTeamId': 't1',
        'challengedTeamId': 't2',
        'proposedDateUtc': '2026-05-01T12:00:00Z',
        'proposedDurationMinutes': 60,
        'status': 4, // declined
        'currentTurnTeamId': 't1',
        'isMyTurn': false,
        'declinedReason': 'Unavailable pitch',
      };
      final ch = TeamChallengeModel.fromJson(json);
      expect(ch.status, ChallengeStatus.declined);
      expect(ch.declinedReason, 'Unavailable pitch');
    });

    test('56. TeamChallengeModel matchId is parsed when accepted', () {
      final json = {
        'id': 'ch-a',
        'challengerTeamId': 't1',
        'challengedTeamId': 't2',
        'proposedDateUtc': '2026-05-01T12:00:00Z',
        'proposedDurationMinutes': 60,
        'status': 3, // accepted
        'currentTurnTeamId': 't1',
        'isMyTurn': false,
        'matchId': 'match-123',
      };
      final ch = TeamChallengeModel.fromJson(json);
      expect(ch.matchId, 'match-123');
    });

    test('57. ChallengeResponseAction enum values', () {
      expect(ChallengeResponseAction.values, contains(ChallengeResponseAction.accept));
      expect(ChallengeResponseAction.values, contains(ChallengeResponseAction.decline));
      expect(ChallengeResponseAction.values, contains(ChallengeResponseAction.counterPropose));
    });

    test('58. MatchVerificationAction enum values', () {
      expect(MatchVerificationAction.values, contains(MatchVerificationAction.confirm));
      expect(MatchVerificationAction.values, contains(MatchVerificationAction.dispute));
    });

    test('59. MatchDetailsModel canSubmitResult is false when match is already Completed', () {
      final past = DateTime.utc(2026, 1, 1);
      final match = testMatch(startUtc: past, status: MatchModel.completed, resultStatus: 'Confirmed');
      final details = MatchDetailsModel(match: match, myTeam: myTeam);
      expect(details.canSubmitResult(DateTime.utc(2026, 1, 2)), isFalse);
    });

    test('60. MatchDetailsModel canVerifyResult is false when result is already Confirmed', () {
      final match = testMatch(
        homeTeamId: 'team-1',
        awayTeamId: 'team-2',
        resultStatus: 'Confirmed',
        submittedBy: 'team-1',
      );
      final opponentLeader = _teamSummary(id: 'team-2', name: 'Falcons', myRole: 1);
      final details = MatchDetailsModel(match: match, myTeam: opponentLeader);
      expect(details.canVerifyResult, isFalse);
    });

    test('61. SendChallengeCubit safe when closed during turn', () async {
      final cubit = SendChallengeCubit(sendChallengeUseCase: mockUseCase);
      when(() => mockUseCase(any())).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        return ApiResult.success(testChallenge());
      });

      final f = cubit.send(SendChallengeRequestBody(
        challengerTeamId: '1',
        challengedTeamId: '2',
        proposedDateUtc: DateTime.utc(2026, 1, 1),
        durationMinutes: 60,
      ));
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });

    test('62. ChallengeResponseCubit safe when closed during turn', () async {
      final cubit = ChallengeResponseCubit(respondToChallengeUseCase: mockRespondUseCase);
      when(() => mockRespondUseCase.accept(any(), any())).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        return ApiResult.success(testChallenge());
      });

      final f = cubit.accept('1', '2');
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });

    test('63. MatchDetailsCubit safe when closed during turn', () async {
      final cubit = MatchDetailsCubit(getMatchDetailsUseCase: mockMatchUseCase);
      when(() => mockMatchUseCase(any())).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        return ApiResult.success(MatchDetailsModel(match: testMatch()));
      });

      final f = cubit.load('1');
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });

    test('64. ChallengeDetailsCubit safe when closed during turn', () async {
      final cubit = ChallengeDetailsCubit(getChallengeDetailsUseCase: mockChallengeUseCase);
      when(() => mockChallengeUseCase(any())).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        return ApiResult.success(ChallengeDetailsModel(challenge: testChallenge()));
      });

      final f = cubit.load('1');
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });

    test('65. ChallengeDetailsModel canRespond is false when challenge is closed', () {
      final closedChallenge = testChallenge(
        status: ChallengeStatus.accepted,
        isMyTurn: true,
        currentTurnTeamId: testTeamId,
      );
      final details = ChallengeDetailsModel(challenge: closedChallenge, myTeam: myTeam);
      expect(details.canRespond, isFalse);
    });

    test('66. ChallengeDetailsModel canRespond is false when myTeam is null', () {
      final challenge = testChallenge(
        status: ChallengeStatus.pending,
        isMyTurn: true,
        currentTurnTeamId: testTeamId,
      );
      final details = ChallengeDetailsModel(challenge: challenge, myTeam: null);
      expect(details.canRespond, isFalse);
    });

    test('67. MatchDetailsModel canSubmitResult is false when myTeam is null', () {
      final pastStart = DateTime.utc(2026, 1, 1);
      final match = testMatch(startUtc: pastStart, status: MatchModel.inProgress);
      final details = MatchDetailsModel(match: match, myTeam: null);
      expect(details.canSubmitResult(DateTime.utc(2026, 1, 2)), isFalse);
    });

    test('68. MatchDetailsModel canVerifyResult is false when myTeam is null', () {
      final match = testMatch(resultStatus: MatchModel.resultPending, submittedBy: 't1');
      final details = MatchDetailsModel(match: match, myTeam: null);
      expect(details.canVerifyResult, isFalse);
    });

    test('69. MatchModel Scheduled static constant', () {
      expect(MatchModel.scheduled, 'Scheduled');
    });

    test('70. MatchModel InProgress static constant', () {
      expect(MatchModel.inProgress, 'InProgress');
    });

    test('71. MatchModel Completed static constant', () {
      expect(MatchModel.completed, 'Completed');
    });

    test('72. MatchModel Disputed static constant', () {
      expect(MatchModel.disputed, 'Disputed');
    });

    test('73. MatchModel Cancelled static constant', () {
      expect(MatchModel.cancelled, 'Cancelled');
    });

    test('74. MatchModel ResultNone static constant', () {
      expect(MatchModel.resultNone, 'None');
    });

    test('75. MatchModel ResultPending static constant', () {
      expect(MatchModel.resultPending, 'PendingVerification');
    });

    test('76. MatchModel ResultDisputed static constant', () {
      expect(MatchModel.resultDisputed, 'Disputed');
    });

    test('77. ChallengeScheduleRules minDurationMinutes is 30', () {
      expect(ChallengeScheduleRules.minDurationMinutes, 30);
    });

    test('78. ChallengeScheduleRules maxDurationMinutes is 180', () {
      expect(ChallengeScheduleRules.maxDurationMinutes, 180);
    });

    test('79. SendChallengeRequestBody drop blank notes', () {
      final body = SendChallengeRequestBody(
        challengerTeamId: '1',
        challengedTeamId: '2',
        proposedDateUtc: DateTime.utc(2026, 1, 1),
        durationMinutes: 60,
        notes: '   ',
      );
      expect(body.notes?.trim(), isEmpty);
    });

    test('80. SendChallengeState initial Equatable check', () {
      const s1 = SendChallengeState.initial();
      const s2 = SendChallengeState.initial();
      expect(s1, equals(s2));
    });

    test('81. SendChallengeState loading Equatable check', () {
      const s1 = SendChallengeState.loading();
      const s2 = SendChallengeState.loading();
      expect(s1, equals(s2));
    });

    test('82. SendChallengeState error message retrieval', () {
      const s = SendChallengeState.error('challenge_err');
      expect((s as SendChallengeError).message, 'challenge_err');
    });

    test('83. ChallengeResponseState initial Equatable check', () {
      const s1 = ChallengeResponseState.initial();
      const s2 = ChallengeResponseState.initial();
      expect(s1, equals(s2));
    });

    test('84. ChallengeResponseState loading Equatable check', () {
      const s1 = ChallengeResponseState.loading();
      const s2 = ChallengeResponseState.loading();
      expect(s1, equals(s2));
    });

    test('85. ChallengeResponseState error message check', () {
      const s = ChallengeResponseState.error('err');
      expect((s as ChallengeResponseError).message, 'err');
    });

    test('86. MatchDetailsState initial Equatable check', () {
      const s1 = MatchDetailsState.initial();
      const s2 = MatchDetailsState.initial();
      expect(s1, equals(s2));
    });

    test('87. MatchDetailsState loading Equatable check', () {
      const s1 = MatchDetailsState.loading();
      const s2 = MatchDetailsState.loading();
      expect(s1, equals(s2));
    });

    test('88. MatchDetailsState error message retrieval', () {
      const s = MatchDetailsState.error('match_err');
      expect((s as MatchDetailsError).message, 'match_err');
    });

    test('89. ChallengeDetailsState initial Equatable check', () {
      const s1 = ChallengeDetailsState.initial();
      const s2 = ChallengeDetailsState.initial();
      expect(s1, equals(s2));
    });

    test('90. ChallengeDetailsState error message retrieval', () {
      const s = ChallengeDetailsState.error('challenge_details_err');
      expect((s as ChallengeDetailsError).message, 'challenge_details_err');
    });
  });
}
