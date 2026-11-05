// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_discovery_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamDiscoveryPageModel _$TeamDiscoveryPageModelFromJson(
  Map<String, dynamic> json,
) => TeamDiscoveryPageModel(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => TeamDiscoveryModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  totalCount: (json['totalCount'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$TeamDiscoveryPageModelToJson(
  TeamDiscoveryPageModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'totalCount': instance.totalCount,
  'page': instance.page,
  'pageSize': instance.pageSize,
};
