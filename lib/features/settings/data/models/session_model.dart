import 'package:json_annotation/json_annotation.dart';

part 'session_model.g.dart';

@JsonSerializable()
class SessionModel {
  const SessionModel({
    required this.sessionId,
    this.deviceName,
    required this.ipAddress,
    required this.userAgent,
    required this.createdAtUtc,
    required this.lastActivityAtUtc,
    required this.isCurrent,
  });

  final String sessionId;
  final String? deviceName;
  final String ipAddress;
  final String userAgent;
  final DateTime createdAtUtc;
  final DateTime lastActivityAtUtc;
  final bool isCurrent;

  String get displayName =>
      (deviceName?.trim().isNotEmpty ?? false) ? deviceName! : userAgent;

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}
