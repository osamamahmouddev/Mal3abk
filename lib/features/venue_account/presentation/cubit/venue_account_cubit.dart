import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/venue_account_repo.dart';

part 'venue_account_cubit.freezed.dart';

@freezed
abstract class VenueAccountState with _$VenueAccountState {
  const factory VenueAccountState({
    VenueAccountProfile? profile,
    @Default(true) bool loading,
    @Default(false) bool busy,
    String? error,

    /// While enrolling two-factor sign-in: the secret and its link.
    String? totpSecret,
    String? totpUri,

    /// The phone change request in progress.
    String? phoneRequestId,
  }) = _VenueAccountState;
}

/// Account and security of the venue settings page. Every action returns
/// the failure key, or null when it worked.
class VenueAccountCubit extends Cubit<VenueAccountState>
    with SafeEmitCubitMixin<VenueAccountState> {
  VenueAccountCubit({required this.venueAccountRepo})
    : super(const VenueAccountState());

  final VenueAccountRepo venueAccountRepo;

  static const int minPasswordLength = 10;

  Future<void> load() async {
    final result = await venueAccountRepo.getProfile();
    result.when(
      success: (p) =>
          emitIfOpen(state.copyWith(profile: p, loading: false, error: null)),
      failure: (f) =>
          emitIfOpen(state.copyWith(loading: false, error: f.message)),
    );
  }

  Future<String?> updateName(String name) {
    if (name.trim().isEmpty) {
      return Future.value('venue_auth.register.name_required');
    }
    return _run(() => venueAccountRepo.updateName(name), reload: true);
  }

  Future<String?> changePassword(String current, String next) {
    if (current.isEmpty) {
      return Future.value('venue.settings.password_current_required');
    }
    if (next.length < minPasswordLength) {
      return Future.value('venue_auth.register.password_short');
    }
    return _run(() => venueAccountRepo.changePassword(current, next));
  }

  Future<String?> enrollTotp() async {
    emitIfOpen(state.copyWith(busy: true));
    final result = await venueAccountRepo.enrollTotp();
    emitIfOpen(state.copyWith(busy: false));
    return result.when(
      success: (r) {
        emitIfOpen(state.copyWith(totpSecret: r.$1, totpUri: r.$2));
        return null;
      },
      failure: (f) => f.message,
    );
  }

  Future<String?> confirmTotp(String code) async {
    final error = await _run(() => venueAccountRepo.confirmTotp(code));
    if (error == null) {
      emitIfOpen(state.copyWith(totpSecret: null, totpUri: null));
    }
    return error;
  }

  Future<String?> startEmailChange(String email, String password) =>
      _run(() => venueAccountRepo.startEmailChange(email, password));

  Future<String?> confirmEmailChange(String code) =>
      _run(() => venueAccountRepo.confirmEmailChange(code));

  Future<String?> startPhoneChange(String phone, String password) async {
    emitIfOpen(state.copyWith(busy: true));
    final result = await venueAccountRepo.startPhoneChange(phone, password);
    emitIfOpen(state.copyWith(busy: false));
    return result.when(
      success: (id) {
        emitIfOpen(state.copyWith(phoneRequestId: id));
        return null;
      },
      failure: (f) => f.message,
    );
  }

  Future<String?> verifyOldPhone(String code) => _run(
    () => venueAccountRepo.verifyOldPhone(state.phoneRequestId ?? '', code),
  );

  Future<String?> verifyNewPhone(String code) => _run(
    () => venueAccountRepo.verifyNewPhone(state.phoneRequestId ?? '', code),
  );

  Future<String?> _run(
    Future<ApiResult<void>> Function() call, {
    bool reload = false,
  }) async {
    emitIfOpen(state.copyWith(busy: true));
    final result = await call();
    emitIfOpen(state.copyWith(busy: false));
    return result.when(
      success: (_) {
        if (reload) load();
        return null;
      },
      failure: (f) => f.message,
    );
  }
}
