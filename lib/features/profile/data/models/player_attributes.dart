import 'package:json_annotation/json_annotation.dart';

/// Server `PlayerPosition`: sent as its number, returned as its name.
enum PlayerPosition {
  @JsonValue(0)
  goalkeeper('Goalkeeper'),
  @JsonValue(1)
  defender('Defender'),
  @JsonValue(2)
  midfielder('Midfielder'),
  @JsonValue(3)
  forward('Forward');

  const PlayerPosition(this.serverName);

  final String serverName;

  static PlayerPosition? fromServerName(String name) =>
      values.where((p) => p.serverName == name).firstOrNull;
}

/// Server `SkillLevel`: sent as its number, returned as its name.
enum SkillLevel {
  @JsonValue(0)
  beginner('Beginner'),
  @JsonValue(1)
  intermediate('Intermediate'),
  @JsonValue(2)
  advanced('Advanced');

  const SkillLevel(this.serverName);

  final String serverName;

  static SkillLevel? fromServerName(String? name) =>
      values.where((s) => s.serverName == name).firstOrNull;
}
