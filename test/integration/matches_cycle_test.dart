@Tags(['integration'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/matches/data/models/match_model.dart';
import 'package:mal3abk/features/matches/data/models/respond_to_challenge_request_body.dart';
import 'package:mal3abk/features/matches/data/models/send_challenge_request_body.dart';
import 'package:mal3abk/features/matches/data/models/team_challenge_model.dart';
import 'package:mal3abk/features/matches/data/models/verify_match_result_request_body.dart';
import 'package:mal3abk/features/teams/data/models/team_detail_model.dart';

import 'support/local_stack.dart';

/// Challenges and matches end to end, two real teams against the local
/// stack: challenge, counter, accept, the match on both calendars, result,
/// confirmation or dispute, and the notification each step sends to the
/// other captain.
///
///     flutter test test/integration/matches_cycle_test.dart
void main() {
  late bool stackUp;
  setUpAll(() async => stackUp = await LocalStack.start());

  late LocalPlayer homeCaptain;
  late LocalPlayer awayCaptain;
  late TeamDetailModel home;
  late TeamDetailModel away;

  setUp(() async {
    if (!stackUp) return;
    final players = await Future.wait([
      LocalStack.newPlayer('Home Captain'),
      LocalStack.newPlayer('Away Captain'),
    ]);
    homeCaptain = players[0];
    awayCaptain = players[1];
    home = await LocalStack.createTeam(homeCaptain);
    away = await LocalStack.createTeam(awayCaptain);
  });

  DateTime kickOff([int hours = 26]) =>
      DateTime.now().toUtc().add(Duration(hours: hours));

  Future<TeamChallengeModel> challenge({DateTime? at}) async => ok(
    await homeCaptain.matches.sendChallenge(
      SendChallengeRequestBody(
        challengerTeamId: home.id,
        challengedTeamId: away.id,
        proposedDateUtc: at ?? kickOff(),
        durationMinutes: 60,
        proposedVenueName: 'Cycle Arena',
      ),
    ),
    'send challenge',
  );

  /// Challenge then accept; returns the scheduled match.
  Future<MatchModel> scheduledMatch() async {
    final sent = await challenge();
    final accepted = ok(
      await awayCaptain.matches.respondToChallenge(
        sent.id,
        RespondToChallengeRequestBody(
          respondingTeamId: away.id,
          action: ChallengeResponseAction.accept,
        ),
      ),
      'accept challenge',
    );
    expect(accepted.matchId, isNotNull);
    return ok(
      await homeCaptain.matches.getMatch(accepted.matchId!),
      'read match',
    );
  }

  group('matches cycle', () {
    test('challenge, counter, accept: the match lands on both calendars, '
        'each step notifies the other captain', () async {
      if (!LocalStack.ready(stackUp)) return;

      final sent = await challenge();
      expect(sent.status, ChallengeStatus.pending);
      expect(sent.isMyTurn, isFalse, reason: 'the challenged team answers');
      final received = await LocalStack.notificationFor(
        awayCaptain,
        'team.challenge_received',
      );
      expect(received.deepLink, isNotNull);

      final seenByAway = ok(
        await awayCaptain.matches.getChallenge(sent.id),
        'away reads challenge',
      );
      expect(seenByAway.isMyTurn, isTrue);

      // Away proposes another time; the turn goes back to home.
      final countered = ok(
        await awayCaptain.matches.respondToChallenge(
          sent.id,
          RespondToChallengeRequestBody(
            respondingTeamId: away.id,
            action: ChallengeResponseAction.counterPropose,
            newProposedDateUtc: kickOff(50),
            newDurationMinutes: 90,
          ),
        ),
        'counter-propose',
      );
      expect(countered.status, ChallengeStatus.counterProposed);
      await LocalStack.notificationFor(homeCaptain, 'team.challenge_countered');

      // Away cannot answer again while it is home's turn.
      final outOfTurn = await awayCaptain.matches.respondToChallenge(
        sent.id,
        RespondToChallengeRequestBody(
          respondingTeamId: away.id,
          action: ChallengeResponseAction.accept,
        ),
      );
      expect(failureCode(outOfTurn), isNotEmpty);

      final accepted = ok(
        await homeCaptain.matches.respondToChallenge(
          sent.id,
          RespondToChallengeRequestBody(
            respondingTeamId: home.id,
            action: ChallengeResponseAction.accept,
          ),
        ),
        'home accepts the counter',
      );
      expect(accepted.status, ChallengeStatus.accepted);
      expect(accepted.matchId, isNotNull);
      await LocalStack.notificationFor(awayCaptain, 'team.challenge_accepted');

      final match = ok(
        await homeCaptain.matches.getMatch(accepted.matchId!),
        'read match',
      );
      expect(match.status, MatchModel.scheduled);
      expect(match.durationMinutes, 90, reason: 'the countered terms win');
      expect({match.homeTeamId, match.awayTeamId}, {home.id, away.id});

      for (final (captain, team) in [
        (homeCaptain, home),
        (awayCaptain, away),
      ]) {
        final upcoming = ok(
          await captain.matches.getUpcomingMatches(teamId: team.id),
          '${captain.name} upcoming',
        );
        expect(upcoming.items.map((m) => m.id), contains(match.id));
      }
    });

    test(
      'a declined challenge makes no match and tells the challenger',
      () async {
        if (!LocalStack.ready(stackUp)) return;
        final sent = await challenge();

        final declined = ok(
          await awayCaptain.matches.respondToChallenge(
            sent.id,
            RespondToChallengeRequestBody(
              respondingTeamId: away.id,
              action: ChallengeResponseAction.decline,
              declineReason: 'Busy that day',
            ),
          ),
          'decline',
        );
        expect(declined.status, ChallengeStatus.declined);
        expect(declined.matchId, isNull);
        await LocalStack.notificationFor(
          homeCaptain,
          'team.challenge_declined',
        );

        final upcoming = ok(
          await homeCaptain.matches.getUpcomingMatches(teamId: home.id),
          'upcoming',
        );
        expect(upcoming.items, isEmpty);
      },
    );

    test(
      'result: one side submits, the other confirms, both are told',
      () async {
        if (!LocalStack.ready(stackUp)) return;
        final match = await scheduledMatch();
        final (
          submitter,
          submitterTeam,
          verifier,
          verifierTeam,
        ) = match.homeTeamId == home.id
            ? (homeCaptain, home, awayCaptain, away)
            : (awayCaptain, away, homeCaptain, home);

        final submitted = ok(
          await submitter.matches.submitResult(
            match.id,
            teamId: submitterTeam.id,
            homeScore: 3,
            awayScore: 1,
          ),
          'submit result',
        );
        expect(submitted.resultStatus, MatchModel.resultPending);
        await LocalStack.notificationFor(verifier, 'match.result_submitted');

        // The team that submitted cannot confirm its own result.
        final selfConfirm = await submitter.matches.verifyResult(
          match.id,
          teamId: submitterTeam.id,
          action: MatchVerificationAction.confirm,
        );
        expect(failureCode(selfConfirm), isNotEmpty);

        final confirmed = ok(
          await verifier.matches.verifyResult(
            match.id,
            teamId: verifierTeam.id,
            action: MatchVerificationAction.confirm,
          ),
          'confirm result',
        );
        expect(confirmed.status, MatchModel.completed);
        expect(confirmed.homeScore, 3);
        expect(confirmed.awayScore, 1);

        await LocalStack.notificationFor(homeCaptain, 'match.result_confirmed');
        await LocalStack.notificationFor(awayCaptain, 'match.result_confirmed');

        final history = ok(
          await homeCaptain.matches.getMatchHistory(teamId: home.id),
          'history',
        );
        expect(history.items.map((m) => m.id), contains(match.id));
        final upcoming = ok(
          await homeCaptain.matches.getUpcomingMatches(teamId: home.id),
          'upcoming',
        );
        expect(upcoming.items.map((m) => m.id), isNot(contains(match.id)));
      },
    );

    test('result: a dispute is recorded and the submitter is told', () async {
      if (!LocalStack.ready(stackUp)) return;
      final match = await scheduledMatch();
      final (
        submitter,
        submitterTeam,
        verifier,
        verifierTeam,
      ) = match.homeTeamId == home.id
          ? (homeCaptain, home, awayCaptain, away)
          : (awayCaptain, away, homeCaptain, home);

      ok(
        await submitter.matches.submitResult(
          match.id,
          teamId: submitterTeam.id,
          homeScore: 2,
          awayScore: 0,
        ),
        'submit result',
      );
      final disputed = ok(
        await verifier.matches.verifyResult(
          match.id,
          teamId: verifierTeam.id,
          action: MatchVerificationAction.dispute,
          disputeReason: 'It was 2-2',
        ),
        'dispute',
      );
      expect(disputed.resultStatus, MatchModel.resultDisputed);
      await LocalStack.notificationFor(submitter, 'match.result_disputed');

      // A disputed result cannot be submitted over.
      final again = await submitter.matches.submitResult(
        match.id,
        teamId: submitterTeam.id,
        homeScore: 5,
        awayScore: 0,
      );
      expect(failureCode(again), isNotEmpty);
    });

    test('the rules: own team, past date, outsiders, plain members', () async {
      if (!LocalStack.ready(stackUp)) return;

      final ownTeam = await homeCaptain.matches.sendChallenge(
        SendChallengeRequestBody(
          challengerTeamId: home.id,
          challengedTeamId: home.id,
          proposedDateUtc: kickOff(),
          durationMinutes: 60,
        ),
      );
      expect(failureCode(ownTeam), isNotEmpty, reason: 'own team');

      final past = await homeCaptain.matches.sendChallenge(
        SendChallengeRequestBody(
          challengerTeamId: home.id,
          challengedTeamId: away.id,
          proposedDateUtc: DateTime.now().toUtc().subtract(
            const Duration(hours: 1),
          ),
          durationMinutes: 60,
        ),
      );
      expect(failureCode(past), isNotEmpty, reason: 'past date');

      // Someone who does not lead the team cannot challenge in its name.
      final outsider = await LocalStack.newPlayer('Outsider');
      final forged = await outsider.matches.sendChallenge(
        SendChallengeRequestBody(
          challengerTeamId: home.id,
          challengedTeamId: away.id,
          proposedDateUtc: kickOff(),
          durationMinutes: 60,
        ),
      );
      expect(failureCode(forged), isNotEmpty, reason: 'outsider');

      // An outsider cannot answer a challenge for the challenged team.
      final sent = await challenge();
      final hijack = await outsider.matches.respondToChallenge(
        sent.id,
        RespondToChallengeRequestBody(
          respondingTeamId: away.id,
          action: ChallengeResponseAction.accept,
        ),
      );
      expect(failureCode(hijack), isNotEmpty, reason: 'outsider answers');

      // A plain member cannot submit a result for their team.
      final member = await LocalStack.newPlayer('Plain Member');
      ok(await member.teams.acceptInvitation(home.inviteCode!), 'member joins');
      final accepted = ok(
        await awayCaptain.matches.respondToChallenge(
          sent.id,
          RespondToChallengeRequestBody(
            respondingTeamId: away.id,
            action: ChallengeResponseAction.accept,
          ),
        ),
        'accept',
      );
      final memberResult = await member.matches.submitResult(
        accepted.matchId!,
        teamId: home.id,
        homeScore: 9,
        awayScore: 0,
      );
      expect(failureCode(memberResult), isNotEmpty, reason: 'plain member');
    });
  });
}
