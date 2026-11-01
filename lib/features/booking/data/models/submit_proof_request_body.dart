import 'package:json_annotation/json_annotation.dart';

part 'submit_proof_request_body.g.dart';

@JsonSerializable()
class SubmitProofRequestBody {
  const SubmitProofRequestBody({required this.mediaId, this.notes});

  final String mediaId;
  final String? notes;

  factory SubmitProofRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SubmitProofRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitProofRequestBodyToJson(this);
}
