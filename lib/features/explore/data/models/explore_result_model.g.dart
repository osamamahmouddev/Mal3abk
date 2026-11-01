// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExploreResultModel _$ExploreResultModelFromJson(Map<String, dynamic> json) =>
    ExploreResultModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => ExploreVenueCardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      hasMore: json['hasMore'] as bool,
    );

Map<String, dynamic> _$ExploreResultModelToJson(ExploreResultModel instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'page': instance.page,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'hasMore': instance.hasMore,
    };
