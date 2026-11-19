import '../../data/models/venue_availability_model.dart';
import '../../../booking/data/models/booking_quote_response_model.dart';
import '../../../booking/data/models/create_booking_response_model.dart';
import 'pitch_slot_filter.dart';

sealed class PitchBookingState {
  const PitchBookingState();
}

class PitchBookingInitial extends PitchBookingState {
  const PitchBookingInitial();
}

class PitchBookingLoading extends PitchBookingState {
  const PitchBookingLoading();
}

class PitchBookingLoaded extends PitchBookingState {
  const PitchBookingLoaded({
    required this.availability,
    required this.selectedPitchIndex,
    required this.selectedDayIndex,
    this.selectedSlot,
    this.quote,
    this.isQuoting = false,
    this.quoteError,
    this.isBooking = false,
    this.createdBooking,
    this.bookingError,
    this.isSlotsLoading = false,
    this.slotFilter = PitchSlotFilter.all,
    this.selectedSlotTaken = false,
  });

  /// Someone else just held or booked [selectedSlot] (a live update): the
  /// player has to pick another time.
  final bool selectedSlotTaken;

  final VenueAvailabilityModel availability;
  final int selectedPitchIndex;
  final int selectedDayIndex;
  final SlotModel? selectedSlot;
  final BookingQuoteResponseModel? quote;
  final bool isQuoting;
  final String? quoteError;
  final bool isBooking;
  final CreateBookingResponseModel? createdBooking;
  final String? bookingError;
  final bool isSlotsLoading;
  final PitchSlotFilter slotFilter;

  PitchSlotsModel? get currentPitch {
    if (availability.pitches.isEmpty) return null;
    if (selectedPitchIndex < availability.pitches.length) {
      return availability.pitches[selectedPitchIndex];
    }
    return availability.pitches.first;
  }

  /// The current pitch's slots that pass [slotFilter].
  List<SlotModel> get visibleSlots {
    final slots = currentPitch?.slots ?? const <SlotModel>[];
    return switch (slotFilter) {
      PitchSlotFilter.all => slots,
      PitchSlotFilter.selected => [
        for (final s in slots)
          if (s.startUtc == selectedSlot?.startUtc) s,
      ],
      PitchSlotFilter.available => [
        for (final s in slots)
          if (s.isAvailable) s,
      ],
      PitchSlotFilter.booked => [
        for (final s in slots)
          if (!s.isAvailable) s,
      ],
    };
  }

  PitchBookingLoaded copyWith({
    VenueAvailabilityModel? availability,
    int? selectedPitchIndex,
    int? selectedDayIndex,
    SlotModel? selectedSlot,
    bool clearSelectedSlot = false,
    BookingQuoteResponseModel? quote,
    bool clearQuote = false,
    bool? isQuoting,
    String? quoteError,
    bool clearQuoteError = false,
    bool? isBooking,
    CreateBookingResponseModel? createdBooking,
    String? bookingError,
    bool clearBookingError = false,
    bool? isSlotsLoading,
    PitchSlotFilter? slotFilter,
    bool? selectedSlotTaken,
  }) {
    return PitchBookingLoaded(
      availability: availability ?? this.availability,
      selectedPitchIndex: selectedPitchIndex ?? this.selectedPitchIndex,
      selectedDayIndex: selectedDayIndex ?? this.selectedDayIndex,
      selectedSlot: clearSelectedSlot
          ? null
          : (selectedSlot ?? this.selectedSlot),
      quote: clearQuote ? null : (quote ?? this.quote),
      isQuoting: isQuoting ?? this.isQuoting,
      quoteError: clearQuoteError ? null : (quoteError ?? this.quoteError),
      isBooking: isBooking ?? this.isBooking,
      createdBooking: createdBooking ?? this.createdBooking,
      bookingError: clearBookingError
          ? null
          : (bookingError ?? this.bookingError),
      isSlotsLoading: isSlotsLoading ?? this.isSlotsLoading,
      slotFilter: slotFilter ?? this.slotFilter,
      // A different slot starts with no warning.
      selectedSlotTaken:
          selectedSlotTaken ??
          (clearSelectedSlot || selectedSlot != null
              ? false
              : this.selectedSlotTaken),
    );
  }
}

class PitchBookingError extends PitchBookingState {
  const PitchBookingError(this.message);
  final String message;
}
