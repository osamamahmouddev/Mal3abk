import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/location/location_service.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../settings/data/models/record_consent_request_body.dart';
import '../../../settings/domain/repos/account_repo.dart';

/// Records the onboarding location/notification choices as consents. The
/// player moves on immediately; a failed write is reconciled from settings.
/// The state is the last choice sent.
class OnboardingConsentCubit extends Cubit<ConsentType?>
    with SafeEmitCubitMixin<ConsentType?> {
  OnboardingConsentCubit({
    required this.accountRepo,
    required this.locationService,
  }) : super(null);

  final AccountRepo accountRepo;
  final LocationService locationService;

  /// Shows the system location prompt and records what the player chose.
  Future<void> allowLocation() async {
    final granted = await locationService.requestPermission();
    record(ConsentType.location, granted: granted);
  }

  void record(ConsentType type, {required bool granted}) {
    emitIfOpen(type);
    accountRepo.recordConsent(type, granted: granted);
  }
}
