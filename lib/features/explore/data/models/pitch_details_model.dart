import 'package:json_annotation/json_annotation.dart';
import 'localized_item_model.dart';
import 'opening_hours_day_model.dart';

part 'pitch_details_model.g.dart';

@JsonSerializable()
class PitchDetailsModel {
  const PitchDetailsModel({
    required this.pitchId,
    required this.name,
    required this.pitchType,
    required this.playersPerTeam,
    required this.surface,
    this.lengthMeters,
    this.widthMeters,
    this.photos = const [],
    this.baseHourlyPrice,
    this.currency = 'EGP',
    this.customHours,
  });

  final String pitchId;
  final String name;
  final String pitchType;
  final int playersPerTeam;
  final LocalizedItemModel surface;
  final double? lengthMeters;
  final double? widthMeters;
  final List<String> photos;
  final double? baseHourlyPrice;
  final String currency;
  final List<OpeningHoursDayModel>? customHours;

  factory PitchDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PitchDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PitchDetailsModelToJson(this);
}
