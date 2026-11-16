import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/booking/data/models/booking_quote_request_body.dart';
import 'package:mal3abk/features/booking/data/models/booking_quote_response_model.dart';
import 'package:mal3abk/features/booking/data/models/booking_status.dart';
import 'package:mal3abk/features/booking/data/models/create_booking_request_body.dart';
import 'package:mal3abk/features/booking/data/models/create_booking_response_model.dart';
import 'package:mal3abk/features/booking/data/models/player_booking_detail_model.dart';
import 'package:mal3abk/features/booking/data/models/player_booking_summary_model.dart';
import 'package:mal3abk/features/booking/domain/repos/booking_repo.dart';
import 'package:mal3abk/features/booking/domain/use_cases/create_booking_use_case.dart';
import 'package:mal3abk/features/booking/domain/use_cases/get_booking_detail_use_case.dart';
import 'package:mal3abk/features/booking/domain/use_cases/get_booking_quote_use_case.dart';
import 'package:mal3abk/features/booking/domain/use_cases/get_my_bookings_use_case.dart';

class MockBookingRepo extends Mock implements BookingRepo {}

void main() {
  late MockBookingRepo mockRepo;
  late GetBookingQuoteUseCase quoteUseCase;
  late CreateBookingUseCase createUseCase;
  late GetBookingDetailUseCase detailUseCase;
  late GetMyBookingsUseCase myBookingsUseCase;

  setUpAll(() {
    registerFallbackValue(const BookingQuoteRequestBody(pitchId: '1', startUtc: '', endUtc: ''));
    registerFallbackValue(const CreateBookingRequestBody(pitchId: '1', startUtc: '', endUtc: '', quoteToken: '', expectedPrice: 0));
  });

  setUp(() {
    mockRepo = MockBookingRepo();
    quoteUseCase = GetBookingQuoteUseCase(bookingRepo: mockRepo);
    createUseCase = CreateBookingUseCase(bookingRepo: mockRepo);
    detailUseCase = GetBookingDetailUseCase(bookingRepo: mockRepo);
    myBookingsUseCase = GetMyBookingsUseCase(bookingRepo: mockRepo);
  });

  group('GetBookingQuoteUseCase Tests', () {
    const body = BookingQuoteRequestBody(pitchId: 'p-1', startUtc: '2026-12-01T18:00:00Z', endUtc: '2026-12-01T19:00:00Z');
    const quote = BookingQuoteResponseModel(
      quoteToken: 'tok',
      expiresAtUtc: '2026-12-01T18:15:00Z',
      currency: 'EGP',
      subtotal: 100,
      discount: 0,
      fees: 0,
      total: 100,
      deposit: 25,
      remainingBalance: 75,
      subjectToConfirmation: false,
      confirmationNote: '',
    );

    test('66. delegates quote request to repo on success', () async {
      when(() => mockRepo.getQuote(body)).thenAnswer((_) async => const ApiResult.success(quote));
      final res = await quoteUseCase(body);
      expect(res, isA<Success<BookingQuoteResponseModel>>());
    });

    test('67. forwards error failure on quote error', () async {
      when(() => mockRepo.getQuote(body)).thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'error')));
      final res = await quoteUseCase(body);
      expect(res, isA<ApiFailure>());
    });
  });

  group('CreateBookingUseCase Tests', () {
    const body = CreateBookingRequestBody(pitchId: 'p-1', startUtc: '2026-12-01T18:00:00Z', endUtc: '2026-12-01T19:00:00Z', quoteToken: 'tok', expectedPrice: 100);
    const bookingRes = CreateBookingResponseModel(
      bookingId: 'b-1',
      bookingReference: 'REF',
      venueId: 'v-1',
      pitchId: 'p-1',
      startUtc: '2026-12-01T18:00:00Z',
      endUtc: '2026-12-01T19:00:00Z',
      totalPrice: 100,
      depositAmount: 25,
      currency: 'EGP',
      status: BookingStatus.pendingDeposit,
      holdExpiresAtUtc: '2026-12-01T18:15:00Z',
    );

    test('68. calls createBooking with correct parameters', () async {
      when(() => mockRepo.createBooking(body: body, idempotencyKey: 'key-1')).thenAnswer((_) async => const ApiResult.success(bookingRes));
      final res = await createUseCase(body: body, idempotencyKey: 'key-1');
      expect(res, isA<Success<CreateBookingResponseModel>>());
      verify(() => mockRepo.createBooking(body: body, idempotencyKey: 'key-1')).called(1);
    });

    test('69. handles createBooking conflict error', () async {
      when(() => mockRepo.createBooking(body: body, idempotencyKey: 'key-1')).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.booking.conflict')),
      );
      final res = await createUseCase(body: body, idempotencyKey: 'key-1');
      expect(res, isA<ApiFailure>());
    });
  });

  group('GetBookingDetailUseCase Tests', () {
    const detail = PlayerBookingDetailModel(
      id: 'b-10',
      reference: 'REF-10',
      venueId: 'v-1',
      pitchId: 'p-1',
      startUtc: '2026-12-01T18:00:00Z',
      endUtc: '2026-12-01T19:00:00Z',
      totalPrice: 150,
      depositAmount: 50,
      currency: 'EGP',
      status: BookingStatus.confirmed,
      allowedActions: PlayerAllowedActionsModel(),
      createdAtUtc: '2026-12-01T10:00:00Z',
    );

    test('70. returns booking detail when id matches', () async {
      when(() => mockRepo.getBookingDetail('b-10')).thenAnswer((_) async => const ApiResult.success(detail));
      final res = await detailUseCase('b-10');
      expect(res, isA<Success<PlayerBookingDetailModel>>());
    });

    test('71. returns failure when booking does not exist', () async {
      when(() => mockRepo.getBookingDetail('b-unknown')).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.not_found')),
      );
      final res = await detailUseCase('b-unknown');
      expect(res, isA<ApiFailure>());
    });
  });

  group('GetMyBookingsUseCase Tests', () {
    const paged = PlayerBookingsPagedListModel(items: [], totalCount: 0, page: 1, pageSize: 10);

    test('72. gets default page when arguments are omitted', () async {
      when(() => mockRepo.getMyBookings(tab: null, page: null, pageSize: null)).thenAnswer((_) async => const ApiResult.success(paged));
      final res = await myBookingsUseCase();
      expect(res, isA<Success<PlayerBookingsPagedListModel>>());
    });

    test('73. passes tab and page pagination parameters', () async {
      when(() => mockRepo.getMyBookings(tab: 'history', page: 2, pageSize: 20)).thenAnswer((_) async => const ApiResult.success(paged));
      final res = await myBookingsUseCase(tab: 'history', page: 2, pageSize: 20);
      expect(res, isA<Success<PlayerBookingsPagedListModel>>());
      verify(() => mockRepo.getMyBookings(tab: 'history', page: 2, pageSize: 20)).called(1);
    });

    test('74. returns failure when session expired', () async {
      when(() => mockRepo.getMyBookings(tab: any(named: 'tab'), page: any(named: 'page'), pageSize: any(named: 'pageSize')))
          .thenAnswer((_) async => const ApiResult.failure(AppApiFailure(message: 'errors.unauthorized')));
      final res = await myBookingsUseCase(tab: 'upcoming');
      expect(res, isA<ApiFailure>());
    });
  });
}
