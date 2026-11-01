import 'package:json_annotation/json_annotation.dart';

part 'public_deposit_policy_model.g.dart';

@JsonSerializable()
class PublicDepositPolicyModel {
  const PublicDepositPolicyModel({
    required this.depositType,
    required this.depositValue,
    required this.proofSubmissionWindowMinutes,
    required this.cancellationDeadlineHours,
    required this.refundEligibility,
    required this.refundPercentage,
    required this.noShowRule,
    required this.lateArrivalGraceMinutes,
    required this.allowReschedule,
    required this.rescheduleDeadlineHours,
    this.terms,
  });

  final String depositType;
  final double depositValue;
  final int proofSubmissionWindowMinutes;
  final int cancellationDeadlineHours;
  final String refundEligibility;
  final double refundPercentage;
  final String noShowRule;
  final int lateArrivalGraceMinutes;
  final bool allowReschedule;
  final int rescheduleDeadlineHours;
  final String? terms;

  factory PublicDepositPolicyModel.fromJson(Map<String, dynamic> json) =>
      _$PublicDepositPolicyModelFromJson(json);

  Map<String, dynamic> toJson() => _$PublicDepositPolicyModelToJson(this);
}
