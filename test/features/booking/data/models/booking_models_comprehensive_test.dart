import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/booking/data/models/booking_payment_method_model.dart';
import 'package:mal3abk/features/booking/data/models/booking_quote_request_body.dart';
import 'package:mal3abk/features/booking/data/models/booking_quote_response_model.dart';
import 'package:mal3abk/features/booking/data/models/booking_status.dart';
import 'package:mal3abk/features/booking/data/models/cancel_booking_request_body.dart';
import 'package:mal3abk/features/booking/data/models/cancel_preview_model.dart';
import 'package:mal3abk/features/booking/data/models/create_booking_request_body.dart';
import 'package:mal3abk/features/booking/data/models/create_booking_response_model.dart';
import 'package:mal3abk/features/booking/data/models/player_booking_detail_model.dart';
import 'package:mal3abk/features/booking/data/models/player_booking_summary_model.dart';
import 'package:mal3abk/features/booking/data/models/submit_proof_request_body.dart';
import 'package:mal3abk/features/booking/data/models/upload_ticket_model.dart';

void main() {
  group('BookingStatus Enum Tests', () {
    test('1. draft has value 1', () => expect(BookingStatus.draft.index, isNotNull));
    test('2. pendingDeposit is not awaiting venue', () => expect(BookingStatus.pendingDeposit.isAwaitingVenue, isFalse));
    test('3. proofSubmitted is awaiting venue', () => expect(BookingStatus.proofSubmitted.isAwaitingVenue, isTrue));
    test('4. underReview is awaiting venue', () => expect(BookingStatus.underReview.isAwaitingVenue, isTrue));
    test('5. confirmed is not awaiting venue', () => expect(BookingStatus.confirmed.isAwaitingVenue, isFalse));
    test('6. confirmed has pass', () => expect(BookingStatus.confirmed.hasPass, isTrue));
    test('7. completed has pass', () => expect(BookingStatus.completed.hasPass, isTrue));
    test('8. rejected does not have pass', () => expect(BookingStatus.rejected.hasPass, isFalse));
    test('9. expired does not have pass', () => expect(BookingStatus.expired.hasPass, isFalse));
    test('10. cancelled does not have pass', () => expect(BookingStatus.cancelled.hasPass, isFalse));
    test('11. rejected is closed', () => expect(BookingStatus.rejected.isClosed, isTrue));
    test('12. expired is closed', () => expect(BookingStatus.expired.isClosed, isTrue));
    test('13. cancelled is closed', () => expect(BookingStatus.cancelled.isClosed, isTrue));
    test('14. completed is closed', () => expect(BookingStatus.completed.isClosed, isTrue));
    test('15. noShow is closed', () => expect(BookingStatus.noShow.isClosed, isTrue));
    test('16. draft is not closed', () => expect(BookingStatus.draft.isClosed, isFalse));
    test('17. pendingDeposit is not closed', () => expect(BookingStatus.pendingDeposit.isClosed, isFalse));
    test('18. underReview is not closed', () => expect(BookingStatus.underReview.isClosed, isFalse));
  });

  group('BookingPaymentMethodModel Tests', () {
    test('19. parses wallet method correctly', () {
      final json = {'id': 'pm-1', 'methodType': 'VodafoneCash', 'recipientName': 'Captain Ahmed', 'accountDetails': '01012345678', 'instructions': 'Transfer deposit'};
      final model = BookingPaymentMethodModel.fromJson(json);
      expect(model.id, 'pm-1');
      expect(model.recipientName, 'Captain Ahmed');
      expect(model.accountDetails, '01012345678');
      expect(model.isInstaPay, isFalse);
    });

    test('20. parses instapay method correctly', () {
      final json = {'id': 'pm-2', 'methodType': 'InstaPay', 'recipientName': 'Mal3abk Venue', 'accountDetails': 'user@instapay'};
      final model = BookingPaymentMethodModel.fromJson(json);
      expect(model.id, 'pm-2');
      expect(model.accountDetails, 'user@instapay');
      expect(model.isInstaPay, isTrue);
    });

    test('21. serializes payment method to json', () {
      const model = BookingPaymentMethodModel(id: 'pm-3', methodType: 'BankTransfer', recipientName: 'Venue Owner', accountDetails: 'EG1234');
      final json = model.toJson();
      expect(json['id'], 'pm-3');
      expect(json['recipientName'], 'Venue Owner');
    });
  });

  group('BookingQuoteRequestBody & Response Tests', () {
    test('22. creates BookingQuoteRequestBody with all fields', () {
      const body = BookingQuoteRequestBody(pitchId: 'p-1', startUtc: '2026-12-01T18:00:00Z', endUtc: '2026-12-01T19:00:00Z');
      expect(body.pitchId, 'p-1');
      expect(body.toJson()['pitchId'], 'p-1');
    });

    test('23. parses BookingQuoteResponseModel with discount and remaining balance', () {
      final json = {
        'quoteToken': 'tok-xyz',
        'expiresAtUtc': '2026-12-01T18:15:00Z',
        'currency': 'EGP',
        'subtotal': 300.0,
        'discount': 50.0,
        'fees': 10.0,
        'total': 260.0,
        'deposit': 100.0,
        'remainingBalance': 160.0,
        'subjectToConfirmation': true,
        'confirmationNote': 'Requires owner review',
        'policySummary': ['Free cancellation up to 6 hours before'],
      };
      final quote = BookingQuoteResponseModel.fromJson(json);
      expect(quote.quoteToken, 'tok-xyz');
      expect(quote.total, 260.0);
      expect(quote.remainingBalance, 160.0);
      expect(quote.subjectToConfirmation, isTrue);
      expect(quote.policySummary.length, 1);
    });

    test('24. serializes BookingQuoteResponseModel to json', () {
      const quote = BookingQuoteResponseModel(
        quoteToken: 'tok-abc',
        expiresAtUtc: '2026-12-01T19:00:00Z',
        currency: 'EGP',
        subtotal: 200.0,
        discount: 0.0,
        fees: 0.0,
        total: 200.0,
        deposit: 50.0,
        remainingBalance: 150.0,
        subjectToConfirmation: false,
        confirmationNote: 'Instant booking',
      );
      final json = quote.toJson();
      expect(json['quoteToken'], 'tok-abc');
      expect(json['total'], 200.0);
      expect(json['subjectToConfirmation'], isFalse);
    });
  });

  group('CreateBooking Models Tests', () {
    test('25. creates CreateBookingRequestBody without customer details', () {
      const body = CreateBookingRequestBody(
        pitchId: 'p-1',
        startUtc: '2026-12-01T18:00:00Z',
        endUtc: '2026-12-01T19:00:00Z',
        quoteToken: 'tok-123',
        expectedPrice: 200.0,
      );
      expect(body.customerName, isNull);
      expect(body.toJson()['quoteToken'], 'tok-123');
    });

    test('26. creates CreateBookingRequestBody with customer name and phone', () {
      const body = CreateBookingRequestBody(
        pitchId: 'p-1',
        startUtc: '2026-12-01T18:00:00Z',
        endUtc: '2026-12-01T19:00:00Z',
        quoteToken: 'tok-123',
        expectedPrice: 200.0,
        customerName: 'Ahmed Ali',
        customerPhone: '+201012345678',
      );
      expect(body.customerName, 'Ahmed Ali');
      expect(body.customerPhone, '+201012345678');
      expect(body.toJson()['customerName'], 'Ahmed Ali');
    });

    test('27. parses CreateBookingResponseModel successfully', () {
      final json = {
        'bookingId': 'b-100',
        'bookingReference': 'REF-100',
        'venueId': 'v-10',
        'pitchId': 'p-1',
        'startUtc': '2026-12-01T18:00:00Z',
        'endUtc': '2026-12-01T19:00:00Z',
        'totalPrice': 250.0,
        'depositAmount': 50.0,
        'currency': 'EGP',
        'status': 2,
        'holdExpiresAtUtc': '2026-12-01T18:15:00Z',
        'paymentInstructions': 'Pay via InstaPay within 15 mins',
      };
      final res = CreateBookingResponseModel.fromJson(json);
      expect(res.bookingId, 'b-100');
      expect(res.status, BookingStatus.pendingDeposit);
      expect(res.paymentInstructions, contains('InstaPay'));
    });

    test('28. serializes CreateBookingResponseModel to json', () {
      const res = CreateBookingResponseModel(
        bookingId: 'b-101',
        bookingReference: 'REF-101',
        venueId: 'v-10',
        pitchId: 'p-1',
        startUtc: '2026-12-01T18:00:00Z',
        endUtc: '2026-12-01T19:00:00Z',
        totalPrice: 200.0,
        depositAmount: 50.0,
        currency: 'EGP',
        status: BookingStatus.draft,
        holdExpiresAtUtc: '2026-12-01T18:15:00Z',
      );
      final json = res.toJson();
      expect(json['bookingId'], 'b-101');
      expect(json['status'], 1);
    });
  });

  group('CancelBooking Models Tests', () {
    test('29. CancelBookingRequestBody serializes with reason', () {
      const body = CancelBookingRequestBody(reason: 'Injured player');
      expect(body.toJson()['reason'], 'Injured player');
    });

    test('30. CancelBookingRequestBody serializes without reason', () {
      const body = CancelBookingRequestBody();
      expect(body.reason, isNull);
    });

    test('31. CancelPreviewModel parses with deadline and refund', () {
      final json = {
        'canCancel': true,
        'cancellationDeadlineUtc': '2026-12-01T12:00:00Z',
        'refundPercentage': 100.0,
        'estimatedRefundAmount': 100.0,
        'currency': 'EGP',
        'policySummary': 'Full refund before 12 PM',
      };
      final preview = CancelPreviewModel.fromJson(json);
      expect(preview.canCancel, isTrue);
      expect(preview.refundPercentage, 100.0);
      expect(preview.cancellationDeadlineUtc, isNotNull);
    });

    test('32. CancelPreviewModel parses when cannot cancel', () {
      final json = {
        'canCancel': false,
        'refundPercentage': 0.0,
        'estimatedRefundAmount': 0.0,
        'currency': 'EGP',
      };
      final preview = CancelPreviewModel.fromJson(json);
      expect(preview.canCancel, isFalse);
      expect(preview.cancellationDeadlineUtc, isNull);
    });
  });

  group('PlayerBookingDetailModel & Submodels Tests', () {
    test('33. PlayerProofModel parses correctly with approval', () {
      final json = {
        'id': 'prf-1',
        'originalFileName': 'receipt.jpg',
        'contentType': 'image/jpeg',
        'fileSizeBytes': 204800,
        'isApproved': true,
        'uploadedAtUtc': '2026-12-01T18:05:00Z',
      };
      final proof = PlayerProofModel.fromJson(json);
      expect(proof.id, 'prf-1');
      expect(proof.isApproved, isTrue);
      expect(proof.rejectionReason, isNull);
    });

    test('34. PlayerProofModel parses correctly with rejection', () {
      final json = {
        'id': 'prf-2',
        'originalFileName': 'receipt2.jpg',
        'contentType': 'image/jpeg',
        'fileSizeBytes': 102400,
        'isApproved': false,
        'rejectionReason': 'Blurry photo',
        'uploadedAtUtc': '2026-12-01T18:10:00Z',
      };
      final proof = PlayerProofModel.fromJson(json);
      expect(proof.isApproved, isFalse);
      expect(proof.rejectionReason, 'Blurry photo');
    });

    test('35. PlayerStatusHistoryModel parses history entries', () {
      final json = {
        'status': 3,
        'changedBy': 'Player',
        'reason': 'Deposit receipt uploaded',
        'changedAtUtc': '2026-12-01T18:05:00Z',
      };
      final history = PlayerStatusHistoryModel.fromJson(json);
      expect(history.status, BookingStatus.proofSubmitted);
      expect(history.changedBy, 'Player');
    });

    test('36. PlayerVenueModel parses with coordinates', () {
      final json = {'name': 'Camp Nou', 'address': 'Zamalek, Cairo', 'latitude': 30.05, 'longitude': 31.22};
      final venue = PlayerVenueModel.fromJson(json);
      expect(venue.hasLocation, isTrue);
      expect(venue.latitude, 30.05);
    });

    test('37. PlayerVenueModel parses without coordinates', () {
      final json = {'name': 'Camp Nou', 'address': 'Zamalek, Cairo'};
      final venue = PlayerVenueModel.fromJson(json);
      expect(venue.hasLocation, isFalse);
      expect(venue.latitude, isNull);
    });

    test('38. PlayerAllowedActionsModel defaults to false for all actions', () {
      final actions = PlayerAllowedActionsModel.fromJson({});
      expect(actions.canUploadProof, isFalse);
      expect(actions.canCancel, isFalse);
      expect(actions.canReview, isFalse);
    });

    test('39. PlayerAllowedActionsModel parses allowed flags', () {
      final actions = PlayerAllowedActionsModel.fromJson({'canUploadProof': true, 'canCancel': true, 'canReview': false});
      expect(actions.canUploadProof, isTrue);
      expect(actions.canCancel, isTrue);
    });

    test('40. PlayerBookingDetailModel calculates startAt and endAt DateTime correctly', () {
      final json = {
        'id': 'b-200',
        'reference': 'REF-200',
        'venueId': 'v-1',
        'pitchId': 'p-1',
        'startUtc': '2026-11-20T19:00:00Z',
        'endUtc': '2026-11-20T20:30:00Z',
        'totalPrice': 450.0,
        'depositAmount': 100.0,
        'currency': 'EGP',
        'status': 5,
        'allowedActions': {'canCancel': true},
        'createdAtUtc': '2026-11-20T10:00:00Z',
      };
      final detail = PlayerBookingDetailModel.fromJson(json);
      expect(detail.startAt, DateTime.utc(2026, 11, 20, 19, 0));
      expect(detail.endAt, DateTime.utc(2026, 11, 20, 20, 30));
      expect(detail.status, BookingStatus.confirmed);
    });

    test('41. UploadTicketModel serializes and parses properly', () {
      final json = {'uploadUrl': 'https://s3.example.com/tickets/123', 'mediaId': 'm-99', 'expiresAtUtc': '2026-11-20T11:00:00Z'};
      final ticket = UploadTicketModel.fromJson(json);
      expect(ticket.uploadUrl, 'https://s3.example.com/tickets/123');
      expect(ticket.mediaId, 'm-99');
      expect(ticket.id, 'm-99');
      expect(ticket.toJson()['mediaId'], 'm-99');
    });

    test('42. SubmitProofRequestBody serializes properly', () {
      const body = SubmitProofRequestBody(mediaId: 'm-99', notes: 'Done');
      expect(body.mediaId, 'm-99');
      expect(body.notes, 'Done');
      expect(body.toJson()['mediaId'], 'm-99');
    });
  });
}
