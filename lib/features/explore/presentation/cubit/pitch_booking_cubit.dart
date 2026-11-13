import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/utils/idempotency_keys.dart';
import '../../../booking/data/models/booking_quote_request_body.dart';
import '../../../booking/data/models/create_booking_request_body.dart';
import '../../../booking/domain/use_cases/create_booking_use_case.dart';
import '../../../booking/domain/use_cases/get_booking_quote_use_case.dart';
import '../../data/models/venue_availability_model.dart';
import '../../domain/use_cases/get_venue_availability_use_case.dart';
import 'pitch_booking_state.dart';
import 'pitch_slot_filter.dart';

class PitchBookingCubit extends Cubit<PitchBookingState> {
  PitchBookingCubit({
    required this.getVenueAvailabilityUseCase,
    required this.getBookingQuoteUseCase,
    required this.createBookingUseCase,
  }) : super(const PitchBookingInitial());

  final GetVenueAvailabilityUseCase getVenueAvailabilityUseCase;
  final GetBookingQuoteUseCase getBookingQuoteUseCase;
  final CreateBookingUseCase createBookingUseCase;

  final IdempotencyKeys _idempotencyKeys = IdempotencyKeys();
  String? _currentVenueId;

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
    emit(const PitchBookingLoading());

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
        emit(loadedState);

        if (initialSlot != null) {
          await fetchQuoteForSlot(initialSlot);
        }
      },
      failure: (failure) {
        emit(PitchBookingError(failure.message));
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

    emit(
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

        emit(
          current.copyWith(
            availability: availability,
            selectedPitchIndex: validPitchIndex,
            selectedDayIndex: dayIndex,
            selectedSlot: initialSlot,
            isSlotsLoading: false,
          ),
        );

        if (initialSlot != null) {
          await fetchQuoteForSlot(initialSlot);
        }
      },
      failure: (failure) {
        emit(
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

    emit(
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

    emit(
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
    emit(
      current.copyWith(
        slotFilter: current.slotFilter == filter ? PitchSlotFilter.all : filter,
      ),
    );
  }

  Future<void> fetchQuoteForSlot(SlotModel slot) async {
    final current = state;
    if (current is! PitchBookingLoaded) return;
    final pitch = current.currentPitch;
    if (pitch == null) return;

    emit(current.copyWith(isQuoting: true, clearQuoteError: true));

    final result = await getBookingQuoteUseCase(
      BookingQuoteRequestBody(
        pitchId: pitch.pitchId,
        startUtc: slot.startUtc,
        endUtc: slot.endUtc,
      ),
    );

    final updated = state;
    if (updated is! PitchBookingLoaded) return;

    result.when(
      success: (quote) {
        emit(updated.copyWith(quote: quote, isQuoting: false));
      },
      failure: (failure) {
        emit(updated.copyWith(isQuoting: false, quoteError: failure.message));
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

    emit(current.copyWith(isBooking: true, clearBookingError: true));

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
        emit(updated.copyWith(isBooking: false, createdBooking: booking));
        return true;
      },
      failure: (failure) {
        emit(updated.copyWith(isBooking: false, bookingError: failure.message));
        return false;
      },
    );
  }
}
