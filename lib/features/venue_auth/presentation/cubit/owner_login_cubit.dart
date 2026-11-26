import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/venue_auth_repo.dart';
import 'owner_login_state.dart';

class OwnerLoginCubit extends Cubit<OwnerLoginState>
    with SafeEmitCubitMixin<OwnerLoginState> {
  OwnerLoginCubit({required this.venueAuthRepo})
    : super(const OwnerLoginState.initial());

  final VenueAuthRepo venueAuthRepo;

  /// Stays on once the API asked for the authenticator code.
  bool _needsTotp = false;
  bool get needsTotp => _needsTotp;

  Future<void> login({
    required String email,
    required String password,
    String? totpCode,
  }) async {
    if (state is OwnerLoginLoading) return;
    if (email.trim().isEmpty || password.isEmpty) {
      emitIfOpen(
        const OwnerLoginState.error('venue_auth.login.fill_credentials'),
      );
      return;
    }
    if (_needsTotp && (totpCode?.trim().isEmpty ?? true)) {
      emitIfOpen(const OwnerLoginState.error('venue_auth.login.totp_missing'));
      return;
    }

    emitIfOpen(const OwnerLoginState.loading());
    final result = await venueAuthRepo.login(
      email: email,
      password: password,
      totpCode: _needsTotp ? totpCode : null,
    );
    result.when(
      success: (_) => emitIfOpen(const OwnerLoginState.success()),
      failure: (failure) {
        if (failure.code == 'Identity.TwoFactorRequired') {
          _needsTotp = true;
          emitIfOpen(const OwnerLoginState.totpRequired());
          return;
        }
        emitIfOpen(OwnerLoginState.error(failure.message));
      },
    );
  }
}
