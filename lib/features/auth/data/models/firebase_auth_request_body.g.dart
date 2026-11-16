// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_auth_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseAuthRequestBody _$FirebaseAuthRequestBodyFromJson(
        Map<String, dynamic> json) =>
    FirebaseAuthRequestBody(
      idToken: json['idToken'] as String,
      fullName: json['fullName'] as String?,
      restoreAccount: json['restoreAccount'] as bool? ?? false,
    );

Map<String, dynamic> _$FirebaseAuthRequestBodyToJson(
        FirebaseAuthRequestBody instance) =>
    <String, dynamic>{
      'idToken': instance.idToken,
      if (instance.fullName != null) 'fullName': instance.fullName,
      'restoreAccount': instance.restoreAccount,
    };
