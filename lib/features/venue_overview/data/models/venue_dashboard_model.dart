import 'package:json_annotation/json_annotation.dart';

part 'venue_dashboard_model.g.dart';

/// Today's numbers for one venue (`VenueDashboardDto`), in Cairo business days.
@JsonSerializable(createToJson: false)
class VenueDashboardModel {
  const VenueDashboardModel({
    required this.businessDate,
    required this.today,
    required this.todayOccupancy,
    this.todayRevenue,
    this.monthRevenue,
    this.occupancyThisWeek = const [],
    this.occupancyLastWeek = const [],
    this.revenueTrend,
    this.timeline = const [],
    this.upcoming = const [],
    this.proofsAwaitingReview = const [],
    this.recentActivity = const [],
  });

  final String businessDate;
  final DashboardCountsModel today;

  /// Null for staff who may not see money.
  final DashboardRevenueModel? todayRevenue;
  final DashboardRevenueModel? monthRevenue;
  final OccupancyPointModel todayOccupancy;
  final List<OccupancyPointModel> occupancyThisWeek;
  final List<OccupancyPointModel> occupancyLastWeek;
  final List<RevenuePointModel>? revenueTrend;
  final List<DashboardBookingModel> timeline;
  final List<DashboardBookingModel> upcoming;
  final List<DashboardBookingModel> proofsAwaitingReview;
  final List<DashboardActivityModel> recentActivity;

  factory VenueDashboardModel.fromJson(Map<String, dynamic> json) =>
      _$VenueDashboardModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardCountsModel {
  const DashboardCountsModel({
    this.todayBookings = 0,
    this.confirmed = 0,
    this.pendingDeposit = 0,
    this.pendingProofReview = 0,
    this.cancelled = 0,
    this.noShows = 0,
  });

  final int todayBookings;
  final int confirmed;
  final int pendingDeposit;
  final int pendingProofReview;
  final int cancelled;
  final int noShows;

  factory DashboardCountsModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardCountsModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardRevenueModel {
  const DashboardRevenueModel({
    this.currency = 'EGP',
    this.confirmedValue = 0,
    this.depositsCollected = 0,
    this.dueAtVenue = 0,
    this.depositsPendingReview = 0,
    this.expectedValue = 0,
  });

  final String currency;
  final double confirmedValue;
  final double depositsCollected;
  final double dueAtVenue;
  final double depositsPendingReview;
  final double expectedValue;

  factory DashboardRevenueModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardRevenueModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class OccupancyPointModel {
  const OccupancyPointModel({
    required this.date,
    this.openMinutes = 0,
    this.bookedMinutes = 0,
    this.percent = 0,
  });

  final String date;
  final int openMinutes;
  final int bookedMinutes;
  final double percent;

  factory OccupancyPointModel.fromJson(Map<String, dynamic> json) =>
      _$OccupancyPointModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class RevenuePointModel {
  const RevenuePointModel({
    required this.date,
    this.confirmedValue = 0,
    this.depositsCollected = 0,
  });

  final String date;
  final double confirmedValue;
  final double depositsCollected;

  factory RevenuePointModel.fromJson(Map<String, dynamic> json) =>
      _$RevenuePointModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardBookingModel {
  const DashboardBookingModel({
    required this.bookingId,
    required this.reference,
    required this.pitchId,
    required this.startUtc,
    required this.endUtc,
    required this.status,
    this.customerName = '',
    this.isManual = false,
    this.totalPrice = 0,
    this.depositAmount = 0,
    this.currency = 'EGP',
    this.depositState = 'None',
    this.deadlineUtc,
  });

  final String bookingId;
  final String reference;
  final String pitchId;
  final String startUtc;
  final String endUtc;
  final String customerName;
  final bool isManual;
  final int status;
  final double totalPrice;
  final double depositAmount;
  final String currency;
  final String depositState;
  final String? deadlineUtc;

  factory DashboardBookingModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardBookingModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardActivityModel {
  const DashboardActivityModel({
    required this.bookingId,
    required this.reference,
    required this.fromStatus,
    required this.toStatus,
    required this.changedAtUtc,
    this.reason,
  });

  final String bookingId;
  final String reference;
  final int fromStatus;
  final int toStatus;
  final String changedAtUtc;
  final String? reason;

  factory DashboardActivityModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardActivityModelFromJson(json);
}
