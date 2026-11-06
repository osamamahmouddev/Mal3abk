import 'package:json_annotation/json_annotation.dart';

part 'cancel_preview_model.g.dart';

@JsonSerializable()
class CancelPreviewModel {
  const CancelPreviewModel({
    required this.canCancel,
    this.cancellationDeadlineUtc,
    required this.refundPercentage,
    required this.estimatedRefundAmount,
    required this.currency,
    this.policySummary,
  });

  final bool canCancel;
  final DateTime? cancellationDeadlineUtc;
  final double refundPercentage;
  final double estimatedRefundAmount;
  final String currency;
  final String? policySummary;

  factory CancelPreviewModel.fromJson(Map<String, dynamic> json) =>
      _$CancelPreviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$CancelPreviewModelToJson(this);
}
