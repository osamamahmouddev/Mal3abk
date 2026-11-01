import '../../data/models/venue_availability_model.dart';
import '../../data/models/venue_payment_method_model.dart';
import '../../../booking/data/models/booking_quote_response_model.dart';
import '../../../booking/data/models/create_booking_response_model.dart';

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
    this.paymentMethods = const [],
    this.bookingError,
  });

  final VenueAvailabilityModel availability;
  final int selectedPitchIndex;
  final int selectedDayIndex;
  final SlotModel? selectedSlot;
  final BookingQuoteResponseModel? quote;
  final bool isQuoting;
  final String? quoteError;
  final bool isBooking;
  final CreateBookingResponseModel? createdBooking;
  final List<VenuePaymentMethodModel> paymentMethods;
  final String? bookingError;

  PitchSlotsModel? get currentPitch {
    if (availability.pitches.isEmpty) return null;
    if (selectedPitchIndex < availability.pitches.length) {
      return availability.pitches[selectedPitchIndex];
    }
    return availability.pitches.first;
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
    List<VenuePaymentMethodModel>? paymentMethods,
    String? bookingError,
    bool clearBookingError = false,
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
      paymentMethods: paymentMethods ?? this.paymentMethods,
      bookingError: clearBookingError
          ? null
          : (bookingError ?? this.bookingError),
    );
  }
}

class PitchBookingError extends PitchBookingState {
  const PitchBookingError(this.message);
  final String message;
}
