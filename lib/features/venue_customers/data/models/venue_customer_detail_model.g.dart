// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_customer_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueCustomerDetailModel _$VenueCustomerDetailModelFromJson(
  Map<String, dynamic> json,
) => VenueCustomerDetailModel(
  customer: VenueCustomerModel.fromJson(
    json['customer'] as Map<String, dynamic>,
  ),
  bookings:
      (json['bookings'] as List<dynamic>?)
          ?.map(
            (e) =>
                VenueCustomerBookingModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  notes:
      (json['notes'] as List<dynamic>?)
          ?.map(
            (e) => VenueCustomerNoteModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

VenueCustomerBookingModel _$VenueCustomerBookingModelFromJson(
  Map<String, dynamic> json,
) => VenueCustomerBookingModel(
  bookingId: json['bookingId'] as String,
  reference: json['reference'] as String,
  pitchId: json['pitchId'] as String,
  startUtc: json['startUtc'] as String,
  status: (json['status'] as num).toInt(),
  totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,
  currency: json['currency'] as String? ?? 'EGP',
);

VenueCustomerNoteModel _$VenueCustomerNoteModelFromJson(
  Map<String, dynamic> json,
) => VenueCustomerNoteModel(
  id: json['id'] as String,
  text: json['text'] as String,
  createdAtUtc: json['createdAtUtc'] as String,
  authorName: json['authorName'] as String? ?? '',
  canDelete: json['canDelete'] as bool? ?? false,
);
