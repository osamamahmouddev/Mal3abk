import 'package:json_annotation/json_annotation.dart';

part 'venue_pitch_model.g.dart';

/// A pitch of a managed venue (`PitchDto`).
@JsonSerializable(createToJson: false)
class VenuePitchModel {
  const VenuePitchModel({
    required this.id,
    required this.venueId,
    required this.name,
    required this.turfType,
    required this.capacity,
    required this.format,
    required this.isActive,
    this.surfaceArabicDisplayName = '',
    this.surfaceDisplayName = '',
    this.lengthMeters,
    this.widthMeters,
    this.photos = const [],
  });

  final String id;
  final String venueId;
  final String name;
  final String turfType;
  final String surfaceDisplayName;
  final String surfaceArabicDisplayName;
  final int capacity;

  /// `FiveASide`, `SevenASide`, `ElevenASide`.
  final String format;
  final double? lengthMeters;
  final double? widthMeters;
  final bool isActive;
  final List<String> photos;

  factory VenuePitchModel.fromJson(Map<String, dynamic> json) =>
      _$VenuePitchModelFromJson(json);
}
