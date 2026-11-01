// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_payment_method_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenuePaymentMethodModel _$VenuePaymentMethodModelFromJson(
  Map<String, dynamic> json,
) => VenuePaymentMethodModel(
  id: json['id'] as String,
  venueId: json['venueId'] as String,
  methodType: json['methodType'] as String,
  recipientName: json['recipientName'] as String,
  accountDetailsMasked: json['accountDetailsMasked'] as String,
  instructions: json['instructions'] as String?,
  depositType: json['depositType'] as String,
  depositValue: (json['depositValue'] as num).toDouble(),
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$VenuePaymentMethodModelToJson(
  VenuePaymentMethodModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'venueId': instance.venueId,
  'methodType': instance.methodType,
  'recipientName': instance.recipientName,
  'accountDetailsMasked': instance.accountDetailsMasked,
  'instructions': instance.instructions,
  'depositType': instance.depositType,
  'depositValue': instance.depositValue,
  'isActive': instance.isActive,
};
