import '../../../../core/network/api_result.dart';
import '../../data/models/player_booking_detail_model.dart';
import '../repos/booking_repo.dart';

class GetBookingDetailUseCase {
  const GetBookingDetailUseCase({required this.bookingRepo});

  final BookingRepo bookingRepo;

  Future<ApiResult<PlayerBookingDetailModel>> call(String id) {
    return bookingRepo.getBookingDetail(id);
  }
}
