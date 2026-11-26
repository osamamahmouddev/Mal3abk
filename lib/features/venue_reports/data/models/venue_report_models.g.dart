// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_report_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueReportModel _$VenueReportModelFromJson(
  Map<String, dynamic> json,
) => VenueReportModel(
  from: json['from'] as String,
  to: json['to'] as String,
  revenue: RevenueSplitModel.fromJson(json['revenue'] as Map<String, dynamic>),
  groupBy: (json['groupBy'] as num?)?.toInt() ?? 0,
  bookings:
      (json['bookings'] as List<dynamic>?)
          ?.map((e) => BookingsBucketModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  statusDistribution:
      (json['statusDistribution'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
  revenueSeries:
      (json['revenueSeries'] as List<dynamic>?)
          ?.map((e) => RevenueBucketModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pitchUtilization:
      (json['pitchUtilization'] as List<dynamic>?)
          ?.map(
            (e) => PitchUtilizationModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  peakHours:
      (json['peakHours'] as List<dynamic>?)
          ?.map((e) => PeakHourModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

BookingsBucketModel _$BookingsBucketModelFromJson(Map<String, dynamic> json) =>
    BookingsBucketModel(
      periodStart: json['periodStart'] as String,
      total: (json['total'] as num?)?.toInt() ?? 0,
      confirmed: (json['confirmed'] as num?)?.toInt() ?? 0,
      completed: (json['completed'] as num?)?.toInt() ?? 0,
      pending: (json['pending'] as num?)?.toInt() ?? 0,
      cancelled: (json['cancelled'] as num?)?.toInt() ?? 0,
      noShows: (json['noShows'] as num?)?.toInt() ?? 0,
      expiredOrRejected: (json['expiredOrRejected'] as num?)?.toInt() ?? 0,
    );

RevenueSplitModel _$RevenueSplitModelFromJson(Map<String, dynamic> json) =>
    RevenueSplitModel(
      currency: json['currency'] as String? ?? 'EGP',
      booked: (json['booked'] as num?)?.toDouble() ?? 0,
      depositsReceived: (json['depositsReceived'] as num?)?.toDouble() ?? 0,
      outstanding: (json['outstanding'] as num?)?.toDouble() ?? 0,
      recognized: (json['recognized'] as num?)?.toDouble() ?? 0,
      pending: (json['pending'] as num?)?.toDouble() ?? 0,
      platformCommission: (json['platformCommission'] as num?)?.toDouble() ?? 0,
      venueNetRevenue: (json['venueNetRevenue'] as num?)?.toDouble() ?? 0,
    );

RevenueBucketModel _$RevenueBucketModelFromJson(Map<String, dynamic> json) =>
    RevenueBucketModel(
      periodStart: json['periodStart'] as String,
      booked: (json['booked'] as num?)?.toDouble() ?? 0,
      recognized: (json['recognized'] as num?)?.toDouble() ?? 0,
      depositsReceived: (json['depositsReceived'] as num?)?.toDouble() ?? 0,
    );

PitchUtilizationModel _$PitchUtilizationModelFromJson(
  Map<String, dynamic> json,
) => PitchUtilizationModel(
  pitchId: json['pitchId'] as String,
  name: json['name'] as String,
  openMinutes: (json['openMinutes'] as num?)?.toInt() ?? 0,
  bookedMinutes: (json['bookedMinutes'] as num?)?.toInt() ?? 0,
  percent: (json['percent'] as num?)?.toDouble() ?? 0,
);

PeakHourModel _$PeakHourModelFromJson(Map<String, dynamic> json) =>
    PeakHourModel(
      dayOfWeek: (json['dayOfWeek'] as num).toInt(),
      hour: (json['hour'] as num).toInt(),
      bookings: (json['bookings'] as num?)?.toInt() ?? 0,
    );

VenuePayoutStatementModel _$VenuePayoutStatementModelFromJson(
  Map<String, dynamic> json,
) => VenuePayoutStatementModel(
  balance: VenuePayoutBalanceModel.fromJson(
    json['balance'] as Map<String, dynamic>,
  ),
  payouts:
      (json['payouts'] as List<dynamic>?)
          ?.map((e) => VenuePayoutItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  bookings:
      (json['bookings'] as List<dynamic>?)
          ?.map(
            (e) => VenuePayoutBookingModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

VenuePayoutBalanceModel _$VenuePayoutBalanceModelFromJson(
  Map<String, dynamic> json,
) => VenuePayoutBalanceModel(
  settledBookings: (json['settledBookings'] as num?)?.toInt() ?? 0,
  depositsReceived: (json['depositsReceived'] as num?)?.toDouble() ?? 0,
  commission: (json['commission'] as num?)?.toDouble() ?? 0,
  refundedToPlayers: (json['refundedToPlayers'] as num?)?.toDouble() ?? 0,
  venueShare: (json['venueShare'] as num?)?.toDouble() ?? 0,
  paidOut: (json['paidOut'] as num?)?.toDouble() ?? 0,
  balance: (json['balance'] as num?)?.toDouble() ?? 0,
  lastPayoutAtUtc: json['lastPayoutAtUtc'] as String?,
  currency: json['currency'] as String? ?? 'EGP',
);

VenuePayoutItemModel _$VenuePayoutItemModelFromJson(
  Map<String, dynamic> json,
) => VenuePayoutItemModel(
  id: json['id'] as String,
  amount: (json['amount'] as num).toDouble(),
  method: json['method'] as String,
  reference: json['reference'] as String,
  paidAtUtc: json['paidAtUtc'] as String,
  currency: json['currency'] as String? ?? 'EGP',
  notes: json['notes'] as String?,
);

VenuePayoutBookingModel _$VenuePayoutBookingModelFromJson(
  Map<String, dynamic> json,
) => VenuePayoutBookingModel(
  bookingId: json['bookingId'] as String,
  reference: json['reference'] as String,
  status: json['status'] as String,
  startUtc: json['startUtc'] as String,
  totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,
  depositReceived: (json['depositReceived'] as num?)?.toDouble() ?? 0,
  commission: (json['commission'] as num?)?.toDouble() ?? 0,
  refunded: (json['refunded'] as num?)?.toDouble() ?? 0,
  venueShare: (json['venueShare'] as num?)?.toDouble() ?? 0,
);
