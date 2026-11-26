import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/calendar_slot_model.dart';
import '../../data/models/manual_booking_request_body.dart';
import '../../domain/repos/venue_calendar_repo.dart';
import 'venue_calendar_state.dart';

class VenueCalendarCubit extends Cubit<VenueCalendarState>
    with SafeEmitCubitMixin<VenueCalendarState> {
  VenueCalendarCubit({
    required this.venueCalendarRepo,
    this.refreshInterval = const Duration(seconds: 60),
  }) : super(
         VenueCalendarState(
           view: VenueCalendarView.day,
           date: CairoTime.today(),
         ),
       );

  final VenueCalendarRepo venueCalendarRepo;
  final Duration refreshInterval;

  late String _venueId;
  Timer? _timer;
  int _generation = 0;

  String get venueId => _venueId;

  Future<void> start(String venueId, {String? firstPitchId}) async {
    _venueId = venueId;
    emitIfOpen(state.copyWith(weekPitchId: state.weekPitchId ?? firstPitchId));
    unawaited(_loadSchedules());
    await load();
  }

  Future<void> _loadSchedules() async {
    final result = await venueCalendarRepo.getSchedules(_venueId);
    result.when(
      success: (s) => emitIfOpen(state.copyWith(schedules: s)),
      failure: (_) {},
    );
  }

  /// Saturday-first weeks, like the web calendar.
  static DateTime weekStart(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday + 1) % 7);

  static DateTime monthStart(DateTime date) => DateTime(date.year, date.month);

  /// UTC start of a Cairo business day.
  static DateTime dayStartUtc(DateTime date) => CairoTime.toUtc(date, 0);

  (DateTime, int) _range() => switch (state.view) {
    VenueCalendarView.day => (state.date, 2),
    VenueCalendarView.week => (weekStart(state.date), 8),
    VenueCalendarView.month => (
      monthStart(state.date),
      DateTime(state.date.year, state.date.month + 1, 0).day + 1,
    ),
  };

  Future<void> load({bool silent = false}) async {
    _timer?.cancel();
    final generation = ++_generation;
    if (!silent) emitIfOpen(state.copyWith(isLoading: true, error: null));
    final (from, days) = _range();
    final result = await venueCalendarRepo.getCalendar(
      _venueId,
      fromUtc: dayStartUtc(from),
      toUtc: dayStartUtc(DateTime(from.year, from.month, from.day + days)),
      pitchId: state.view == VenueCalendarView.week ? state.weekPitchId : null,
    );
    if (generation != _generation) return;
    result.when(
      success: (slots) => emitIfOpen(
        state.copyWith(slots: slots, isLoading: false, error: null),
      ),
      failure: (f) =>
          emitIfOpen(state.copyWith(isLoading: false, error: f.message)),
    );
    if (refreshInterval > Duration.zero && !isClosed) {
      _timer = Timer(refreshInterval, () => load(silent: true));
    }
  }

  void setView(VenueCalendarView view) {
    if (view == state.view) return;
    emitIfOpen(
      state.copyWith(
        view: view,
        picking: view == VenueCalendarView.month ? false : state.picking,
        pickedHours: const {},
        pickedTaken: const {},
      ),
    );
    load();
  }

  void openDay(DateTime date) {
    emitIfOpen(state.copyWith(view: VenueCalendarView.day, date: date));
    load();
  }

  void goToday() {
    emitIfOpen(state.copyWith(date: CairoTime.today()));
    load();
  }

  /// Moves one day, week or month back ([forward] false) or ahead.
  void step({required bool forward}) {
    final d = state.date;
    final sign = forward ? 1 : -1;
    final next = switch (state.view) {
      VenueCalendarView.day => DateTime(d.year, d.month, d.day + sign),
      VenueCalendarView.week => DateTime(d.year, d.month, d.day + 7 * sign),
      VenueCalendarView.month => DateTime(d.year, d.month + sign),
    };
    emitIfOpen(state.copyWith(date: next));
    load();
  }

  void setWeekPitch(String pitchId) {
    emitIfOpen(
      state.copyWith(
        weekPitchId: pitchId,
        pickedHours: const {},
        pickedTaken: const {},
      ),
    );
    load();
  }

  void togglePicking() => emitIfOpen(
    state.copyWith(
      picking: !state.picking,
      pickedHours: const {},
      pickedTaken: const {},
    ),
  );

  void toggleHour(CalendarHour hour) {
    final next = {...state.pickedHours};
    if (next.remove(hour.key) == null) next[hour.key] = hour;
    emitIfOpen(state.copyWith(pickedHours: next));
  }

  /// Picks every free hour of a column, or unpicks them if all are picked.
  void toggleAll(List<CalendarHour> hours) {
    final next = {...state.pickedHours};
    final allPicked = hours.every((h) => next.containsKey(h.key));
    for (final h in hours) {
      if (allPicked) {
        next.remove(h.key);
      } else {
        next[h.key] = h;
      }
    }
    emitIfOpen(state.copyWith(pickedHours: next));
  }

  /// Returns false for an app booking, which is cancelled from bookings.
  bool toggleTaken(CalendarSlotModel slot) {
    if (!slot.isBlocked && !slot.isOpenManual) return false;
    final next = {...state.pickedTaken};
    if (next.remove(slot.id) == null) next[slot.id] = slot.isBlocked;
    emitIfOpen(state.copyWith(pickedTaken: next));
    return true;
  }

  void clearPicks({bool stopPicking = false}) => emitIfOpen(
    state.copyWith(
      pickedHours: const {},
      pickedTaken: const {},
      picking: stopPicking ? false : state.picking,
    ),
  );

  Future<ApiResult<BulkOutcome>> bookPicked({
    required ManualPaymentStatus status,
    String? customerName,
    String? customerPhone,
    double? pricePerHour,
  }) => _busy(
    () => venueCalendarRepo.bulkBook(
      _venueId,
      hours: state.pickedHours.values.toList(),
      status: status,
      customerName: customerName,
      customerPhone: customerPhone,
      pricePerHour: pricePerHour,
    ),
  );

  Future<ApiResult<BulkOutcome>> releasePicked() => _busy(
    () => venueCalendarRepo.release(
      _venueId,
      bookingIds: [
        for (final e in state.pickedTaken.entries)
          if (!e.value) e.key,
      ],
      blockedSlotIds: [
        for (final e in state.pickedTaken.entries)
          if (e.value) e.key,
      ],
    ),
  );

  Future<ApiResult<void>> blockSlot({
    required String pitchId,
    required DateTime startUtc,
    required int hours,
    required String reason,
  }) => _busy(
    () => venueCalendarRepo.blockSlot(
      _venueId,
      pitchId: pitchId,
      startUtc: startUtc,
      endUtc: startUtc.add(Duration(hours: hours)),
      reason: reason,
    ),
  );

  Future<ApiResult<void>> unblock(String slotId) =>
      _busy(() => venueCalendarRepo.unblockSlot(_venueId, slotId));

  Future<ApiResult<void>> confirmManual(String bookingId) =>
      _busy(() => venueCalendarRepo.confirmManual(_venueId, bookingId));

  Future<ApiResult<void>> cancelManual(String bookingId, String reason) =>
      _busy(() => venueCalendarRepo.cancelBooking(_venueId, bookingId, reason));

  /// Runs a change, then reloads the calendar when it worked.
  Future<ApiResult<T>> _busy<T>(Future<ApiResult<T>> Function() call) async {
    emitIfOpen(state.copyWith(busy: true));
    final result = await call();
    emitIfOpen(state.copyWith(busy: false));
    final ok = result.when(success: (_) => true, failure: (_) => false);
    if (ok) {
      clearPicks();
      await load(silent: true);
    }
    return result;
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
