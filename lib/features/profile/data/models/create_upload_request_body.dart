import 'package:json_annotation/json_annotation.dart';

part 'create_upload_request_body.g.dart';

enum MediaPurpose {
  @JsonValue(2)
  avatar,
}

@JsonSerializable()
class CreateUploadRequestBody {
  const CreateUploadRequestBody({required this.purpose});

  final MediaPurpose purpose;

  factory CreateUploadRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateUploadRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUploadRequestBodyToJson(this);
}
