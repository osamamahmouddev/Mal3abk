import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../data/models/venue_report_models.dart';
import '../../domain/repos/venue_reports_repo.dart';

part 'venue_reports_cubit.freezed.dart';

enum ReportPreset { week, month, quarter, custom }

@freezed
abstract class VenueReportsState with _$VenueReportsState {
  const factory VenueReportsState({
    @Default(ReportPreset.week) ReportPreset preset,
    required DateTime customFrom,
    required DateTime customTo,
    String? pitchId,
    VenueReportModel? report,
    @Default(true) bool loading,
    @Default(false) bool exporting,
    String? error,
  }) = _VenueReportsState;
}

/// The web reports page: a period (7 days, 30 days, 3 months or custom),
/// optionally one pitch, and the bookings CSV of that period.
class VenueReportsCubit extends Cubit<VenueReportsState>
    with SafeEmitCubitMixin<VenueReportsState> {
  VenueReportsCubit({required this.venueReportsRepo, required this.venueId})
    : super(
        VenueReportsState(
          customFrom: CairoTime.today().subtract(const Duration(days: 13)),
          customTo: CairoTime.today(),
        ),
      );

  final VenueReportsRepo venueReportsRepo;
  final String venueId;
  int _generation = 0;

  /// (from, to, groupBy) of the chosen period; groupBy 0 day, 1 week, 2 month.
  (DateTime, DateTime, int) get range {
    final today = CairoTime.today();
    return switch (state.preset) {
      ReportPreset.week => (today.subtract(const Duration(days: 6)), today, 0),
      ReportPreset.month => (
        today.subtract(const Duration(days: 29)),
        today,
        1,
      ),
      ReportPreset.quarter => (
        today.subtract(const Duration(days: 89)),
        today,
        2,
      ),
      ReportPreset.custom => () {
        final days = state.customTo.difference(state.customFrom).inDays;
        return (
          state.customFrom,
          state.customTo,
          days > 92
              ? 2
              : days > 31
              ? 1
              : 0,
        );
      }(),
    };
  }

  Future<void> load() async {
    final (from, to, groupBy) = range;
    if (from.isAfter(to)) return;
    final generation = ++_generation;
    emitIfOpen(state.copyWith(loading: true, error: null));
    final result = await venueReportsRepo.getReport(
      venueId,
      from: VenueFormat.apiDate(from),
      to: VenueFormat.apiDate(to),
      groupBy: groupBy,
      pitchId: state.pitchId,
    );
    if (generation != _generation) return;
    result.when(
      success: (r) => emitIfOpen(state.copyWith(report: r, loading: false)),
      failure: (f) =>
          emitIfOpen(state.copyWith(loading: false, error: f.message)),
    );
  }

  void setPreset(ReportPreset preset) {
    emitIfOpen(state.copyWith(preset: preset));
    load();
  }

  void setCustom({DateTime? from, DateTime? to}) {
    emitIfOpen(
      state.copyWith(
        preset: ReportPreset.custom,
        customFrom: from ?? state.customFrom,
        customTo: to ?? state.customTo,
      ),
    );
    load();
  }

  void setPitch(String? pitchId) {
    emitIfOpen(state.copyWith(pitchId: pitchId));
    load();
  }

  /// The CSV bytes and their file name, or the failure key.
  Future<(List<int>?, String, String?)> exportCsv() async {
    final (from, to, _) = range;
    final name =
        'bookings-${VenueFormat.apiDate(from)}-${VenueFormat.apiDate(to)}.csv';
    emitIfOpen(state.copyWith(exporting: true));
    final result = await venueReportsRepo.exportBookingsCsv(
      venueId,
      from: VenueFormat.apiDate(from),
      to: VenueFormat.apiDate(to),
      pitchId: state.pitchId,
    );
    emitIfOpen(state.copyWith(exporting: false));
    return result.when(
      success: (bytes) => (bytes, name, null),
      failure: (f) => (null, name, f.message),
    );
  }
}

/// The venue's payout statement.
class VenuePayoutsCubit extends Cubit<ApiResult<VenuePayoutStatementModel>?>
    with SafeEmitCubitMixin<ApiResult<VenuePayoutStatementModel>?> {
  VenuePayoutsCubit({required this.venueReportsRepo, required this.venueId})
    : super(null);

  final VenueReportsRepo venueReportsRepo;
  final String venueId;

  Future<void> load() async =>
      emitIfOpen(await venueReportsRepo.getPayouts(venueId));
}
