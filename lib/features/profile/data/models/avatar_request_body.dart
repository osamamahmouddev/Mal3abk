import 'package:json_annotation/json_annotation.dart';

part 'avatar_request_body.g.dart';

@JsonSerializable()
class AvatarRequestBody {
  const AvatarRequestBody({required this.mediaId});

  final String mediaId;

  factory AvatarRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AvatarRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarRequestBodyToJson(this);
}
