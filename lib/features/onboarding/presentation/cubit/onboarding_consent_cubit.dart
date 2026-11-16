import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/location/location_service.dart';
import '../../../../core/services/push_notification_service.dart';
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
    required this.pushNotificationService,
  }) : super(null);

  final AccountRepo accountRepo;
  final LocationService locationService;
  final PushNotificationService pushNotificationService;

  /// Shows the system location prompt and records what the player chose.
  Future<void> allowLocation() async {
    final granted = await locationService.requestPermission();
    record(ConsentType.location, granted: granted);
  }

  /// Shows the system notifications prompt and records what the player chose.
  Future<void> allowNotifications() async {
    final granted = await pushNotificationService.requestPermission();
    record(ConsentType.notifications, granted: granted);
  }

  /// "Not now": recorded, and the app won't ask again on its own.
  void declineNotifications() {
    pushNotificationService.declinePermission();
    record(ConsentType.notifications, granted: false);
  }

  void record(ConsentType type, {required bool granted}) {
    emitIfOpen(type);
    accountRepo.recordConsent(type, granted: granted);
  }
}
