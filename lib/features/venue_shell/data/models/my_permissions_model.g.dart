// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_permissions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPermissionsModel _$MyPermissionsModelFromJson(Map<String, dynamic> json) =>
    MyPermissionsModel(
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      permissions:
          (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      venues:
          (json['venues'] as List<dynamic>?)
              ?.map(
                (e) =>
                    VenuePermissionsModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

VenuePermissionsModel _$VenuePermissionsModelFromJson(
  Map<String, dynamic> json,
) => VenuePermissionsModel(
  venueId: json['venueId'] as String,
  accessLevel: json['accessLevel'] as String? ?? '',
  permissions:
      (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);
