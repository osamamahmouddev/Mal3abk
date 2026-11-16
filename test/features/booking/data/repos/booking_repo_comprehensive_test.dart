import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/booking/data/apis/booking_api_service.dart';
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
import 'package:mal3abk/features/booking/data/repos/booking_repo_impl.dart';

class MockBookingApiService extends Mock implements BookingApiService {}
class MockDio extends Mock implements Dio {}

void main() {
  late MockBookingApiService mockApi;
  late MockDio mockDio;
  late BookingRepoImpl repo;

  setUpAll(() {
    registerFallbackValue(const BookingQuoteRequestBody(pitchId: '1', startUtc: '', endUtc: ''));
    registerFallbackValue(const CreateBookingRequestBody(pitchId: '1', startUtc: '', endUtc: '', quoteToken: '', expectedPrice: 0));
    registerFallbackValue(const CancelBookingRequestBody());
    registerFallbackValue(const SubmitProofRequestBody(mediaId: '1'));
    registerFallbackValue(Options());
  });

  setUp(() {
    mockApi = MockBookingApiService();
    mockDio = MockDio();
    repo = BookingRepoImpl(bookingApiService: mockApi, dio: mockDio);
  });

  group('BookingRepoImpl Quote Tests', () {
    const quoteReq = BookingQuoteRequestBody(pitchId: 'p-1', startUtc: '2026-12-01T18:00:00Z', endUtc: '2026-12-01T19:00:00Z');
    const quoteRes = BookingQuoteResponseModel(
      quoteToken: 'tok-1',
      expiresAtUtc: '2026-12-01T18:15:00Z',
      currency: 'EGP',
      subtotal: 200,
      discount: 0,
      fees: 0,
      total: 200,
      deposit: 50,
      remainingBalance: 150,
      subjectToConfirmation: false,
      confirmationNote: 'ok',
    );

    test('43. getQuote returns success', () async {
      when(() => mockApi.getQuote(quoteReq)).thenAnswer((_) async => quoteRes);
      final result = await repo.getQuote(quoteReq);
      expect(result, isA<Success<BookingQuoteResponseModel>>());
    });

    test('44. getQuote returns failure on 400 Bad Request', () async {
      when(() => mockApi.getQuote(quoteReq)).thenThrow(
        DioException(requestOptions: RequestOptions(path: ''), response: Response(requestOptions: RequestOptions(path: ''), statusCode: 400)),
      );
      final result = await repo.getQuote(quoteReq);
      expect(result, isA<ApiFailure>());
    });

    test('45. getQuote returns failure on 404 Not Found', () async {
      when(() => mockApi.getQuote(quoteReq)).thenThrow(
        DioException(requestOptions: RequestOptions(path: ''), response: Response(requestOptions: RequestOptions(path: ''), statusCode: 404)),
      );
      final result = await repo.getQuote(quoteReq);
      expect(result, isA<ApiFailure>());
    });

    test('46. getQuote returns failure on 500 Server Error', () async {
      when(() => mockApi.getQuote(quoteReq)).thenThrow(
        DioException(requestOptions: RequestOptions(path: ''), response: Response(requestOptions: RequestOptions(path: ''), statusCode: 500)),
      );
      final result = await repo.getQuote(quoteReq);
      expect(result, isA<ApiFailure>());
    });

    test('47. getQuote returns failure on timeout', () async {
      when(() => mockApi.getQuote(quoteReq)).thenThrow(
        DioException(requestOptions: RequestOptions(path: ''), type: DioExceptionType.connectionTimeout),
      );
      final result = await repo.getQuote(quoteReq);
      expect(result, isA<ApiFailure>());
    });
  });

  group('BookingRepoImpl Create Booking Tests', () {
    const createReq = CreateBookingRequestBody(pitchId: 'p-1', startUtc: '2026-12-01T18:00:00Z', endUtc: '2026-12-01T19:00:00Z', quoteToken: 'tok-1', expectedPrice: 200);
    const createRes = CreateBookingResponseModel(
      bookingId: 'b-1',
      bookingReference: 'REF-1',
      venueId: 'v-1',
      pitchId: 'p-1',
      startUtc: '2026-12-01T18:00:00Z',
      endUtc: '2026-12-01T19:00:00Z',
      totalPrice: 200,
      depositAmount: 50,
      currency: 'EGP',
      status: BookingStatus.pendingDeposit,
      holdExpiresAtUtc: '2026-12-01T18:15:00Z',
    );

    test('48. createBooking returns success', () async {
      when(() => mockApi.createBooking(createReq, 'idem-1')).thenAnswer((_) async => createRes);
      final result = await repo.createBooking(body: createReq, idempotencyKey: 'idem-1');
      expect(result, isA<Success<CreateBookingResponseModel>>());
    });

    test('49. createBooking returns failure on 409 slot conflict', () async {
      when(() => mockApi.createBooking(createReq, 'idem-1')).thenThrow(
        DioException(requestOptions: RequestOptions(path: ''), response: Response(requestOptions: RequestOptions(path: ''), statusCode: 409)),
      );
      final result = await repo.createBooking(body: createReq, idempotencyKey: 'idem-1');
      expect(result, isA<ApiFailure>());
    });

    test('50. createBooking returns failure on 401 unauthorized', () async {
      when(() => mockApi.createBooking(createReq, 'idem-1')).thenThrow(
        DioException(requestOptions: RequestOptions(path: ''), response: Response(requestOptions: RequestOptions(path: ''), statusCode: 401)),
      );
      final result = await repo.createBooking(body: createReq, idempotencyKey: 'idem-1');
      expect(result, isA<ApiFailure>());
    });
  });

  group('BookingRepoImpl Get My Bookings Tests', () {
    const pagedList = PlayerBookingsPagedListModel(items: [], totalCount: 0, page: 1, pageSize: 20);

    test('51. getMyBookings returns success with items', () async {
      when(() => mockApi.getMyBookings(tab: 'upcoming', page: 1, pageSize: 20)).thenAnswer((_) async => pagedList);
      final result = await repo.getMyBookings(tab: 'upcoming', page: 1, pageSize: 20);
      expect(result, isA<Success<PlayerBookingsPagedListModel>>());
    });

    test('52. getMyBookings returns failure on network error', () async {
      when(() => mockApi.getMyBookings(tab: 'upcoming', page: 1, pageSize: 20)).thenThrow(
        DioException(requestOptions: RequestOptions(path: ''), type: DioExceptionType.connectionError),
      );
      final result = await repo.getMyBookings(tab: 'upcoming', page: 1, pageSize: 20);
      expect(result, isA<ApiFailure>());
    });
  });

  group('BookingRepoImpl Detail & Payment Methods Tests', () {
    const detail = PlayerBookingDetailModel(
      id: 'b-1',
      reference: 'REF-1',
      venueId: 'v-1',
      pitchId: 'p-1',
      startUtc: '2026-12-01T18:00:00Z',
      endUtc: '2026-12-01T19:00:00Z',
      totalPrice: 200,
      depositAmount: 50,
      currency: 'EGP',
      status: BookingStatus.confirmed,
      allowedActions: PlayerAllowedActionsModel(),
      createdAtUtc: '2026-12-01T10:00:00Z',
    );

    test('53. getBookingDetail returns detail model', () async {
      when(() => mockApi.getBookingDetail('b-1')).thenAnswer((_) async => detail);
      final result = await repo.getBookingDetail('b-1');
      expect(result, isA<Success<PlayerBookingDetailModel>>());
    });

    test('54. getBookingDetail returns failure when not found', () async {
      when(() => mockApi.getBookingDetail('b-999')).thenThrow(
        DioException(requestOptions: RequestOptions(path: ''), response: Response(requestOptions: RequestOptions(path: ''), statusCode: 404)),
      );
      final result = await repo.getBookingDetail('b-999');
      expect(result, isA<ApiFailure>());
    });

    test('55. getPaymentMethods returns payment methods list', () async {
      const pm = [BookingPaymentMethodModel(id: 'pm-1', methodType: 'InstaPay', recipientName: 'Owner', accountDetails: 'test@insta')];
      when(() => mockApi.getPaymentMethods('b-1')).thenAnswer((_) async => pm);
      final result = await repo.getPaymentMethods('b-1');
      expect(result, isA<Success<List<BookingPaymentMethodModel>>>());
    });

    test('56. getPaymentMethods returns failure on 500 error', () async {
      when(() => mockApi.getPaymentMethods('b-1')).thenThrow(
        DioException(requestOptions: RequestOptions(path: ''), response: Response(requestOptions: RequestOptions(path: ''), statusCode: 500)),
      );
      final result = await repo.getPaymentMethods('b-1');
      expect(result, isA<ApiFailure>());
    });
  });

  group('BookingRepoImpl Proof Upload Tests', () {
    const ticket = UploadTicketModel(mediaId: 'm-1', uploadUrl: 'https://upload.example.com/1', expiresAtUtc: '2026-12-01T18:15:00Z');

    test('57. getProofUploadUrl returns upload ticket', () async {
      when(() => mockApi.getProofUploadUrl('b-1')).thenAnswer((_) async => ticket);
      final result = await repo.getProofUploadUrl('b-1');
      expect(result, isA<Success<UploadTicketModel>>());
    });

    test('58. uploadMediaFile calls PUT on dio successfully', () async {
      when(() => mockDio.put<dynamic>(any(), data: any(named: 'data'), options: any(named: 'options')))
          .thenAnswer((_) async => Response(requestOptions: RequestOptions(path: ''), statusCode: 200));

      final result = await repo.uploadMediaFile(uploadUrl: 'https://upload.example.com/1', bytes: [1, 2, 3], contentType: 'image/jpeg');
      expect(result, isA<Success<void>>());
    });

    test('59. uploadMediaFile returns failure when PUT fails', () async {
      when(() => mockDio.put<dynamic>(any(), data: any(named: 'data'), options: any(named: 'options')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: ''), response: Response(requestOptions: RequestOptions(path: ''), statusCode: 403)));

      final result = await repo.uploadMediaFile(uploadUrl: 'https://upload.example.com/1', bytes: [1, 2, 3], contentType: 'image/jpeg');
      expect(result, isA<ApiFailure>());
    });

    test('60. submitProof calls submitProof API successfully', () async {
      when(() => mockApi.submitProof('b-1', any(), 'm-1')).thenAnswer((_) async => {});
      final result = await repo.submitProof(id: 'b-1', mediaId: 'm-1', notes: 'paid');
      expect(result, isA<Success<void>>());
    });

    test('61. submitProof returns failure on 400', () async {
      when(() => mockApi.submitProof('b-1', any(), 'm-1')).thenThrow(
        DioException(requestOptions: RequestOptions(path: ''), response: Response(requestOptions: RequestOptions(path: ''), statusCode: 400)),
      );
      final result = await repo.submitProof(id: 'b-1', mediaId: 'm-1');
      expect(result, isA<ApiFailure>());
    });
  });

  group('BookingRepoImpl Cancellation Tests', () {
    const preview = CancelPreviewModel(canCancel: true, refundPercentage: 100, estimatedRefundAmount: 100, currency: 'EGP');

    test('62. getCancelPreview returns cancel preview data', () async {
      when(() => mockApi.getCancelPreview('b-1')).thenAnswer((_) async => preview);
      final result = await repo.getCancelPreview('b-1');
      expect(result, isA<Success<CancelPreviewModel>>());
    });

    test('63. getCancelPreview returns failure on error', () async {
      when(() => mockApi.getCancelPreview('b-1')).thenThrow(
        DioException(requestOptions: RequestOptions(path: ''), response: Response(requestOptions: RequestOptions(path: ''), statusCode: 400)),
      );
      final result = await repo.getCancelPreview('b-1');
      expect(result, isA<ApiFailure>());
    });

    test('64. cancelBooking calls cancelBooking API successfully', () async {
      when(() => mockApi.cancelBooking('b-1', any(), 'idem-c')).thenAnswer((_) async => {});
      final result = await repo.cancelBooking('b-1', idempotencyKey: 'idem-c', reason: 'sick');
      expect(result, isA<Success<void>>());
    });

    test('65. cancelBooking returns failure on 409 conflict', () async {
      when(() => mockApi.cancelBooking('b-1', any(), 'idem-c')).thenThrow(
        DioException(requestOptions: RequestOptions(path: ''), response: Response(requestOptions: RequestOptions(path: ''), statusCode: 409)),
      );
      final result = await repo.cancelBooking('b-1', idempotencyKey: 'idem-c');
      expect(result, isA<ApiFailure>());
    });
  });
}
