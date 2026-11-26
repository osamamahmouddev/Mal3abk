// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_rule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceRuleModel _$PriceRuleModelFromJson(Map<String, dynamic> json) =>
    PriceRuleModel(
      id: json['id'] as String,
      kind: json['kind'] as String,
      adjustment: json['adjustment'] as String,
      name: json['name'] as String,
      pitchId: json['pitchId'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'EGP',
      percent: (json['percent'] as num?)?.toDouble(),
      days: (json['days'] as List<dynamic>?)?.map((e) => e as String).toList(),
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      minDurationMinutes: (json['minDurationMinutes'] as num?)?.toInt(),
      isActive: json['isActive'] as bool? ?? true,
    );
