import 'package:json_annotation/json_annotation.dart';

part 'venue_report_models.g.dart';

/// Bookings, money, occupancy and peak hours over a period
/// (`VenueReportDto`).
@JsonSerializable(createToJson: false)
class VenueReportModel {
  const VenueReportModel({
    required this.from,
    required this.to,
    required this.revenue,
    this.groupBy = 0,
    this.bookings = const [],
    this.statusDistribution = const {},
    this.revenueSeries = const [],
    this.pitchUtilization = const [],
    this.peakHours = const [],
  });

  final String from;
  final String to;

  /// 0 day, 1 week, 2 month.
  final int groupBy;
  final List<BookingsBucketModel> bookings;

  /// Status name → bookings.
  final Map<String, int> statusDistribution;
  final RevenueSplitModel revenue;
  final List<RevenueBucketModel> revenueSeries;
  final List<PitchUtilizationModel> pitchUtilization;
  final List<PeakHourModel> peakHours;

  int get totalBookings => bookings.fold(0, (s, b) => s + b.total);

  factory VenueReportModel.fromJson(Map<String, dynamic> json) =>
      _$VenueReportModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class BookingsBucketModel {
  const BookingsBucketModel({
    required this.periodStart,
    this.total = 0,
    this.confirmed = 0,
    this.completed = 0,
    this.pending = 0,
    this.cancelled = 0,
    this.noShows = 0,
    this.expiredOrRejected = 0,
  });

  final String periodStart;
  final int total;
  final int confirmed;
  final int completed;
  final int pending;
  final int cancelled;
  final int noShows;
  final int expiredOrRejected;

  factory BookingsBucketModel.fromJson(Map<String, dynamic> json) =>
      _$BookingsBucketModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class RevenueSplitModel {
  const RevenueSplitModel({
    this.currency = 'EGP',
    this.booked = 0,
    this.depositsReceived = 0,
    this.outstanding = 0,
    this.recognized = 0,
    this.pending = 0,
    this.platformCommission = 0,
    this.venueNetRevenue = 0,
  });

  final String currency;
  final double booked;
  final double depositsReceived;
  final double outstanding;
  final double recognized;
  final double pending;
  final double platformCommission;
  final double venueNetRevenue;

  factory RevenueSplitModel.fromJson(Map<String, dynamic> json) =>
      _$RevenueSplitModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class RevenueBucketModel {
  const RevenueBucketModel({
    required this.periodStart,
    this.booked = 0,
    this.recognized = 0,
    this.depositsReceived = 0,
  });

  final String periodStart;
  final double booked;
  final double recognized;
  final double depositsReceived;

  factory RevenueBucketModel.fromJson(Map<String, dynamic> json) =>
      _$RevenueBucketModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class PitchUtilizationModel {
  const PitchUtilizationModel({
    required this.pitchId,
    required this.name,
    this.openMinutes = 0,
    this.bookedMinutes = 0,
    this.percent = 0,
  });

  final String pitchId;
  final String name;
  final int openMinutes;
  final int bookedMinutes;
  final double percent;

  factory PitchUtilizationModel.fromJson(Map<String, dynamic> json) =>
      _$PitchUtilizationModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class PeakHourModel {
  const PeakHourModel({
    required this.dayOfWeek,
    required this.hour,
    this.bookings = 0,
  });

  /// 0 = Sunday.
  final int dayOfWeek;
  final int hour;
  final int bookings;

  factory PeakHourModel.fromJson(Map<String, dynamic> json) =>
      _$PeakHourModelFromJson(json);
}

/// What the platform owes the venue and has paid it (`VenuePayoutStatement`).
@JsonSerializable(createToJson: false)
class VenuePayoutStatementModel {
  const VenuePayoutStatementModel({
    required this.balance,
    this.payouts = const [],
    this.bookings = const [],
  });

  final VenuePayoutBalanceModel balance;
  final List<VenuePayoutItemModel> payouts;
  final List<VenuePayoutBookingModel> bookings;

  factory VenuePayoutStatementModel.fromJson(Map<String, dynamic> json) =>
      _$VenuePayoutStatementModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class VenuePayoutBalanceModel {
  const VenuePayoutBalanceModel({
    this.settledBookings = 0,
    this.depositsReceived = 0,
    this.commission = 0,
    this.refundedToPlayers = 0,
    this.venueShare = 0,
    this.paidOut = 0,
    this.balance = 0,
    this.lastPayoutAtUtc,
    this.currency = 'EGP',
  });

  final int settledBookings;
  final double depositsReceived;
  final double commission;
  final double refundedToPlayers;
  final double venueShare;
  final double paidOut;
  final double balance;
  final String? lastPayoutAtUtc;
  final String currency;

  factory VenuePayoutBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$VenuePayoutBalanceModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class VenuePayoutItemModel {
  const VenuePayoutItemModel({
    required this.id,
    required this.amount,
    required this.method,
    required this.reference,
    required this.paidAtUtc,
    this.currency = 'EGP',
    this.notes,
  });

  final String id;
  final double amount;
  final String currency;

  /// `InstaPay`, `Wallet`, `BankTransfer`, `Cash`.
  final String method;
  final String reference;
  final String? notes;
  final String paidAtUtc;

  factory VenuePayoutItemModel.fromJson(Map<String, dynamic> json) =>
      _$VenuePayoutItemModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class VenuePayoutBookingModel {
  const VenuePayoutBookingModel({
    required this.bookingId,
    required this.reference,
    required this.status,
    required this.startUtc,
    this.totalPrice = 0,
    this.depositReceived = 0,
    this.commission = 0,
    this.refunded = 0,
    this.venueShare = 0,
  });

  final String bookingId;
  final String reference;
  final String status;
  final String startUtc;
  final double totalPrice;
  final double depositReceived;
  final double commission;
  final double refunded;
  final double venueShare;

  factory VenuePayoutBookingModel.fromJson(Map<String, dynamic> json) =>
      _$VenuePayoutBookingModelFromJson(json);
}
