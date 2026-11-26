import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:mal3abk/features/auth/presentation/cubit/logout_state.dart';
import 'package:mal3abk/features/venue_shell/data/models/my_permissions_model.dart';
import 'package:mal3abk/features/venue_shell/data/models/venue_model.dart';
import 'package:mal3abk/features/venue_shell/presentation/cubit/venue_session_cubit.dart';
import 'package:mal3abk/features/venue_shell/presentation/cubit/venue_session_state.dart';
import 'package:mal3abk/features/venue_shell/presentation/screens/venue_more_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/pump_localized.dart';

class MockSession extends Mock implements VenueSessionCubit {}

class MockLogout extends Mock implements LogoutCubit {}

const venue = VenueModel(
  id: 'v1',
  name: 'Venue',
  address: 'a',
  city: 'c',
  area: 'ar',
  phoneNumber: '0',
  approvalStatus: 'Approved',
  isApproved: true,
  isPublished: true,
);

/// A receptionist sees only the sections their role can open; the owner-only
/// ones (staff, reports, payouts, customers) stay hidden.
void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('the More tab follows the role permissions', (tester) async {
    final session = MockSession();
    const state = VenueSessionState.ready(
      venues: [venue],
      venue: venue,
      permissions: {VenuePermissions.venueView, VenuePermissions.bookingsView},
      accessLevel: 'Staff',
    );
    when(() => session.state).thenReturn(state);
    when(() => session.stream).thenAnswer((_) => const Stream.empty());
    when(session.close).thenAnswer((_) async {});
    final logout = MockLogout();
    when(() => logout.state).thenReturn(const LogoutState.initial());
    when(() => logout.stream).thenAnswer((_) => const Stream.empty());
    when(logout.close).thenAnswer((_) async {});

    await pumpLocalized(
      tester,
      MultiBlocProvider(
        providers: [
          BlocProvider<VenueSessionCubit>.value(value: session),
          BlocProvider<LogoutCubit>.value(value: logout),
        ],
        child: VenueMoreScreen(onOpenTab: (_) {}),
      ),
    );

    String t(String key) => 'venue.more.$key'.tr();
    for (final visible in [
      'pitches',
      'schedule',
      'pricing',
      'policies',
      'notifications',
      'settings',
    ]) {
      expect(find.text(t(visible)), findsOneWidget, reason: visible);
    }
    for (final hidden in [
      'customers',
      'reports',
      'payouts',
      'staff',
      'venue_setup',
    ]) {
      expect(find.text(t(hidden)), findsNothing, reason: hidden);
    }
    expect(find.text('auth.logout'.tr()), findsOneWidget);
  });
}
