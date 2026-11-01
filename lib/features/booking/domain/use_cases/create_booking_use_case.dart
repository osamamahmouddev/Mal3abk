import '../../../../core/network/api_result.dart';
import '../../data/models/create_booking_request_body.dart';
import '../../data/models/create_booking_response_model.dart';
import '../repos/booking_repo.dart';

class CreateBookingUseCase {
  CreateBookingUseCase({required this.bookingRepo});

  final BookingRepo bookingRepo;

  Future<ApiResult<CreateBookingResponseModel>> call({
    required CreateBookingRequestBody body,
    required String idempotencyKey,
  }) => bookingRepo.createBooking(body: body, idempotencyKey: idempotencyKey);
}
