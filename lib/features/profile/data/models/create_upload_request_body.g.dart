// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_upload_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUploadRequestBody _$CreateUploadRequestBodyFromJson(
  Map<String, dynamic> json,
) => CreateUploadRequestBody(
  purpose: $enumDecode(_$MediaPurposeEnumMap, json['purpose']),
);

Map<String, dynamic> _$CreateUploadRequestBodyToJson(
  CreateUploadRequestBody instance,
) => <String, dynamic>{'purpose': _$MediaPurposeEnumMap[instance.purpose]!};

const _$MediaPurposeEnumMap = {MediaPurpose.avatar: 2};
