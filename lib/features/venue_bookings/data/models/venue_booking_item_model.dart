import 'package:json_annotation/json_annotation.dart';

part 'venue_booking_item_model.g.dart';

/// A booking in the venue's list (`VenueBookingItemDto`).
@JsonSerializable(createToJson: false)
class VenueBookingItemModel {
  const VenueBookingItemModel({
    required this.id,
    required this.reference,
    required this.pitchId,
    required this.startUtc,
    required this.endUtc,
    required this.status,
    this.totalPrice = 0,
    this.depositAmount = 0,
    this.currency = 'EGP',
    this.customerName,
    this.customerPhone,
    this.createdAtUtc = '',
    this.isManual = false,
  });

  final String id;
  final String reference;
  final String pitchId;
  final String startUtc;
  final String endUtc;
  final double totalPrice;
  final double depositAmount;
  final String currency;
  final int status;
  final String? customerName;
  final String? customerPhone;
  final String createdAtUtc;
  final bool isManual;

  factory VenueBookingItemModel.fromJson(Map<String, dynamic> json) =>
      _$VenueBookingItemModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class VenueBookingPageModel {
  const VenueBookingPageModel({
    this.items = const [],
    this.totalCount = 0,
    this.page = 1,
    this.pageSize = 20,
  });

  final List<VenueBookingItemModel> items;
  final int totalCount;
  final int page;
  final int pageSize;

  factory VenueBookingPageModel.fromJson(Map<String, dynamic> json) =>
      _$VenueBookingPageModelFromJson(json);
}
