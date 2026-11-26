// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueCustomerModel _$VenueCustomerModelFromJson(Map<String, dynamic> json) =>
    VenueCustomerModel(
      customerKey: json['customerKey'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      isRegisteredPlayer: json['isRegisteredPlayer'] as bool? ?? false,
      totalBookings: (json['totalBookings'] as num?)?.toInt() ?? 0,
      completed: (json['completed'] as num?)?.toInt() ?? 0,
      upcoming: (json['upcoming'] as num?)?.toInt() ?? 0,
      cancelled: (json['cancelled'] as num?)?.toInt() ?? 0,
      noShows: (json['noShows'] as num?)?.toInt() ?? 0,
      totalSpent: (json['totalSpent'] as num?)?.toDouble() ?? 0,
      currency: json['currency'] as String? ?? 'EGP',
      firstBookingUtc: json['firstBookingUtc'] as String?,
      lastBookingUtc: json['lastBookingUtc'] as String?,
    );

VenueCustomerPageModel _$VenueCustomerPageModelFromJson(
  Map<String, dynamic> json,
) => VenueCustomerPageModel(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => VenueCustomerModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
);
