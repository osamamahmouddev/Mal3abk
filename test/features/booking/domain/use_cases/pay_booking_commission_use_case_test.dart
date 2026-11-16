import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/booking/data/models/paymob_checkout_response_model.dart';
import 'package:mal3abk/features/booking/domain/repos/booking_repo.dart';
import 'package:mal3abk/features/booking/domain/use_cases/pay_booking_commission_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockBookingRepo extends Mock implements BookingRepo {}

PaymobCheckoutResponseModel checkout(String url) => PaymobCheckoutResponseModel(
  clientSecret: 'secret',
  checkoutUrl: url,
  amount: 50,
  currency: 'EGP',
  requiresRedirect: true,
);

void main() {
  late MockBookingRepo repo;
  late PayBookingCommissionUseCase useCase;

  setUp(() {
    repo = MockBookingRepo();
    useCase = PayBookingCommissionUseCase(bookingRepo: repo);
  });

  group('PayBookingCommissionUseCase', () {
    test('returns an HTTPS Paymob checkout page', () async {
      const url = 'https://accept.paymob.com/unifiedcheckout/?clientSecret=x';
      when(
        () => repo.payCommission('b-1'),
      ).thenAnswer((_) async => ApiResult.success(checkout(url)));

      final result = await useCase('b-1');

      expect(result, isA<Success<PaymobCheckoutResponseModel>>());
    });

    for (final url in [
      'http://accept.paymob.com/unifiedcheckout/',
      'https://evil.example.com/paymob.com',
      'https://evilpaymob.com/checkout',
      'https://paymob.com.evil.io/checkout',
      'javascript:alert(1)',
      '',
    ]) {
      test('refuses an untrusted checkout link: "$url"', () async {
        when(
          () => repo.payCommission('b-1'),
        ).thenAnswer((_) async => ApiResult.success(checkout(url)));

        final result = await useCase('b-1');

        expect(result, isA<ApiFailure<PaymobCheckoutResponseModel>>());
        expect(
          (result as ApiFailure).failure.message,
          PayBookingCommissionUseCase.invalidCheckoutKey,
        );
      });
    }

    test('passes a server failure through unchanged', () async {
      const failure = AppApiFailure(message: 'errors.server', statusCode: 500);
      when(
        () => repo.payCommission('b-1'),
      ).thenAnswer((_) async => const ApiResult.failure(failure));

      final result = await useCase('b-1');

      expect((result as ApiFailure).failure, same(failure));
    });
  });
}
