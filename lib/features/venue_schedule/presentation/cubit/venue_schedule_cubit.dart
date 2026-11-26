import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../venue_setup/data/models/venue_setup_form.dart';
import '../../data/models/venue_schedule_models.dart';
import '../../domain/repos/venue_schedule_repo.dart';

part 'venue_schedule_cubit.freezed.dart';

@freezed
abstract class VenueScheduleState with _$VenueScheduleState {
  const factory VenueScheduleState({
    /// Null: the venue's own hours; otherwise that pitch's.
    String? pitchId,
    required Map<int, DayHours> week,
    @Default(SpecialSchedulesModel()) SpecialSchedulesModel special,
    @Default(true) bool loading,
    @Default(false) bool saving,
    String? error,
  }) = _VenueScheduleState;
}

/// What a save did: done, held back by bookings it hits, or failed.
sealed class ScheduleSaveOutcome {
  const ScheduleSaveOutcome();
}

class ScheduleSaved extends ScheduleSaveOutcome {
  const ScheduleSaved();
}

class ScheduleNeedsConfirm extends ScheduleSaveOutcome {
  const ScheduleNeedsConfirm(this.affected);
  final List<UpcomingBookingRefModel> affected;
}

class ScheduleSaveFailed extends ScheduleSaveOutcome {
  const ScheduleSaveFailed(this.message);
  final String message;
}

/// The web "hours" page: weekly hours of the venue or one pitch, closed days
/// and holidays, and booking rules.
class VenueScheduleCubit extends Cubit<VenueScheduleState>
    with SafeEmitCubitMixin<VenueScheduleState> {
  VenueScheduleCubit({required this.venueScheduleRepo, required this.venueId})
    : super(VenueScheduleState(week: DayHours.defaultWeek()));

  final VenueScheduleRepo venueScheduleRepo;
  final String venueId;

  Future<void> load() async {
    emitIfOpen(state.copyWith(loading: true, error: null));
    final special = await venueScheduleRepo.getSpecialSchedules(venueId);
    special.when(
      success: (s) => emitIfOpen(state.copyWith(special: s)),
      failure: (f) => emitIfOpen(state.copyWith(error: f.message)),
    );
    await _loadWeek();
    emitIfOpen(state.copyWith(loading: false));
  }

  Future<void> _loadWeek() async {
    final pitchId = state.pitchId;
    if (pitchId != null) {
      final hours = state.special.pitchHours.where((h) => h.pitchId == pitchId);
      // A pitch without hours of its own follows the venue's.
      if (hours.isEmpty) {
        await _loadVenueWeek();
        return;
      }
      final week = {
        for (final d in DayHours.dayOrder)
          d: DayHours.defaultWeek()[d]!.copyWith(on: false),
      };
      for (final h in hours) {
        week[h.dayOfWeek] = DayHours(
          on: !h.isClosed,
          open: h.openTime.substring(0, 5),
          close: h.closeTime.substring(0, 5),
        );
      }
      emitIfOpen(state.copyWith(week: week));
      return;
    }
    await _loadVenueWeek();
  }

  Future<void> _loadVenueWeek() async {
    final result = await venueScheduleRepo.getVenueWeek(venueId);
    result.when(
      success: (list) {
        if (list.isEmpty) {
          emitIfOpen(state.copyWith(week: DayHours.defaultWeek()));
          return;
        }
        final week = {
          for (final d in DayHours.dayOrder)
            d: DayHours.defaultWeek()[d]!.copyWith(on: false),
        };
        for (final s in list) {
          week[s.dayOfWeek] = DayHours(
            on: s.isActive,
            open: s.openTime.substring(0, 5),
            close: s.closeTime.substring(0, 5),
            slot: s.slotDurationMinutes,
          );
        }
        emitIfOpen(state.copyWith(week: week));
      },
      failure: (f) => emitIfOpen(state.copyWith(error: f.message)),
    );
  }

  bool get hasOwnPitchHours =>
      state.pitchId != null &&
      state.special.pitchHours.any((h) => h.pitchId == state.pitchId);

  Future<void> selectPitch(String? pitchId) async {
    emitIfOpen(state.copyWith(pitchId: pitchId, loading: true));
    await _loadWeek();
    emitIfOpen(state.copyWith(loading: false));
  }

  void setDay(int day, DayHours hours) =>
      emitIfOpen(state.copyWith(week: {...state.week, day: hours}));

  /// Venue hours: asks which bookings the change hits first ([confirm]
  /// false); pitch hours: the API holds the change back itself.
  Future<ScheduleSaveOutcome> saveWeek({bool confirm = false}) =>
      _save(() async {
        final pitchId = state.pitchId;
        if (pitchId == null) {
          if (!confirm) {
            final affected = (await venueScheduleRepo.previewVenueWeek(
              venueId,
              state.week,
            )).when(success: (a) => a, failure: (f) => throw f);
            if (affected.isNotEmpty) return ScheduleNeedsConfirm(affected);
          }
          (await venueScheduleRepo.saveVenueWeek(
            venueId,
            state.week,
          )).when(success: (_) {}, failure: (f) => throw f);
          return const ScheduleSaved();
        }
        return _fromChange(
          await venueScheduleRepo.savePitchWeek(
            venueId,
            pitchId,
            state.week,
            confirm: confirm,
          ),
        );
      });

  Future<ScheduleSaveOutcome> addOverride({
    required ScheduleOverrideKind kind,
    required String startDate,
    String? endDate,
    String? fromTime,
    String? toTime,
    required String reason,
    required bool allPitches,
    bool confirm = false,
  }) => _save(
    () async => _fromChange(
      await venueScheduleRepo.addOverride(
        venueId,
        pitchId: allPitches ? null : state.pitchId,
        startDate: startDate,
        endDate: endDate,
        kind: kind,
        fromTime: fromTime,
        toTime: toTime,
        reason: reason,
        confirm: confirm,
      ),
    ),
  );

  Future<ScheduleSaveOutcome> closeHolidays({
    required int year,
    required bool allPitches,
    bool confirm = false,
  }) => _save(
    () async => _fromChange(
      await venueScheduleRepo.closeHolidays(
        venueId,
        year: year,
        pitchId: allPitches ? null : state.pitchId,
        confirm: confirm,
      ),
    ),
  );

  Future<ScheduleSaveOutcome> removeOverride(String overrideId) =>
      _save(() async {
        (await venueScheduleRepo.removeOverride(
          venueId,
          overrideId,
        )).when(success: (_) {}, failure: (f) => throw f);
        return const ScheduleSaved();
      });

  BookingRulesModel get currentRules =>
      state.special.rules
          .where((r) => r.pitchId == state.pitchId)
          .firstOrNull ??
      state.special.rules.where((r) => r.pitchId == null).firstOrNull ??
      BookingRulesModel(pitchId: state.pitchId);

  Future<ScheduleSaveOutcome> saveRules(BookingRulesModel rules) =>
      _save(() async {
        (await venueScheduleRepo.saveRules(
          venueId,
          BookingRulesModel(
            pitchId: state.pitchId,
            minDurationMinutes: rules.minDurationMinutes,
            maxDurationMinutes: rules.maxDurationMinutes,
            incrementMinutes: rules.incrementMinutes,
            minNoticeMinutes: rules.minNoticeMinutes,
            maxAdvanceDays: rules.maxAdvanceDays,
          ),
        )).when(success: (_) {}, failure: (f) => throw f);
        return const ScheduleSaved();
      });

  static ScheduleSaveOutcome _fromChange(
    ApiResult<ScheduleChangeResult> result,
  ) => result.when(
    success: (r) =>
        r.applied ? const ScheduleSaved() : ScheduleNeedsConfirm(r.affected),
    failure: (f) => throw f,
  );

  Future<ScheduleSaveOutcome> _save(
    Future<ScheduleSaveOutcome> Function() action,
  ) async {
    emitIfOpen(state.copyWith(saving: true));
    try {
      final outcome = await action();
      if (outcome is ScheduleSaved) {
        final special = await venueScheduleRepo.getSpecialSchedules(venueId);
        special.when(
          success: (s) => emitIfOpen(state.copyWith(special: s)),
          failure: (_) {},
        );
      }
      return outcome;
    } on Object catch (e) {
      return ScheduleSaveFailed(
        e is AppApiFailure ? e.message : 'common.unexpected_error',
      );
    } finally {
      emitIfOpen(state.copyWith(saving: false));
    }
  }
}
