import 'package:json_annotation/json_annotation.dart';

part 'start_phone_change_response_model.g.dart';

@JsonSerializable()
class StartPhoneChangeResponseModel {
  const StartPhoneChangeResponseModel({
    required this.requestId,
    required this.expiresAtUtc,
  });

  final String requestId;
  final DateTime expiresAtUtc;

  factory StartPhoneChangeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StartPhoneChangeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$StartPhoneChangeResponseModelToJson(this);
}
