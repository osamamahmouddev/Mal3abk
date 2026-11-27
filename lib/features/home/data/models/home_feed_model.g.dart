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
    <String, dynamic>{'status': instance.status, 'items': instance.items};

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
      sponsored: json['sponsored'] == null
          ? null
          : SponsoredSectionModel.fromJson(
              json['sponsored'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$HomeFeedModelToJson(HomeFeedModel instance) =>
    <String, dynamic>{
      'nearby': instance.nearby,
      'popularNearYou': instance.popularNearYou,
      'recentlyViewed': instance.recentlyViewed,
      'generatedAtUtc': instance.generatedAtUtc,
      'sponsored': instance.sponsored,
    };
