import '../../../../core/network/api_result.dart';
import '../../data/models/booking_payment_method_model.dart';
import '../../data/models/cancel_preview_model.dart';
import '../../data/models/booking_quote_request_body.dart';
import '../../data/models/booking_quote_response_model.dart';
import '../../data/models/create_booking_request_body.dart';
import '../../data/models/create_booking_response_model.dart';
import '../../data/models/player_booking_detail_model.dart';
import '../../data/models/player_booking_summary_model.dart';
import '../../data/models/upload_ticket_model.dart';

abstract class BookingRepo {
  Future<ApiResult<BookingQuoteResponseModel>> getQuote(
    BookingQuoteRequestBody body,
  );

  Future<ApiResult<CreateBookingResponseModel>> createBooking({
    required CreateBookingRequestBody body,
    required String idempotencyKey,
  });

  Future<ApiResult<PlayerBookingsPagedListModel>> getMyBookings({
    String? tab,
    int? page,
    int? pageSize,
  });

  Future<ApiResult<PlayerBookingDetailModel>> getBookingDetail(String id);

  Future<ApiResult<UploadTicketModel>> getProofUploadUrl(String id);

  Future<ApiResult<void>> uploadMediaFile({
    required String uploadUrl,
    required List<int> bytes,
    required String contentType,
  });

  /// The uploaded media id doubles as the `Idempotency-Key`, so a retried
  /// submit of the same receipt is applied once.
  Future<ApiResult<void>> submitProof({
    required String id,
    required String mediaId,
    String? notes,
  });

  /// Where to send the deposit; only while it can still be paid.
  Future<ApiResult<List<BookingPaymentMethodModel>>> getPaymentMethods(
    String id,
  );

  Future<ApiResult<CancelPreviewModel>> getCancelPreview(String id);

  Future<ApiResult<void>> cancelBooking(
    String id, {
    required String idempotencyKey,
    String? reason,
  });
}
