import '../../../../core/network/api_result.dart';
import '../../data/models/player_booking_summary_model.dart';
import '../repos/booking_repo.dart';

class GetMyBookingsUseCase {
  GetMyBookingsUseCase({required this.bookingRepo});

  final BookingRepo bookingRepo;

  Future<ApiResult<PlayerBookingsPagedListModel>> call({
    String? tab,
    int? page,
    int? pageSize,
  }) => bookingRepo.getMyBookings(tab: tab, page: page, pageSize: pageSize);
}
