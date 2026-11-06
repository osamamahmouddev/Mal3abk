import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../settings/data/models/record_consent_request_body.dart';
import '../../../settings/domain/repos/account_repo.dart';

/// Records the onboarding location/notification choices as consents. The
/// player moves on immediately; a failed write is reconciled from settings.
/// The state is the last choice sent.
class OnboardingConsentCubit extends Cubit<ConsentType?>
    with SafeEmitCubitMixin<ConsentType?> {
  OnboardingConsentCubit({required this.accountRepo}) : super(null);

  final AccountRepo accountRepo;

  void record(ConsentType type, {required bool granted}) {
    emitIfOpen(type);
    accountRepo.recordConsent(type, granted: granted);
  }
}
