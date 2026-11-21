import 'package:json_annotation/json_annotation.dart';

part 'venue_offer_model.g.dart';

/// The discount a venue runs today: how much it takes off, until when, and
/// the starting hourly price after it. [fromHourlyPriceAfter] is only set when
/// the discount applies to every one-hour booking; otherwise [hasConditions]
/// is true and the exact price comes from the quote.
@JsonSerializable()
class VenueOfferModel {
  const VenueOfferModel({
    required this.name,
    required this.type,
    required this.value,
    this.endsOn,
    this.hasConditions = false,
    this.fromHourlyPriceAfter,
  });

  final String name;

  /// `percentage` ([value] is the percent off) or `amount` ([value] is taken
  /// off a booking).
  final String type;
  final double value;

  /// Last day of the offer (Cairo date, `yyyy-MM-dd`); null when open-ended.
  final String? endsOn;
  final bool hasConditions;
  final double? fromHourlyPriceAfter;

  bool get isPercentage => type == 'percentage';

  /// The last day as a date, or null when open-ended or unreadable.
  DateTime? get endsOnDate =>
      endsOn == null ? null : DateTime.tryParse(endsOn!);

  factory VenueOfferModel.fromJson(Map<String, dynamic> json) =>
      _$VenueOfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$VenueOfferModelToJson(this);
}
