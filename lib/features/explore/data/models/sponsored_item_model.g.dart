// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsored_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SponsoredItemModel _$SponsoredItemModelFromJson(Map<String, dynamic> json) =>
    SponsoredItemModel(
      label: json['label'] as String,
      title: json['title'] as String,
      venue: ExploreVenueCardModel.fromJson(
        json['venue'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SponsoredItemModelToJson(SponsoredItemModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'title': instance.title,
      'venue': instance.venue,
    };

SponsoredSectionModel _$SponsoredSectionModelFromJson(
  Map<String, dynamic> json,
) => SponsoredSectionModel(
  status: json['status'] as String,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => SponsoredItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$SponsoredSectionModelToJson(
  SponsoredSectionModel instance,
) => <String, dynamic>{'status': instance.status, 'items': instance.items};
