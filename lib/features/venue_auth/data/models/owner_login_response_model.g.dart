// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerLoginResponseModel _$OwnerLoginResponseModelFromJson(
  Map<String, dynamic> json,
) => OwnerLoginResponseModel(
  userId: json['userId'] as String,
  fullName: json['fullName'] as String,
  roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
);
