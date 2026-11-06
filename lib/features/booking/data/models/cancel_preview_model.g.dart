// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelPreviewModel _$CancelPreviewModelFromJson(Map<String, dynamic> json) =>
    CancelPreviewModel(
      canCancel: json['canCancel'] as bool,
      cancellationDeadlineUtc: json['cancellationDeadlineUtc'] == null
          ? null
          : DateTime.parse(json['cancellationDeadlineUtc'] as String),
      refundPercentage: (json['refundPercentage'] as num).toDouble(),
      estimatedRefundAmount: (json['estimatedRefundAmount'] as num).toDouble(),
      currency: json['currency'] as String,
      policySummary: json['policySummary'] as String?,
    );

Map<String, dynamic> _$CancelPreviewModelToJson(CancelPreviewModel instance) =>
    <String, dynamic>{
      'canCancel': instance.canCancel,
      'cancellationDeadlineUtc': instance.cancellationDeadlineUtc
          ?.toIso8601String(),
      'refundPercentage': instance.refundPercentage,
      'estimatedRefundAmount': instance.estimatedRefundAmount,
      'currency': instance.currency,
      'policySummary': instance.policySummary,
    };
