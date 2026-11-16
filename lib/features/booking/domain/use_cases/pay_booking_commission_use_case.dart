import '../../../../core/network/api_result.dart';
import '../../data/models/paymob_checkout_response_model.dart';
import '../repos/booking_repo.dart';

class PayBookingCommissionUseCase {
  const PayBookingCommissionUseCase({required this.bookingRepo});

  final BookingRepo bookingRepo;

  Future<ApiResult<PaymobCheckoutResponseModel>> call(String bookingId) {
    return bookingRepo.payCommission(bookingId);
  }
}
