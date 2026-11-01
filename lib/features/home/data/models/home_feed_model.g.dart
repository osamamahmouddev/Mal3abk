// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeSectionModel _$HomeSectionModelFromJson(Map<String, dynamic> json) =>
    HomeSectionModel(
      status: json['status'] as String,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) =>
                    ExploreVenueCardModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$HomeSectionModelToJson(HomeSectionModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

HomeFeedModel _$HomeFeedModelFromJson(Map<String, dynamic> json) =>
    HomeFeedModel(
      nearby: HomeSectionModel.fromJson(json['nearby'] as Map<String, dynamic>),
      popularNearYou: HomeSectionModel.fromJson(
        json['popularNearYou'] as Map<String, dynamic>,
      ),
      recentlyViewed: HomeSectionModel.fromJson(
        json['recentlyViewed'] as Map<String, dynamic>,
      ),
      generatedAtUtc: json['generatedAtUtc'] as String,
    );

Map<String, dynamic> _$HomeFeedModelToJson(HomeFeedModel instance) =>
    <String, dynamic>{
      'nearby': instance.nearby.toJson(),
      'popularNearYou': instance.popularNearYou.toJson(),
      'recentlyViewed': instance.recentlyViewed.toJson(),
      'generatedAtUtc': instance.generatedAtUtc,
    };
