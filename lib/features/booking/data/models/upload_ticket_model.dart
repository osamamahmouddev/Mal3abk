import 'package:json_annotation/json_annotation.dart';

part 'upload_ticket_model.g.dart';

@JsonSerializable()
class UploadTicketModel {
  const UploadTicketModel({
    required this.mediaId,
    required this.uploadUrl,
    required this.expiresAtUtc,
    this.maxBytes,
  });

  @JsonKey(name: 'mediaId')
  final String mediaId;
  final String uploadUrl;
  final String expiresAtUtc;
  final int? maxBytes;

  String get id => mediaId;

  factory UploadTicketModel.fromJson(Map<String, dynamic> json) =>
      _$UploadTicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$UploadTicketModelToJson(this);
}
