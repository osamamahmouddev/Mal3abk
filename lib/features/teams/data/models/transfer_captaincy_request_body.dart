import 'package:json_annotation/json_annotation.dart';

part 'transfer_captaincy_request_body.g.dart';

@JsonSerializable()
class TransferCaptaincyRequestBody {
  const TransferCaptaincyRequestBody({required this.newCaptainPlayerId});

  final String newCaptainPlayerId;

  factory TransferCaptaincyRequestBody.fromJson(Map<String, dynamic> json) =>
      _$TransferCaptaincyRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TransferCaptaincyRequestBodyToJson(this);
}
