import '../../../../core/network/api_result.dart';
import '../../data/models/venue_payment_method_model.dart';
import '../repos/explore_repo.dart';

class GetVenuePaymentMethodsUseCase {
  const GetVenuePaymentMethodsUseCase({required this.exploreRepo});

  final ExploreRepo exploreRepo;

  Future<ApiResult<List<VenuePaymentMethodModel>>> call(String venueId) {
    return exploreRepo.getVenuePaymentMethods(venueId);
  }
}
