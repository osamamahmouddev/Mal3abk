import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/venue_shell/data/models/my_permissions_model.dart';
import 'package:mal3abk/features/venue_shell/data/models/venue_model.dart';
import 'package:mal3abk/features/venue_shell/domain/repos/venue_shell_repo.dart';
import 'package:mal3abk/features/venue_shell/presentation/cubit/venue_session_cubit.dart';
import 'package:mal3abk/features/venue_shell/presentation/cubit/venue_session_state.dart';
import 'package:mocktail/mocktail.dart';

class MockVenueShellRepo extends Mock implements VenueShellRepo {}

VenueModel venue(String id) => VenueModel(
  id: id,
  name: 'Venue $id',
  address: 'a',
  city: 'c',
  area: 'ar',
  phoneNumber: '0100',
  approvalStatus: 'Approved',
  isApproved: true,
  isPublished: true,
);

const permissions = MyPermissionsModel(
  roles: ['VenueOwner'],
  venues: [
    VenuePermissionsModel(
      venueId: 'v1',
      accessLevel: 'Owner',
      permissions: ['venue.view', 'venue.bookings.approve'],
    ),
    VenuePermissionsModel(
      venueId: 'v2',
      accessLevel: 'Staff',
      permissions: ['venue.view'],
    ),
  ],
);

void main() {
  late MockVenueShellRepo repo;

  setUp(() {
    repo = MockVenueShellRepo();
    when(
      () => repo.getPermissions(),
    ).thenAnswer((_) async => const ApiResult.success(permissions));
    when(() => repo.readSelectedVenueId()).thenAnswer((_) async => null);
    when(() => repo.saveSelectedVenueId(any())).thenAnswer((_) async {});
  });

  test('opens the first venue with its permissions', () async {
    when(
      () => repo.getVenues(),
    ).thenAnswer((_) async => ApiResult.success([venue('v1'), venue('v2')]));
    final cubit = VenueSessionCubit(venueShellRepo: repo);
    await cubit.load();
    final state = cubit.state as VenueSessionReady;
    expect(state.venue.id, 'v1');
    expect(state.isOwner, isTrue);
    expect(state.can(VenuePermissions.bookingsApprove), isTrue);
    await cubit.close();
  });

  test('switching venue switches permissions and is remembered', () async {
    when(
      () => repo.getVenues(),
    ).thenAnswer((_) async => ApiResult.success([venue('v1'), venue('v2')]));
    final cubit = VenueSessionCubit(venueShellRepo: repo);
    await cubit.load();
    await cubit.selectVenue('v2');
    final state = cubit.state as VenueSessionReady;
    expect(state.venue.id, 'v2');
    expect(state.isOwner, isFalse);
    expect(state.can(VenuePermissions.bookingsApprove), isFalse);
    verify(() => repo.saveSelectedVenueId('v2')).called(1);
    await cubit.close();
  });

  test('no venues sends the owner to set one up', () async {
    when(
      () => repo.getVenues(),
    ).thenAnswer((_) async => const ApiResult.success([]));
    final cubit = VenueSessionCubit(venueShellRepo: repo);
    await cubit.load();
    expect(cubit.state, const VenueSessionState.noVenue());
    await cubit.close();
  });

  test('a failed request is an error, not "no venues"', () async {
    when(() => repo.getVenues()).thenAnswer(
      (_) async =>
          const ApiResult.failure(AppApiFailure(message: 'errors.network')),
    );
    final cubit = VenueSessionCubit(venueShellRepo: repo);
    await cubit.load();
    expect(cubit.state, const VenueSessionState.error('errors.network'));
    await cubit.close();
  });
}
