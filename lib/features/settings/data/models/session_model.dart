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

  static final RegExp _appAgent = RegExp(r'^Malabak/\S+ \(([^)]+)\)');

  /// Make and model the app reported, e.g. "Samsung SM-S911B".
  String? get deviceLabel {
    final name = deviceName?.trim();
    return (name == null || name.isEmpty) ? null : name;
  }

  /// "Android 14" from the app's own user agent; null for other clients
  /// (older app builds sent the bare "Dart/3.x (dart:io)").
  String? get platformLabel => _appAgent.firstMatch(userAgent)?.group(1);

  bool get isApple {
    final text = '${deviceName ?? ''} $userAgent'.toLowerCase();
    return text.contains('iphone') ||
        text.contains('ipad') ||
        text.contains('ios');
  }

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}
