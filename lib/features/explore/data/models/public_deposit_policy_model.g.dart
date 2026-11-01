// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_deposit_policy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicDepositPolicyModel _$PublicDepositPolicyModelFromJson(
  Map<String, dynamic> json,
) => PublicDepositPolicyModel(
  depositType: json['depositType'] as String,
  depositValue: (json['depositValue'] as num).toDouble(),
  proofSubmissionWindowMinutes: (json['proofSubmissionWindowMinutes'] as num)
      .toInt(),
  cancellationDeadlineHours: (json['cancellationDeadlineHours'] as num).toInt(),
  refundEligibility: json['refundEligibility'] as String,
  refundPercentage: (json['refundPercentage'] as num).toDouble(),
  noShowRule: json['noShowRule'] as String,
  lateArrivalGraceMinutes: (json['lateArrivalGraceMinutes'] as num).toInt(),
  allowReschedule: json['allowReschedule'] as bool,
  rescheduleDeadlineHours: (json['rescheduleDeadlineHours'] as num).toInt(),
  terms: json['terms'] as String?,
);

Map<String, dynamic> _$PublicDepositPolicyModelToJson(
  PublicDepositPolicyModel instance,
) => <String, dynamic>{
  'depositType': instance.depositType,
  'depositValue': instance.depositValue,
  'proofSubmissionWindowMinutes': instance.proofSubmissionWindowMinutes,
  'cancellationDeadlineHours': instance.cancellationDeadlineHours,
  'refundEligibility': instance.refundEligibility,
  'refundPercentage': instance.refundPercentage,
  'noShowRule': instance.noShowRule,
  'lateArrivalGraceMinutes': instance.lateArrivalGraceMinutes,
  'allowReschedule': instance.allowReschedule,
  'rescheduleDeadlineHours': instance.rescheduleDeadlineHours,
  'terms': instance.terms,
};
