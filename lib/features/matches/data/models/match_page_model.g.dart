// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchPageModel _$MatchPageModelFromJson(Map<String, dynamic> json) =>
    MatchPageModel(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => MatchModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalCount: (json['totalCount'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
    );

Map<String, dynamic> _$MatchPageModelToJson(MatchPageModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'totalCount': instance.totalCount,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
