import 'package:dio/dio.dart';

import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repos/booking_repo.dart';
import '../apis/booking_api_service.dart';
import '../models/booking_payment_method_model.dart';
import '../models/cancel_booking_request_body.dart';
import '../models/cancel_preview_model.dart';
import '../models/booking_quote_request_body.dart';
import '../models/booking_quote_response_model.dart';
import '../models/create_booking_request_body.dart';
import '../models/create_booking_response_model.dart';
import '../models/player_booking_detail_model.dart';
import '../models/player_booking_summary_model.dart';
import '../models/submit_proof_request_body.dart';
import '../models/upload_ticket_model.dart';

class BookingRepoImpl implements BookingRepo {
  BookingRepoImpl({required this.bookingApiService, required this.dio});

  final BookingApiService bookingApiService;
  final Dio dio;

  @override
  Future<ApiResult<BookingQuoteResponseModel>> getQuote(
    BookingQuoteRequestBody body,
  ) async {
    try {
      final response = await bookingApiService.getQuote(body);
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<CreateBookingResponseModel>> createBooking({
    required CreateBookingRequestBody body,
    required String idempotencyKey,
  }) async {
    try {
      final response = await bookingApiService.createBooking(
        body,
        idempotencyKey,
      );
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<PlayerBookingsPagedListModel>> getMyBookings({
    String? tab,
    int? page,
    int? pageSize,
  }) async {
    try {
      final response = await bookingApiService.getMyBookings(
        tab: tab,
        page: page,
        pageSize: pageSize,
      );
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<PlayerBookingDetailModel>> getBookingDetail(
    String id,
  ) async {
    try {
      final response = await bookingApiService.getBookingDetail(id);
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<UploadTicketModel>> getProofUploadUrl(String id) async {
    try {
      final response = await bookingApiService.getProofUploadUrl(id);
      return ApiResult.success(response);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> uploadMediaFile({
    required String uploadUrl,
    required List<int> bytes,
    required String contentType,
  }) async {
    try {
      final normalizedUrl = uploadUrl.startsWith('http')
          ? uploadUrl
          : uploadUrl.startsWith('/')
          ? uploadUrl
          : '/$uploadUrl';
      await dio.put<dynamic>(
        normalizedUrl,
        data: bytes,
        options: Options(
          headers: {
            'Content-Type': contentType,
            'Content-Length': bytes.length,
          },
        ),
      );
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> submitProof({
    required String id,
    required String mediaId,
    String? notes,
  }) async {
    try {
      await bookingApiService.submitProof(
        id,
        SubmitProofRequestBody(mediaId: mediaId, notes: notes),
        mediaId,
      );
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<List<BookingPaymentMethodModel>>> getPaymentMethods(
    String id,
  ) async {
    try {
      return ApiResult.success(await bookingApiService.getPaymentMethods(id));
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<CancelPreviewModel>> getCancelPreview(String id) async {
    try {
      return ApiResult.success(await bookingApiService.getCancelPreview(id));
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }

  @override
  Future<ApiResult<void>> cancelBooking(
    String id, {
    required String idempotencyKey,
    String? reason,
  }) async {
    try {
      await bookingApiService.cancelBooking(
        id,
        CancelBookingRequestBody(reason: reason),
        idempotencyKey,
      );
      return const ApiResult.success(null);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }
}
