import '../../../../core/network/api_result.dart';
import '../../../venue_calendar/data/models/venue_customer_model.dart';
import '../../data/models/venue_customer_detail_model.dart';

abstract class VenueCustomersRepo {
  Future<ApiResult<VenueCustomerPageModel>> getCustomers(
    String venueId, {
    String search = '',
    int page = 1,
    int pageSize = 25,
  });

  Future<ApiResult<VenueCustomerDetailModel>> getCustomer(
    String venueId,
    String customerKey,
  );

  Future<ApiResult<void>> addNote(
    String venueId,
    String customerKey,
    String text,
  );

  Future<ApiResult<void>> deleteNote(
    String venueId,
    String customerKey,
    String noteId,
  );
}
