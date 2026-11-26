import 'package:json_annotation/json_annotation.dart';

part 'venue_customer_model.g.dart';

/// A customer who booked at the venue before (`CustomerSummaryDto`).
@JsonSerializable(createToJson: false)
class VenueCustomerModel {
  const VenueCustomerModel({
    required this.customerKey,
    required this.name,
    this.phone,
    this.isRegisteredPlayer = false,
    this.totalBookings = 0,
    this.completed = 0,
    this.upcoming = 0,
    this.cancelled = 0,
    this.noShows = 0,
    this.totalSpent = 0,
    this.currency = 'EGP',
    this.firstBookingUtc,
    this.lastBookingUtc,
  });

  final String customerKey;
  final String name;
  final String? phone;
  final bool isRegisteredPlayer;
  final int totalBookings;
  final int completed;
  final int upcoming;
  final int cancelled;
  final int noShows;
  final double totalSpent;
  final String currency;
  final String? firstBookingUtc;
  final String? lastBookingUtc;

  factory VenueCustomerModel.fromJson(Map<String, dynamic> json) =>
      _$VenueCustomerModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class VenueCustomerPageModel {
  const VenueCustomerPageModel({this.items = const [], this.totalCount = 0});

  final List<VenueCustomerModel> items;
  final int totalCount;

  factory VenueCustomerPageModel.fromJson(Map<String, dynamic> json) =>
      _$VenueCustomerPageModelFromJson(json);
}
