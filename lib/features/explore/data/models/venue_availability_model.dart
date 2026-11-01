import 'package:json_annotation/json_annotation.dart';

part 'venue_availability_model.g.dart';

@JsonSerializable()
class SlotModel {
  const SlotModel({
    required this.startUtc,
    required this.endUtc,
    required this.startLocal,
    required this.endLocal,
    required this.state,
    this.price,
  });

  final String startUtc;
  final String endUtc;
  final String startLocal;
  final String endLocal;
  final int state;
  final double? price;

  bool get isAvailable => state == 0;

  factory SlotModel.fromJson(Map<String, dynamic> json) =>
      _$SlotModelFromJson(json);

  Map<String, dynamic> toJson() => _$SlotModelToJson(this);
}

@JsonSerializable()
class PitchSlotsModel {
  const PitchSlotsModel({
    required this.pitchId,
    required this.name,
    required this.slotMinutes,
    required this.incrementMinutes,
    this.slots = const [],
  });

  final String pitchId;
  final String name;
  final int slotMinutes;
  final int incrementMinutes;
  final List<SlotModel> slots;

  factory PitchSlotsModel.fromJson(Map<String, dynamic> json) =>
      _$PitchSlotsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PitchSlotsModelToJson(this);
}

@JsonSerializable()
class VenueAvailabilityModel {
  const VenueAvailabilityModel({
    required this.venueId,
    required this.businessDate,
    required this.currency,
    this.pitches = const [],
    required this.generatedAtUtc,
    this.nextChangeUtc,
  });

  final String venueId;
  final String businessDate;
  final String currency;
  final List<PitchSlotsModel> pitches;
  final String generatedAtUtc;
  final String? nextChangeUtc;

  factory VenueAvailabilityModel.fromJson(Map<String, dynamic> json) =>
      _$VenueAvailabilityModelFromJson(json);

  Map<String, dynamic> toJson() => _$VenueAvailabilityModelToJson(this);
}
