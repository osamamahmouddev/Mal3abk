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
      suggestions:
          (json['suggestions'] as List<dynamic>?)
              ?.map(
                (e) =>
                    ExploreSuggestionModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$ExploreResultModelToJson(ExploreResultModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'hasMore': instance.hasMore,
      'suggestions': instance.suggestions,
    };

ExploreSuggestionModel _$ExploreSuggestionModelFromJson(
  Map<String, dynamic> json,
) => ExploreSuggestionModel(
  code: json['code'] as String,
  matchCount: (json['matchCount'] as num).toInt(),
);

Map<String, dynamic> _$ExploreSuggestionModelToJson(
  ExploreSuggestionModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'matchCount': instance.matchCount,
};
