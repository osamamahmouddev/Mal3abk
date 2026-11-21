// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueOfferModel _$VenueOfferModelFromJson(Map<String, dynamic> json) =>
    VenueOfferModel(
      name: json['name'] as String,
      type: json['type'] as String,
      value: (json['value'] as num).toDouble(),
      endsOn: json['endsOn'] as String?,
      hasConditions: json['hasConditions'] as bool? ?? false,
      fromHourlyPriceAfter: (json['fromHourlyPriceAfter'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VenueOfferModelToJson(VenueOfferModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'value': instance.value,
      'endsOn': instance.endsOn,
      'hasConditions': instance.hasConditions,
      'fromHourlyPriceAfter': instance.fromHourlyPriceAfter,
    };
