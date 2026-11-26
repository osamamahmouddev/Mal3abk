// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueDashboardModel _$VenueDashboardModelFromJson(
  Map<String, dynamic> json,
) => VenueDashboardModel(
  businessDate: json['businessDate'] as String,
  today: DashboardCountsModel.fromJson(json['today'] as Map<String, dynamic>),
  todayOccupancy: OccupancyPointModel.fromJson(
    json['todayOccupancy'] as Map<String, dynamic>,
  ),
  todayRevenue: json['todayRevenue'] == null
      ? null
      : DashboardRevenueModel.fromJson(
          json['todayRevenue'] as Map<String, dynamic>,
        ),
  monthRevenue: json['monthRevenue'] == null
      ? null
      : DashboardRevenueModel.fromJson(
          json['monthRevenue'] as Map<String, dynamic>,
        ),
  occupancyThisWeek:
      (json['occupancyThisWeek'] as List<dynamic>?)
          ?.map((e) => OccupancyPointModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  occupancyLastWeek:
      (json['occupancyLastWeek'] as List<dynamic>?)
          ?.map((e) => OccupancyPointModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  revenueTrend: (json['revenueTrend'] as List<dynamic>?)
      ?.map((e) => RevenuePointModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  timeline:
      (json['timeline'] as List<dynamic>?)
          ?.map(
            (e) => DashboardBookingModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  upcoming:
      (json['upcoming'] as List<dynamic>?)
          ?.map(
            (e) => DashboardBookingModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  proofsAwaitingReview:
      (json['proofsAwaitingReview'] as List<dynamic>?)
          ?.map(
            (e) => DashboardBookingModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  recentActivity:
      (json['recentActivity'] as List<dynamic>?)
          ?.map(
            (e) => DashboardActivityModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

DashboardCountsModel _$DashboardCountsModelFromJson(
  Map<String, dynamic> json,
) => DashboardCountsModel(
  todayBookings: (json['todayBookings'] as num?)?.toInt() ?? 0,
  confirmed: (json['confirmed'] as num?)?.toInt() ?? 0,
  pendingDeposit: (json['pendingDeposit'] as num?)?.toInt() ?? 0,
  pendingProofReview: (json['pendingProofReview'] as num?)?.toInt() ?? 0,
  cancelled: (json['cancelled'] as num?)?.toInt() ?? 0,
  noShows: (json['noShows'] as num?)?.toInt() ?? 0,
);

DashboardRevenueModel _$DashboardRevenueModelFromJson(
  Map<String, dynamic> json,
) => DashboardRevenueModel(
  currency: json['currency'] as String? ?? 'EGP',
  confirmedValue: (json['confirmedValue'] as num?)?.toDouble() ?? 0,
  depositsCollected: (json['depositsCollected'] as num?)?.toDouble() ?? 0,
  dueAtVenue: (json['dueAtVenue'] as num?)?.toDouble() ?? 0,
  depositsPendingReview:
      (json['depositsPendingReview'] as num?)?.toDouble() ?? 0,
  expectedValue: (json['expectedValue'] as num?)?.toDouble() ?? 0,
);

OccupancyPointModel _$OccupancyPointModelFromJson(Map<String, dynamic> json) =>
    OccupancyPointModel(
      date: json['date'] as String,
      openMinutes: (json['openMinutes'] as num?)?.toInt() ?? 0,
      bookedMinutes: (json['bookedMinutes'] as num?)?.toInt() ?? 0,
      percent: (json['percent'] as num?)?.toDouble() ?? 0,
    );

RevenuePointModel _$RevenuePointModelFromJson(Map<String, dynamic> json) =>
    RevenuePointModel(
      date: json['date'] as String,
      confirmedValue: (json['confirmedValue'] as num?)?.toDouble() ?? 0,
      depositsCollected: (json['depositsCollected'] as num?)?.toDouble() ?? 0,
    );

DashboardBookingModel _$DashboardBookingModelFromJson(
  Map<String, dynamic> json,
) => DashboardBookingModel(
  bookingId: json['bookingId'] as String,
  reference: json['reference'] as String,
  pitchId: json['pitchId'] as String,
  startUtc: json['startUtc'] as String,
  endUtc: json['endUtc'] as String,
  status: (json['status'] as num).toInt(),
  customerName: json['customerName'] as String? ?? '',
  isManual: json['isManual'] as bool? ?? false,
  totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,
  depositAmount: (json['depositAmount'] as num?)?.toDouble() ?? 0,
  currency: json['currency'] as String? ?? 'EGP',
  depositState: json['depositState'] as String? ?? 'None',
  deadlineUtc: json['deadlineUtc'] as String?,
);

DashboardActivityModel _$DashboardActivityModelFromJson(
  Map<String, dynamic> json,
) => DashboardActivityModel(
  bookingId: json['bookingId'] as String,
  reference: json['reference'] as String,
  fromStatus: (json['fromStatus'] as num).toInt(),
  toStatus: (json['toStatus'] as num).toInt(),
  changedAtUtc: json['changedAtUtc'] as String,
  reason: json['reason'] as String?,
);
