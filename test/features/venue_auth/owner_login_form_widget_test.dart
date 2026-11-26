import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/venue_auth/domain/repos/venue_auth_repo.dart';
import 'package:mal3abk/features/venue_auth/presentation/cubit/owner_login_cubit.dart';
import 'package:mal3abk/features/venue_auth/presentation/widgets/account_role_switch_widget.dart';
import 'package:mal3abk/features/venue_auth/presentation/widgets/owner_login_form_widget.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/pump_localized.dart';

class MockVenueAuthRepo extends Mock implements VenueAuthRepo {}

/// The login role switch: picking "venue owner" shows the email and password
/// form, which checks the fields, then asks for the authenticator code when
/// the API says two-factor sign-in is on.
void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  // One test: easy_localization keeps global state between widget tests.
  testWidgets('owner sign-in from the role switch', (tester) async {
    final repo = MockVenueAuthRepo();
    when(
      () => repo.login(email: 'o@x.com', password: 'secret-pass'),
    ).thenAnswer(
      (_) async => const ApiResult.failure(
        AppApiFailure(
          message: 'errors.venue_auth.two_factor_required',
          code: 'Identity.TwoFactorRequired',
        ),
      ),
    );
    final cubit = OwnerLoginCubit(venueAuthRepo: repo);
    addTearDown(cubit.close);

    await pumpLocalized(
      tester,
      BlocProvider.value(
        value: cubit,
        child: HookBuilder(
          builder: (context) {
            final isOwner = useState(false);
            return SingleChildScrollView(
              child: Column(
                children: [
                  AccountRoleSwitchWidget(
                    isOwner: isOwner.value,
                    onChanged: (v) => isOwner.value = v,
                  ),
                  if (isOwner.value)
                    const OwnerLoginFormWidget()
                  else
                    const Text('player-step'),
                ],
              ),
            );
          },
        ),
      ),
    );

    expect(find.text('player-step'), findsOneWidget);
    await tester.tap(find.text('venue_auth.role.owner'.tr()));
    await tester.pumpAndSettle();
    expect(find.text('player-step'), findsNothing);
    expect(find.text('venue_auth.login.email_label'.tr()), findsOneWidget);
    expect(find.text('venue_auth.login.password_label'.tr()), findsOneWidget);
    expect(find.text('venue_auth.login.register_venue'.tr()), findsOneWidget);
    expect(find.text('venue_auth.login.totp_label'.tr()), findsNothing);

    await tester.tap(find.text('venue_auth.login.submit'.tr()));
    await tester.pumpAndSettle();
    expect(find.text('venue_auth.login.fill_credentials'.tr()), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'o@x.com');
    await tester.enterText(fields.at(1), 'secret-pass');
    await tester.tap(find.text('venue_auth.login.submit'.tr()));
    await tester.pumpAndSettle();
    verify(
      () => repo.login(email: 'o@x.com', password: 'secret-pass'),
    ).called(1);
    expect(find.text('venue_auth.login.totp_label'.tr()), findsOneWidget);
  });
}
