import 'package:json_annotation/json_annotation.dart';

import 'localized_item_model.dart';
import 'opening_hours_day_model.dart';
import 'public_deposit_policy_model.dart';
import 'venue_offer_model.dart';

part 'venue_details_model.g.dart';

@JsonSerializable()
class VenueDetailsModel {
  const VenueDetailsModel({
    required this.venueId,
    required this.name,
    required this.slug,
    this.description,
    required this.address,
    required this.city,
    required this.area,
    this.latitude,
    this.longitude,
    this.photos = const [],
    this.facilities = const [],
    this.openingHours = const [],
    this.fromHourlyPrice,
    this.currency = 'EGP',
    this.depositPolicy,
    this.pitchCount = 0,
    this.pitchTypes = const [],
    this.favoritesCount = 0,
    this.offer,
  });

  final String venueId;
  final String name;
  final String slug;
  final String? description;
  final String address;
  final String city;
  final String area;
  final double? latitude;
  final double? longitude;
  final List<String> photos;
  final List<LocalizedItemModel> facilities;
  final List<OpeningHoursDayModel> openingHours;
  final double? fromHourlyPrice;
  final String currency;
  final PublicDepositPolicyModel? depositPolicy;
  final int pitchCount;
  final List<String> pitchTypes;
  final int favoritesCount;
  final VenueOfferModel? offer;

  factory VenueDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$VenueDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$VenueDetailsModelToJson(this);
}
