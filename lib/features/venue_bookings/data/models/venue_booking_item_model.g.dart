// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_booking_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueBookingItemModel _$VenueBookingItemModelFromJson(
  Map<String, dynamic> json,
) => VenueBookingItemModel(
  id: json['id'] as String,
  reference: json['reference'] as String,
  pitchId: json['pitchId'] as String,
  startUtc: json['startUtc'] as String,
  endUtc: json['endUtc'] as String,
  status: (json['status'] as num).toInt(),
  totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,
  depositAmount: (json['depositAmount'] as num?)?.toDouble() ?? 0,
  currency: json['currency'] as String? ?? 'EGP',
  customerName: json['customerName'] as String?,
  customerPhone: json['customerPhone'] as String?,
  createdAtUtc: json['createdAtUtc'] as String? ?? '',
  isManual: json['isManual'] as bool? ?? false,
);

VenueBookingPageModel _$VenueBookingPageModelFromJson(
  Map<String, dynamic> json,
) => VenueBookingPageModel(
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => VenueBookingItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 20,
);
