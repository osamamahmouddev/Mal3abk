import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/auth/domain/use_cases/normalize_phone_number_use_case.dart';
import 'package:mal3abk/features/venue_auth/data/models/register_owner_request_body.dart';
import 'package:mal3abk/features/venue_auth/domain/repos/venue_auth_repo.dart';
import 'package:mal3abk/features/venue_auth/presentation/cubit/owner_forgot_password_cubit.dart';
import 'package:mal3abk/features/venue_auth/presentation/cubit/owner_forgot_password_state.dart';
import 'package:mal3abk/features/venue_auth/presentation/cubit/owner_login_cubit.dart';
import 'package:mal3abk/features/venue_auth/presentation/cubit/owner_login_state.dart';
import 'package:mal3abk/features/venue_auth/presentation/cubit/owner_register_cubit.dart';
import 'package:mal3abk/features/venue_auth/presentation/cubit/owner_register_state.dart';
import 'package:mocktail/mocktail.dart';

class MockVenueAuthRepo extends Mock implements VenueAuthRepo {}

class FakeRegisterBody extends Fake implements RegisterOwnerRequestBody {}

void main() {
  late MockVenueAuthRepo repo;

  setUpAll(() => registerFallbackValue(FakeRegisterBody()));
  setUp(() => repo = MockVenueAuthRepo());

  group('OwnerLoginCubit', () {
    test('asks for both fields before calling the API', () async {
      final cubit = OwnerLoginCubit(venueAuthRepo: repo);
      await cubit.login(email: ' ', password: '');
      expect(
        cubit.state,
        const OwnerLoginState.error('venue_auth.login.fill_credentials'),
      );
      verifyNever(
        () => repo.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
          totpCode: any(named: 'totpCode'),
        ),
      );
      await cubit.close();
    });

    test('signs in', () async {
      when(
        () => repo.login(email: 'o@x.com', password: 'secret-pass'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      final cubit = OwnerLoginCubit(venueAuthRepo: repo);
      await cubit.login(email: 'o@x.com', password: 'secret-pass');
      expect(cubit.state, const OwnerLoginState.success());
      await cubit.close();
    });

    test('asks for the authenticator code, then sends it', () async {
      when(() => repo.login(email: 'o@x.com', password: 'p')).thenAnswer(
        (_) async => const ApiResult.failure(
          AppApiFailure(
            message: 'errors.venue_auth.two_factor_required',
            code: 'Identity.TwoFactorRequired',
          ),
        ),
      );
      final cubit = OwnerLoginCubit(venueAuthRepo: repo);
      await cubit.login(email: 'o@x.com', password: 'p');
      expect(cubit.state, const OwnerLoginState.totpRequired());
      expect(cubit.needsTotp, isTrue);

      await cubit.login(email: 'o@x.com', password: 'p', totpCode: '');
      expect(
        cubit.state,
        const OwnerLoginState.error('venue_auth.login.totp_missing'),
      );

      when(
        () => repo.login(email: 'o@x.com', password: 'p', totpCode: '123456'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      await cubit.login(email: 'o@x.com', password: 'p', totpCode: '123456');
      expect(cubit.state, const OwnerLoginState.success());
      await cubit.close();
    });

    test('shows the failure key for wrong credentials', () async {
      when(() => repo.login(email: 'o@x.com', password: 'bad')).thenAnswer(
        (_) async => const ApiResult.failure(
          AppApiFailure(
            message: 'errors.venue_auth.invalid_credentials',
            code: 'Identity.InvalidCredentials',
          ),
        ),
      );
      final cubit = OwnerLoginCubit(venueAuthRepo: repo);
      await cubit.login(email: 'o@x.com', password: 'bad');
      expect(
        cubit.state,
        const OwnerLoginState.error('errors.venue_auth.invalid_credentials'),
      );
      await cubit.close();
    });
  });

  group('OwnerRegisterCubit', () {
    OwnerRegisterCubit build() => OwnerRegisterCubit(
      venueAuthRepo: repo,
      normalizePhoneNumberUseCase: NormalizePhoneNumberUseCase(),
    );

    test('validates before sending', () async {
      final cubit = build();
      await cubit.register(
        fullName: 'Owner',
        email: 'not-an-email',
        phoneNumber: '01012345678',
        password: '1234567890',
      );
      expect(
        cubit.state,
        const OwnerRegisterState.error('errors.venue_auth.invalid_email'),
      );
      await cubit.register(
        fullName: 'Owner',
        email: 'o@x.com',
        phoneNumber: '01012345678',
        password: 'short',
      );
      expect(
        cubit.state,
        const OwnerRegisterState.error('venue_auth.register.password_short'),
      );
      await cubit.register(
        fullName: 'Owner',
        email: 'o@x.com',
        phoneNumber: '123',
        password: '1234567890',
      );
      expect(
        cubit.state,
        const OwnerRegisterState.error('errors.identity.invalid_phone'),
      );
      verifyNever(() => repo.registerOwner(any()));
      await cubit.close();
    });

    test('sends the phone in E.164 and can resend the link', () async {
      RegisterOwnerRequestBody? sent;
      when(() => repo.registerOwner(any())).thenAnswer((inv) async {
        sent = inv.positionalArguments.first as RegisterOwnerRequestBody;
        return const ApiResult.success(null);
      });
      when(
        () => repo.resendVerification('o@x.com'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      final cubit = build();
      await cubit.register(
        fullName: ' Owner ',
        email: 'o@x.com',
        phoneNumber: '010 1234 5678',
        password: '1234567890',
      );
      expect(sent?.phoneNumber, '+201012345678');
      expect(sent?.fullName, 'Owner');
      expect(cubit.state, isA<OwnerRegisterSuccess>());

      await cubit.resendActivation();
      expect((cubit.state as OwnerRegisterSuccess).resent, isTrue);
      await cubit.close();
    });
  });

  group('OwnerForgotPasswordCubit', () {
    test('rejects a bad email and sends a good one', () async {
      when(
        () => repo.forgotPassword('o@x.com'),
      ).thenAnswer((_) async => const ApiResult.success(null));
      final cubit = OwnerForgotPasswordCubit(venueAuthRepo: repo);
      await cubit.send('bad');
      expect(cubit.state, isA<OwnerForgotPasswordError>());
      await cubit.send('o@x.com');
      expect(cubit.state, const OwnerForgotPasswordState.sent());
      await cubit.close();
    });
  });
}
