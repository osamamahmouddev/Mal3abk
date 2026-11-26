import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/calendar_slot_model.dart';
import '../../data/models/manual_booking_request_body.dart';
import '../../data/models/venue_customer_model.dart';
import '../../domain/repos/venue_calendar_repo.dart';
import 'manual_booking_state.dart';
import 'venue_calendar_cubit.dart';

/// A phone or walk-in booking, with the same rules as the web form: price
/// suggested from the venue's rules, overlap check, and the deposit rules
/// of each payment state.
class ManualBookingCubit extends Cubit<ManualBookingState>
    with SafeEmitCubitMixin<ManualBookingState> {
  ManualBookingCubit({
    required this.venueCalendarRepo,
    required String venueId,
    required String pitchId,
    required DateTime date,
    int startMinutes = 20 * 60,
  }) : _venueId = venueId,
       super(
         ManualBookingState(
           pitchId: pitchId,
           date: date,
           startMinutes: startMinutes,
         ),
       );

  final VenueCalendarRepo venueCalendarRepo;
  final String _venueId;
  Timer? _customerDebounce;
  int _slotGeneration = 0;

  static final RegExp _egyptianMobile = RegExp(r'^(\+?20|0)?1[0125]\d{8}$');

  DateTime get startUtc => VenueCalendarCubit.dayStartUtc(
    state.date,
  ).add(Duration(minutes: state.startMinutes));

  DateTime get endUtc => startUtc.add(Duration(minutes: state.durationMinutes));

  bool get isPast => !startUtc.isAfter(DateTime.now().toUtc());

  /// A booked or blocked slot the chosen time overlaps, if any.
  CalendarSlotModel? get conflict => state.daySlots
      .where((s) => s.pitchId == state.pitchId && s.overlaps(startUtc, endUtc))
      .firstOrNull;

  Future<void> init() => _slotChanged(reloadDay: true);

  void setPitch(String id) {
    emitIfOpen(state.copyWith(pitchId: id, errors: const {}));
    _slotChanged(reloadDay: true);
  }

  void setDate(DateTime date) {
    emitIfOpen(state.copyWith(date: date));
    _slotChanged(reloadDay: true);
  }

  void setStart(int minutes) {
    emitIfOpen(state.copyWith(startMinutes: minutes, errors: const {}));
    _slotChanged();
  }

  void setDuration(int minutes) {
    emitIfOpen(state.copyWith(durationMinutes: minutes));
    _slotChanged();
  }

  void setPayment(ManualPaymentStatus payment) =>
      emitIfOpen(state.copyWith(payment: payment, errors: const {}));

  void selectCustomer(VenueCustomerModel? customer) =>
      emitIfOpen(state.copyWith(selectedCustomer: customer));

  void searchCustomers(String text) {
    _customerDebounce?.cancel();
    _customerDebounce = Timer(const Duration(milliseconds: 250), () async {
      emitIfOpen(state.copyWith(customersLoading: true));
      final result = await venueCalendarRepo.searchCustomers(_venueId, text);
      emitIfOpen(
        state.copyWith(
          customersLoading: false,
          customers: result.when(success: (c) => c, failure: (_) => const []),
        ),
      );
    });
  }

  Future<void> _slotChanged({bool reloadDay = false}) async {
    final generation = ++_slotGeneration;
    final pitchId = state.pitchId;
    if (pitchId.isEmpty) return;
    final dayStart = VenueCalendarCubit.dayStartUtc(state.date);
    final calendar = reloadDay
        ? venueCalendarRepo.getCalendar(
            _venueId,
            fromUtc: dayStart,
            toUtc: VenueCalendarCubit.dayStartUtc(
              DateTime(state.date.year, state.date.month, state.date.day + 2),
            ),
            pitchId: pitchId,
          )
        : null;
    final price = venueCalendarRepo.previewPrice(
      _venueId,
      pitchId: pitchId,
      startUtc: startUtc,
      endUtc: endUtc,
    );
    final slots = await calendar;
    final suggested = await price;
    if (generation != _slotGeneration) return;
    emitIfOpen(
      state.copyWith(
        suggestedPrice: suggested,
        daySlots:
            slots?.when(success: (s) => s, failure: (_) => state.daySlots) ??
            state.daySlots,
      ),
    );
  }

  Future<void> submit({
    required String customerName,
    required String customerPhone,
    required String price,
    required String deposit,
    required String notes,
  }) async {
    if (state.submitting) return;
    final errors = <String, String>{};
    final clash = conflict;
    if (clash != null) {
      errors['time'] = clash.isBlocked
          ? 'venue.manual.errors.slot_blocked'
          : 'venue.manual.errors.slot_taken';
    }
    if (state.pitchId.isEmpty) errors['pitch'] = 'venue.manual.errors.pitch';
    final name = customerName.trim();
    final phone = customerPhone.trim().replaceAll(' ', '');
    if (name.length > 100) errors['name'] = 'venue.manual.errors.name_long';
    if (phone.isNotEmpty && !_egyptianMobile.hasMatch(phone)) {
      errors['phone'] = 'venue.manual.errors.phone';
    }
    final amount = double.tryParse(price.trim());
    if (amount == null) {
      errors['price'] = 'venue.manual.errors.price_missing';
    } else if (amount <= 0 || amount > 100000) {
      errors['price'] = 'venue.manual.errors.price_positive';
    }
    if (notes.length > 500) errors['notes'] = 'venue.manual.errors.notes_long';
    if (isPast && state.payment == ManualPaymentStatus.unconfirmed) {
      errors['payment'] = 'venue.manual.errors.past_unconfirmed';
    }
    final depositError = _depositError(state.payment, amount, deposit);
    if (depositError != null) errors['deposit'] = depositError;
    if (errors.isNotEmpty) {
      emitIfOpen(state.copyWith(errors: errors, serverError: null));
      return;
    }

    emitIfOpen(
      state.copyWith(errors: const {}, serverError: null, submitting: true),
    );
    final needsDeposit =
        state.payment == ManualPaymentStatus.deposit ||
        state.payment == ManualPaymentStatus.awaiting;
    final result = await venueCalendarRepo.createManualBooking(
      _venueId,
      ManualBookingRequestBody(
        pitchId: state.pitchId,
        startUtc: startUtc.toIso8601String(),
        endUtc: endUtc.toIso8601String(),
        price: amount!,
        paymentStatus: state.payment.value,
        customerName: name.isEmpty ? null : name,
        customerPhone: phone.isEmpty ? null : phone,
        notes: notes.trim().isEmpty ? null : notes.trim(),
        depositAmount: needsDeposit ? double.parse(deposit.trim()) : null,
      ),
    );
    result.when(
      success: (_) => emitIfOpen(state.copyWith(submitting: false, done: true)),
      failure: (f) =>
          emitIfOpen(state.copyWith(submitting: false, serverError: f.message)),
    );
  }

  /// More than zero, and below the price when it was already paid.
  static String? _depositError(
    ManualPaymentStatus payment,
    double? price,
    String deposit,
  ) {
    if (payment == ManualPaymentStatus.full ||
        payment == ManualPaymentStatus.unconfirmed) {
      return null;
    }
    final amount = double.tryParse(deposit.trim());
    if (amount == null || amount <= 0) {
      return payment == ManualPaymentStatus.deposit
          ? 'venue.manual.errors.deposit_paid_missing'
          : 'venue.manual.errors.deposit_required_missing';
    }
    if (price != null &&
        payment == ManualPaymentStatus.deposit &&
        amount >= price) {
      return 'venue.manual.errors.deposit_not_less';
    }
    if (price != null && amount > price) {
      return 'venue.manual.errors.deposit_over_price';
    }
    return null;
  }

  @override
  Future<void> close() {
    _customerDebounce?.cancel();
    return super.close();
  }
}

/// 12-hour clock with the Egyptian "late night" session: hours after 12 at
/// night belong to that night's business day (ported from the web).
abstract final class BusinessClock {
  static int toMinutes(int hour12, int minute, {required bool night}) {
    final int hour;
    if (night) {
      hour = hour12 == 12
          ? 24
          : hour12 <= 6
          ? 24 + hour12
          : 12 + hour12;
    } else {
      hour = hour12 == 12
          ? 12
          : hour12 <= 6
          ? 12 + hour12
          : hour12;
    }
    return hour * 60 + minute;
  }

  static ({int hour12, int minute, bool night}) fromMinutes(int total) {
    final hour = total ~/ 60;
    final minute = total % 60;
    if (hour >= 24) {
      final h = hour - 24;
      return (hour12: h == 0 ? 12 : h, minute: minute, night: true);
    }
    if (hour >= 19) return (hour12: hour - 12, minute: minute, night: true);
    if (hour >= 12) {
      return (
        hour12: hour == 12 ? 12 : hour - 12,
        minute: minute,
        night: false,
      );
    }
    if (hour >= 7) return (hour12: hour, minute: minute, night: false);
    return (hour12: hour == 0 ? 12 : hour, minute: minute, night: true);
  }
}
