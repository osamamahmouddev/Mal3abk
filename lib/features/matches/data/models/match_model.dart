import 'package:json_annotation/json_annotation.dart';

part 'match_model.g.dart';

enum MatchResultForTeam { win, draw, loss, pending }

@JsonSerializable()
class MatchModel {
  const MatchModel({
    required this.id,
    this.challengeId,
    required this.homeTeamId,
    required this.homeTeamName,
    required this.awayTeamId,
    required this.awayTeamName,
    this.venueName,
    required this.scheduledStartUtc,
    required this.scheduledEndUtc,
    required this.durationMinutes,
    this.bookingId,
    required this.status,
    required this.outcome,
    this.homeScore,
    this.awayScore,
    required this.resultStatus,
    this.resultSubmittedByTeamId,
    this.disputeReason,
    this.notes,
  });

  static const String scheduled = 'Scheduled';
  static const String inProgress = 'InProgress';
  static const String completed = 'Completed';
  static const String disputed = 'Disputed';
  static const String cancelled = 'Cancelled';
  static const String resultNone = 'None';
  static const String resultPending = 'PendingVerification';
  static const String resultDisputed = 'Disputed';

  final String id;
  final String? challengeId;
  final String homeTeamId;
  final String homeTeamName;
  final String awayTeamId;
  final String awayTeamName;
  final String? venueName;
  final DateTime scheduledStartUtc;
  final DateTime scheduledEndUtc;
  final int durationMinutes;
  final String? bookingId;
  final String status;
  final String outcome;
  final int? homeScore;
  final int? awayScore;
  final String resultStatus;
  final String? resultSubmittedByTeamId;
  final String? disputeReason;
  final String? notes;

  bool get isClosed => status == completed || status == cancelled;
  bool get isAwaitingResult => !isClosed && resultStatus == resultNone;
  bool get isPendingVerification => resultStatus == resultPending;
  bool get isDisputed => status == disputed || resultStatus == resultDisputed;
  bool get hasScore => homeScore != null && awayScore != null;

  bool involves(String teamId) => teamId == homeTeamId || teamId == awayTeamId;

  String opponentName(String teamId) =>
      teamId == homeTeamId ? awayTeamName : homeTeamName;

  /// Result from [teamId]'s side; pending until the result is confirmed.
  MatchResultForTeam resultFor(String teamId) {
    final home = homeScore;
    final away = awayScore;
    if (status != completed || home == null || away == null) {
      return MatchResultForTeam.pending;
    }
    final mine = teamId == homeTeamId ? home : away;
    final theirs = teamId == homeTeamId ? away : home;
    if (mine == theirs) return MatchResultForTeam.draw;
    return mine > theirs ? MatchResultForTeam.win : MatchResultForTeam.loss;
  }

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchModelToJson(this);
}
