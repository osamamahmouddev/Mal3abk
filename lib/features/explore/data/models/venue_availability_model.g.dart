// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_availability_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlotModel _$SlotModelFromJson(Map<String, dynamic> json) => SlotModel(
  startUtc: json['startUtc'] as String,
  endUtc: json['endUtc'] as String,
  startLocal: json['startLocal'] as String,
  endLocal: json['endLocal'] as String,
  state: (json['state'] as num).toInt(),
  price: (json['price'] as num?)?.toDouble(),
);

Map<String, dynamic> _$SlotModelToJson(SlotModel instance) => <String, dynamic>{
  'startUtc': instance.startUtc,
  'endUtc': instance.endUtc,
  'startLocal': instance.startLocal,
  'endLocal': instance.endLocal,
  'state': instance.state,
  'price': instance.price,
};

PitchSlotsModel _$PitchSlotsModelFromJson(Map<String, dynamic> json) =>
    PitchSlotsModel(
      pitchId: json['pitchId'] as String,
      name: json['name'] as String,
      slotMinutes: (json['slotMinutes'] as num).toInt(),
      incrementMinutes: (json['incrementMinutes'] as num).toInt(),
      slots:
          (json['slots'] as List<dynamic>?)
              ?.map((e) => SlotModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PitchSlotsModelToJson(PitchSlotsModel instance) =>
    <String, dynamic>{
      'pitchId': instance.pitchId,
      'name': instance.name,
      'slotMinutes': instance.slotMinutes,
      'incrementMinutes': instance.incrementMinutes,
      'slots': instance.slots,
    };

VenueAvailabilityModel _$VenueAvailabilityModelFromJson(
  Map<String, dynamic> json,
) => VenueAvailabilityModel(
  venueId: json['venueId'] as String,
  businessDate: json['businessDate'] as String,
  currency: json['currency'] as String,
  pitches:
      (json['pitches'] as List<dynamic>?)
          ?.map((e) => PitchSlotsModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  generatedAtUtc: json['generatedAtUtc'] as String,
  nextChangeUtc: json['nextChangeUtc'] as String?,
);

Map<String, dynamic> _$VenueAvailabilityModelToJson(
  VenueAvailabilityModel instance,
) => <String, dynamic>{
  'venueId': instance.venueId,
  'businessDate': instance.businessDate,
  'currency': instance.currency,
  'pitches': instance.pitches,
  'generatedAtUtc': instance.generatedAtUtc,
  'nextChangeUtc': instance.nextChangeUtc,
};
