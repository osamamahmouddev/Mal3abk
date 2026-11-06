// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_leaderboard_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamLeaderboardPageModel _$TeamLeaderboardPageModelFromJson(
  Map<String, dynamic> json,
) => TeamLeaderboardPageModel(
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) =>
                TeamLeaderboardEntryModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  totalCount: (json['totalCount'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$TeamLeaderboardPageModelToJson(
  TeamLeaderboardPageModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'totalCount': instance.totalCount,
  'page': instance.page,
  'pageSize': instance.pageSize,
};
