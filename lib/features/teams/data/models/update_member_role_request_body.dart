import 'package:json_annotation/json_annotation.dart';

part 'update_member_role_request_body.g.dart';

/// Role numbers as the server sends them: 2 is vice-captain, 3 is member.
/// The captain changes only through a captaincy transfer.
@JsonSerializable()
class UpdateMemberRoleRequestBody {
  const UpdateMemberRoleRequestBody({required this.role});

  static const int viceCaptain = 2;
  static const int member = 3;

  final int role;

  factory UpdateMemberRoleRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateMemberRoleRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateMemberRoleRequestBodyToJson(this);
}
