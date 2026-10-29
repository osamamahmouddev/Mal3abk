import 'package:json_annotation/json_annotation.dart';

part 'verify_new_phone_response_model.g.dart';

@JsonSerializable()
class VerifyNewPhoneResponseModel {
  const VerifyNewPhoneResponseModel({
    required this.success,
    required this.newPhoneNumber,
  });

  final bool success;
  final String newPhoneNumber;

  factory VerifyNewPhoneResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyNewPhoneResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyNewPhoneResponseModelToJson(this);
}
