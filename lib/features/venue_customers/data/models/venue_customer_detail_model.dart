import 'package:json_annotation/json_annotation.dart';

import '../../../venue_calendar/data/models/venue_customer_model.dart';

part 'venue_customer_detail_model.g.dart';

/// A customer's profile at the venue (`CustomerDetailDto`).
@JsonSerializable(createToJson: false)
class VenueCustomerDetailModel {
  const VenueCustomerDetailModel({
    required this.customer,
    this.bookings = const [],
    this.notes = const [],
  });

  final VenueCustomerModel customer;
  final List<VenueCustomerBookingModel> bookings;
  final List<VenueCustomerNoteModel> notes;

  factory VenueCustomerDetailModel.fromJson(Map<String, dynamic> json) =>
      _$VenueCustomerDetailModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class VenueCustomerBookingModel {
  const VenueCustomerBookingModel({
    required this.bookingId,
    required this.reference,
    required this.pitchId,
    required this.startUtc,
    required this.status,
    this.totalPrice = 0,
    this.currency = 'EGP',
  });

  final String bookingId;
  final String reference;
  final String pitchId;
  final String startUtc;
  final int status;
  final double totalPrice;
  final String currency;

  factory VenueCustomerBookingModel.fromJson(Map<String, dynamic> json) =>
      _$VenueCustomerBookingModelFromJson(json);
}

/// A staff-only note about a customer.
@JsonSerializable(createToJson: false)
class VenueCustomerNoteModel {
  const VenueCustomerNoteModel({
    required this.id,
    required this.text,
    required this.createdAtUtc,
    this.authorName = '',
    this.canDelete = false,
  });

  final String id;
  final String text;
  final String authorName;
  final String createdAtUtc;
  final bool canDelete;

  factory VenueCustomerNoteModel.fromJson(Map<String, dynamic> json) =>
      _$VenueCustomerNoteModelFromJson(json);
}
