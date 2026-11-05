import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../booking/data/models/booking_quote_request_body.dart';
import '../../../booking/data/models/create_booking_request_body.dart';
import '../../../booking/domain/use_cases/create_booking_use_case.dart';
import '../../../booking/domain/use_cases/get_booking_quote_use_case.dart';
import '../../data/models/venue_availability_model.dart';
import '../../data/models/venue_payment_method_model.dart';
import '../../domain/use_cases/get_venue_availability_use_case.dart';
import '../../domain/use_cases/get_venue_payment_methods_use_case.dart';
import 'pitch_booking_state.dart';

class PitchBookingCubit extends Cubit<PitchBookingState> {
  PitchBookingCubit({
    required this.getVenueAvailabilityUseCase,
    required this.getVenuePaymentMethodsUseCase,
    required this.getBookingQuoteUseCase,
    required this.createBookingUseCase,
  }) : super(const PitchBookingInitial());

  final GetVenueAvailabilityUseCase getVenueAvailabilityUseCase;
  final GetVenuePaymentMethodsUseCase getVenuePaymentMethodsUseCase;
  final GetBookingQuoteUseCase getBookingQuoteUseCase;
  final CreateBookingUseCase createBookingUseCase;

  String? _currentVenueId;

  String _formatDate(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  String _generateUuidV4() {
    final rng = Random.secure();
    final bytes = List<int>.generate(16, (_) => rng.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    return [
      bytes
          .sublist(0, 4)
          .map((b) => b.toRadixString(16).padLeft(2, '0'))
          .join(),
      bytes
          .sublist(4, 6)
          .map((b) => b.toRadixString(16).padLeft(2, '0'))
          .join(),
      bytes
          .sublist(6, 8)
          .map((b) => b.toRadixString(16).padLeft(2, '0'))
          .join(),
      bytes
          .sublist(8, 10)
          .map((b) => b.toRadixString(16).padLeft(2, '0'))
          .join(),
      bytes
          .sublist(10, 16)
          .map((b) => b.toRadixString(16).padLeft(2, '0'))
          .join(),
    ].join('-');
  }

  Future<void> loadAvailability(
    String venueId, {
    int dayIndex = 0,
    int pitchIndex = 0,
  }) async {
    _currentVenueId = venueId;
    emit(const PitchBookingLoading());

    final targetDate = DateTime.now().add(Duration(days: dayIndex));
    final dateStr = _formatDate(targetDate);

    final availResult = await getVenueAvailabilityUseCase(venueId, dateStr);
    final paymentResult = await getVenuePaymentMethodsUseCase(venueId);

    await availResult.when(
      success: (availability) async {
        final paymentMethods = paymentResult.when(
          success: (methods) => methods,
          failure: (_) => const <VenuePaymentMethodModel>[],
        );

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
          paymentMethods: paymentMethods,
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
      await loadAvailability(
        _currentVenueId!,
        dayIndex: dayIndex,
      );
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

    final targetDate = DateTime.now().add(Duration(days: dayIndex));
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

  Future<bool> createBookingHold({
    required String customerName,
    required String customerPhone,
  }) async {
    final current = state;
    if (current is! PitchBookingLoaded) return false;
    final pitch = current.currentPitch;
    final slot = current.selectedSlot;
    final quote = current.quote;

    if (pitch == null || slot == null || quote == null) return false;

    emit(current.copyWith(isBooking: true, clearBookingError: true));

    final idempotencyKey = _generateUuidV4();
    final result = await createBookingUseCase(
      body: CreateBookingRequestBody(
        pitchId: pitch.pitchId,
        startUtc: slot.startUtc,
        endUtc: slot.endUtc,
        quoteToken: quote.quoteToken,
        expectedPrice: quote.total,
        customerName: customerName,
        customerPhone: customerPhone,
      ),
      idempotencyKey: idempotencyKey,
    );

    final updated = state;
    if (updated is! PitchBookingLoaded) return false;

    return result.when(
      success: (booking) {
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
