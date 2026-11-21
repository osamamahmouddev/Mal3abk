import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/services/realtime_service.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/utils/idempotency_keys.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../booking/data/models/booking_quote_request_body.dart';
import '../../../booking/data/models/create_booking_request_body.dart';
import '../../../booking/domain/use_cases/create_booking_use_case.dart';
import '../../../booking/domain/use_cases/get_booking_quote_use_case.dart';
import '../../data/models/venue_availability_model.dart';
import '../../domain/use_cases/get_venue_availability_use_case.dart';
import 'pitch_booking_state.dart';
import 'pitch_slot_filter.dart';

class PitchBookingCubit extends Cubit<PitchBookingState>
    with SafeEmitCubitMixin<PitchBookingState> {
  PitchBookingCubit({
    required this.getVenueAvailabilityUseCase,
    required this.getBookingQuoteUseCase,
    required this.createBookingUseCase,
    this.realtime,
  }) : super(const PitchBookingInitial()) {
    _subscriptions = [
      ?realtime?.slotUpdates.listen(_onSlotUpdate),
      ?realtime?.reconnected.listen((_) => refreshSlots()),
    ];
  }

  final GetVenueAvailabilityUseCase getVenueAvailabilityUseCase;
  final GetBookingQuoteUseCase getBookingQuoteUseCase;
  final CreateBookingUseCase createBookingUseCase;

  /// Live slot changes; without it the screen still works, just not live.
  final RealtimeService? realtime;

  /// Booking errors meaning someone else got the slot first.
  static const Set<String> slotTakenCodes = {
    'Booking.SlotOverlap',
    'Quote.SlotUnavailable',
  };

  final IdempotencyKeys _idempotencyKeys = IdempotencyKeys();
  String? _currentVenueId;
  late final List<StreamSubscription<Object?>> _subscriptions;

  /// The venue day followed live (venue id, business date).
  (String, String)? _watched;

  /// Newest change seen per slot: a late, older update is ignored.
  final Map<String, DateTime> _lastChange = {};

  String _formatDate(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  Future<void> loadAvailability(
    String venueId, {
    int dayIndex = 0,
    int pitchIndex = 0,
  }) async {
    _currentVenueId = venueId;
    emitIfOpen(const PitchBookingLoading());

    final targetDate = CairoTime.today().add(Duration(days: dayIndex));
    final dateStr = _formatDate(targetDate);

    final availResult = await getVenueAvailabilityUseCase(venueId, dateStr);

    await availResult.when(
      success: (availability) async {
        SlotModel? initialSlot;
        if (availability.pitches.isNotEmpty) {
          final validPitchIndex = pitchIndex < availability.pitches.length
              ? pitchIndex
              : 0;
          final slots = availability.pitches[validPitchIndex].slots;
          for (final s in slots) {
            if (s.isAvailable) {
              initialSlot = s;
              break;
            }
          }
        }

        final loadedState = PitchBookingLoaded(
          availability: availability,
          selectedPitchIndex: pitchIndex,
          selectedDayIndex: dayIndex,
          selectedSlot: initialSlot,
        );
        emitIfOpen(loadedState);
        _watch(venueId, dateStr);

        if (initialSlot != null) {
          await fetchQuoteForSlot(initialSlot);
        }
      },
      failure: (failure) {
        emitIfOpen(PitchBookingError(failure.message));
      },
    );
  }

  Future<void> selectDay(int dayIndex) async {
    if (_currentVenueId == null) return;
    final current = state;
    if (current is! PitchBookingLoaded) {
      await loadAvailability(_currentVenueId!, dayIndex: dayIndex);
      return;
    }

    emitIfOpen(
      current.copyWith(
        selectedDayIndex: dayIndex,
        isSlotsLoading: true,
        clearSelectedSlot: true,
        clearQuote: true,
        clearQuoteError: true,
      ),
    );

    final targetDate = CairoTime.today().add(Duration(days: dayIndex));
    final dateStr = _formatDate(targetDate);
    final availResult = await getVenueAvailabilityUseCase(
      _currentVenueId!,
      dateStr,
    );

    await availResult.when(
      success: (availability) async {
        final validPitchIndex =
            current.selectedPitchIndex < availability.pitches.length
            ? current.selectedPitchIndex
            : 0;

        SlotModel? initialSlot;
        if (availability.pitches.isNotEmpty) {
          final slots = availability.pitches[validPitchIndex].slots;
          for (final s in slots) {
            if (s.isAvailable) {
              initialSlot = s;
              break;
            }
          }
        }

        emitIfOpen(
          current.copyWith(
            availability: availability,
            selectedPitchIndex: validPitchIndex,
            selectedDayIndex: dayIndex,
            selectedSlot: initialSlot,
            // A day with nothing free must not keep the previous day's slot.
            clearSelectedSlot: initialSlot == null,
            clearQuote: true,
            isSlotsLoading: false,
          ),
        );
        _watch(_currentVenueId!, dateStr);

        if (initialSlot != null) {
          await fetchQuoteForSlot(initialSlot);
        }
      },
      failure: (failure) {
        emitIfOpen(
          current.copyWith(
            isSlotsLoading: false,
            bookingError: failure.message,
          ),
        );
      },
    );
  }

  Future<void> selectPitch(int pitchIndex) async {
    final current = state;
    if (current is! PitchBookingLoaded) return;
    if (pitchIndex >= current.availability.pitches.length) return;

    final slots = current.availability.pitches[pitchIndex].slots;
    SlotModel? nextSlot;
    for (final s in slots) {
      if (s.isAvailable) {
        nextSlot = s;
        break;
      }
    }

    emitIfOpen(
      current.copyWith(
        selectedPitchIndex: pitchIndex,
        selectedSlot: nextSlot,
        clearQuote: true,
        clearQuoteError: true,
      ),
    );

    if (nextSlot != null) {
      await fetchQuoteForSlot(nextSlot);
    }
  }

  Future<void> selectSlot(SlotModel slot) async {
    final current = state;
    if (current is! PitchBookingLoaded) return;

    emitIfOpen(
      current.copyWith(
        selectedSlot: slot,
        clearQuote: true,
        clearQuoteError: true,
      ),
    );

    await fetchQuoteForSlot(slot);
  }

  /// Shows only the slots of [filter]; tapping the active filter again shows
  /// every slot.
  void toggleSlotFilter(PitchSlotFilter filter) {
    final current = state;
    if (current is! PitchBookingLoaded) return;
    emitIfOpen(
      current.copyWith(
        slotFilter: current.slotFilter == filter ? PitchSlotFilter.all : filter,
      ),
    );
  }

  /// Fetches the price of the selected slot when it is missing and not on its
  /// way (the review screen opened before a quote arrived, or it failed
  /// silently).
  Future<void> ensureQuote() async {
    final current = state;
    if (current is! PitchBookingLoaded) return;
    final slot = current.selectedSlot;
    if (slot == null || current.quote != null || current.isQuoting) return;
    await fetchQuoteForSlot(slot);
  }

  /// Bumped per quote request; only the latest request's answer is kept, so a
  /// slow answer for a slot the player already left never lands on another.
  int _quoteRequest = 0;

  Future<void> fetchQuoteForSlot(SlotModel slot) async {
    final current = state;
    if (current is! PitchBookingLoaded) return;
    final pitch = current.currentPitch;
    if (pitch == null) return;
    final request = ++_quoteRequest;

    emitIfOpen(current.copyWith(isQuoting: true, clearQuoteError: true));

    final result = await getBookingQuoteUseCase(
      BookingQuoteRequestBody(
        pitchId: pitch.pitchId,
        startUtc: slot.startUtc,
        endUtc: slot.endUtc,
      ),
    );

    final updated = state;
    if (updated is! PitchBookingLoaded || request != _quoteRequest) return;
    if (updated.selectedSlot?.startUtc != slot.startUtc) return;

    result.when(
      success: (quote) {
        emitIfOpen(updated.copyWith(quote: quote, isQuoting: false));
      },
      failure: (failure) {
        emitIfOpen(
          updated.copyWith(isQuoting: false, quoteError: failure.message),
        );
      },
    );
  }

  /// Holds the slot for the signed-in player; the server books it under
  /// their own account.
  Future<bool> createBookingHold() async {
    final current = state;
    if (current is! PitchBookingLoaded) return false;
    final pitch = current.currentPitch;
    final slot = current.selectedSlot;
    final quote = current.quote;

    if (pitch == null || slot == null || quote == null) return false;

    emitIfOpen(current.copyWith(isBooking: true, clearBookingError: true));

    final operation =
        'create:${pitch.pitchId}:${slot.startUtc}:${quote.quoteToken}';
    final idempotencyKey = _idempotencyKeys.keyFor(operation);
    final result = await createBookingUseCase(
      body: CreateBookingRequestBody(
        pitchId: pitch.pitchId,
        startUtc: slot.startUtc,
        endUtc: slot.endUtc,
        quoteToken: quote.quoteToken,
        expectedPrice: quote.total,
      ),
      idempotencyKey: idempotencyKey,
    );

    final updated = state;
    if (updated is! PitchBookingLoaded) return false;

    return result.when(
      success: (booking) {
        _idempotencyKeys.complete(operation);
        emitIfOpen(updated.copyWith(isBooking: false, createdBooking: booking));
        return true;
      },
      failure: (failure) {
        final taken = slotTakenCodes.contains(failure.code);
        emitIfOpen(
          updated.copyWith(
            isBooking: false,
            bookingError: failure.message,
            selectedSlotTaken: taken ? true : null,
          ),
        );
        // Someone booked it first: show the day as it is now.
        if (taken) unawaited(refreshSlots());
        return false;
      },
    );
  }

  /// Reloads the shown day's slots in place, keeping the player's choices
  /// (after a reconnect, or when the slot turned out to be taken).
  Future<void> refreshSlots() async {
    final venueId = _currentVenueId;
    final current = state;
    if (venueId == null || current is! PitchBookingLoaded) return;
    final result = await getVenueAvailabilityUseCase(
      venueId,
      current.availability.businessDate,
    );
    final latest = state;
    if (latest is! PitchBookingLoaded) return;
    result.maybeWhen(
      success: (availability) {
        _lastChange.clear();
        final selected = latest.selectedSlot;
        final fresh = selected == null
            ? null
            : _findSlot(availability, latest.currentPitch?.pitchId, selected);
        emitIfOpen(
          latest.copyWith(
            availability: availability,
            selectedSlotTaken: _takenByOthers(latest, fresh),
          ),
        );
      },
      orElse: () {},
    );
  }

  /// Applies a live slot change to the day on screen.
  void _onSlotUpdate(SlotStatusUpdate update) {
    final current = state;
    if (current is! PitchBookingLoaded) return;
    if (update.venueId.isNotEmpty && update.venueId != _currentVenueId) return;

    final key = '${update.pitchId}|${update.startUtc.toIso8601String()}';
    final last = _lastChange[key];
    if (last != null && !update.changedAtUtc.isAfter(last)) return;

    var changed = false;
    final pitches = [
      for (final pitch in current.availability.pitches)
        if (pitch.pitchId != update.pitchId)
          pitch
        else
          PitchSlotsModel(
            pitchId: pitch.pitchId,
            name: pitch.name,
            slotMinutes: pitch.slotMinutes,
            incrementMinutes: pitch.incrementMinutes,
            slots: [
              for (final slot in pitch.slots)
                if (_sameStart(slot, update.startUtc) &&
                    slot.state != update.slotState)
                  (() {
                    changed = true;
                    return SlotModel(
                      startUtc: slot.startUtc,
                      endUtc: slot.endUtc,
                      startLocal: slot.startLocal,
                      endLocal: slot.endLocal,
                      state: update.slotState,
                      price: slot.price,
                    );
                  })()
                else
                  slot,
            ],
          ),
    ];
    _lastChange[key] = update.changedAtUtc;
    if (!changed) return;

    final availability = VenueAvailabilityModel(
      venueId: current.availability.venueId,
      businessDate: current.availability.businessDate,
      currency: current.availability.currency,
      pitches: pitches,
      generatedAtUtc: current.availability.generatedAtUtc,
      nextChangeUtc: current.availability.nextChangeUtc,
    );
    final selected = current.selectedSlot;
    final fresh = selected == null
        ? null
        : _findSlot(availability, current.currentPitch?.pitchId, selected);
    emitIfOpen(
      current.copyWith(
        availability: availability,
        selectedSlotTaken: _takenByOthers(current, fresh),
      ),
    );
  }

  /// Whether the selected slot, as it stands now ([fresh]), was taken by
  /// someone else. The player's own hold in flight or done does not count.
  bool _takenByOthers(PitchBookingLoaded state, SlotModel? fresh) {
    if (fresh == null || fresh.isAvailable) return false;
    return !state.isBooking && state.createdBooking == null;
  }

  static SlotModel? _findSlot(
    VenueAvailabilityModel availability,
    String? pitchId,
    SlotModel selected,
  ) {
    final start = DateTime.tryParse(selected.startUtc);
    if (pitchId == null || start == null) return null;
    for (final pitch in availability.pitches) {
      if (pitch.pitchId != pitchId) continue;
      for (final slot in pitch.slots) {
        if (_sameStart(slot, start.toUtc())) return slot;
      }
    }
    return null;
  }

  static bool _sameStart(SlotModel slot, DateTime startUtc) {
    final start = DateTime.tryParse(slot.startUtc);
    return start != null && start.toUtc().isAtSameMomentAs(startUtc);
  }

  /// Follows [date] at [venueId] live, leaving the day followed before.
  void _watch(String venueId, String date) {
    final live = realtime;
    if (live == null || _watched == (venueId, date)) return;
    final previous = _watched;
    _watched = (venueId, date);
    _lastChange.clear();
    if (previous != null) unawaited(live.leaveVenue(previous.$1, previous.$2));
    unawaited(live.watchVenue(venueId, date));
  }

  @override
  Future<void> close() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    final watched = _watched;
    if (watched != null) {
      unawaited(realtime?.leaveVenue(watched.$1, watched.$2));
    }
    return super.close();
  }
}
