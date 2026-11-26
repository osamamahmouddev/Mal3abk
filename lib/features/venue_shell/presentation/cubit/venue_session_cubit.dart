import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/my_permissions_model.dart';
import '../../data/models/venue_model.dart';
import '../../domain/repos/venue_shell_repo.dart';
import 'venue_session_state.dart';

/// The venue dashboard's session: the venues the user manages, the one open
/// now and what the user may do there. Every venue screen reads it.
class VenueSessionCubit extends Cubit<VenueSessionState>
    with SafeEmitCubitMixin<VenueSessionState> {
  VenueSessionCubit({required this.venueShellRepo})
    : super(const VenueSessionState.loading());

  final VenueShellRepo venueShellRepo;

  MyPermissionsModel _permissions = const MyPermissionsModel();

  /// [preferVenueId] opens that venue (e.g. one just created).
  Future<void> load({String? preferVenueId}) async {
    if (state is! VenueSessionReady) {
      emitIfOpen(const VenueSessionState.loading());
    }
    final results = await Future.wait([
      venueShellRepo.getVenues(),
      venueShellRepo.getPermissions(),
    ]);
    final venuesResult = results[0] as ApiResult<List<VenueModel>>;
    final permissionsResult = results[1] as ApiResult<MyPermissionsModel>;

    final failure = venuesResult.when(
      success: (_) => null,
      failure: (f) => f.message,
    );
    if (failure != null) {
      // A failed request is not "no venues": never send them to set one up.
      if (state is! VenueSessionReady) {
        emitIfOpen(VenueSessionState.error(failure));
      }
      return;
    }
    permissionsResult.when(
      success: (value) => _permissions = value,
      failure: (_) {},
    );

    final venues = venuesResult.when(
      success: (v) => v,
      failure: (_) => const <VenueModel>[],
    );
    if (venues.isEmpty) {
      emitIfOpen(const VenueSessionState.noVenue());
      return;
    }
    final current = state is VenueSessionReady
        ? (state as VenueSessionReady).venue.id
        : null;
    final wanted =
        preferVenueId ?? current ?? await venueShellRepo.readSelectedVenueId();
    final venue =
        venues.where((v) => v.id == wanted).firstOrNull ?? venues.first;
    _emitReady(venues, venue);
  }

  Future<void> selectVenue(String venueId) async {
    final current = state;
    if (current is! VenueSessionReady || current.venue.id == venueId) return;
    final venue = current.venues.where((v) => v.id == venueId).firstOrNull;
    if (venue == null) return;
    await venueShellRepo.saveSelectedVenueId(venueId);
    _emitReady(current.venues, venue);
  }

  void _emitReady(List<VenueModel> venues, VenueModel venue) {
    final access = _permissions.venues
        .where((v) => v.venueId == venue.id)
        .firstOrNull;
    emitIfOpen(
      VenueSessionState.ready(
        venues: venues,
        venue: venue,
        permissions: _permissions.forVenue(venue.id),
        accessLevel: access?.accessLevel ?? '',
      ),
    );
  }
}
