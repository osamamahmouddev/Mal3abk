// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadTicketModel _$UploadTicketModelFromJson(Map<String, dynamic> json) =>
    UploadTicketModel(
      mediaId: (json['mediaId'] ?? json['id'] ?? '') as String,
      uploadUrl: (json['uploadUrl'] ?? '') as String,
      expiresAtUtc: (json['expiresAtUtc'] ?? '') as String,
      maxBytes: (json['maxBytes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UploadTicketModelToJson(UploadTicketModel instance) =>
    <String, dynamic>{
      'mediaId': instance.mediaId,
      'uploadUrl': instance.uploadUrl,
      'expiresAtUtc': instance.expiresAtUtc,
      'maxBytes': instance.maxBytes,
    };
