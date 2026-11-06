import '../../../../core/network/api_result.dart';
import '../../data/models/booking_quote_request_body.dart';
import '../../data/models/booking_quote_response_model.dart';
import '../repos/booking_repo.dart';

class GetBookingQuoteUseCase {
  GetBookingQuoteUseCase({required this.bookingRepo});

  final BookingRepo bookingRepo;

  Future<ApiResult<BookingQuoteResponseModel>> call(
    BookingQuoteRequestBody body,
  ) => bookingRepo.getQuote(body);
}
