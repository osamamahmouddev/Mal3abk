import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../data/models/paymob_checkout_response_model.dart';
import '../repos/booking_repo.dart';

/// Starts the Paymob payment of the booking fee. The checkout page opens in
/// a browser where the player types card details, so the link must be HTTPS
/// on a Paymob domain: anything else is refused instead of opened.
class PayBookingCommissionUseCase {
  const PayBookingCommissionUseCase({required this.bookingRepo});

  static const String invalidCheckoutKey = 'booking.paymob_launch_error';

  /// Paymob checkout hosts (e.g. `accept.paymob.com`).
  static const List<String> allowedHostSuffixes = [
    'paymob.com',
    'paymobsolutions.com',
  ];

  final BookingRepo bookingRepo;

  Future<ApiResult<PaymobCheckoutResponseModel>> call(String bookingId) async {
    final result = await bookingRepo.payCommission(bookingId);
    if (result case Success(
      :final data,
    ) when !isTrustedCheckoutUrl(data.checkoutUrl)) {
      return const ApiResult.failure(
        AppApiFailure(
          message: invalidCheckoutKey,
          code: 'booking.untrusted_checkout_url',
        ),
      );
    }
    return result;
  }

  static bool isTrustedCheckoutUrl(String url) {
    final uri = Uri.tryParse(url.trim());
    if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
      return false;
    }
    final host = uri.host.toLowerCase();
    return allowedHostSuffixes.any(
      (suffix) => host == suffix || host.endsWith('.$suffix'),
    );
  }
}
