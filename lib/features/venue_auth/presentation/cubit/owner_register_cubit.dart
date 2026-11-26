import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app/app_regex.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../auth/domain/use_cases/normalize_phone_number_use_case.dart';
import '../../data/models/register_owner_request_body.dart';
import '../../domain/repos/venue_auth_repo.dart';
import 'owner_register_state.dart';

class OwnerRegisterCubit extends Cubit<OwnerRegisterState>
    with SafeEmitCubitMixin<OwnerRegisterState> {
  OwnerRegisterCubit({
    required this.venueAuthRepo,
    required this.normalizePhoneNumberUseCase,
  }) : super(const OwnerRegisterState.initial());

  final VenueAuthRepo venueAuthRepo;
  final NormalizePhoneNumberUseCase normalizePhoneNumberUseCase;

  /// Same minimum as the API, which also rejects common passwords.
  static const int minPasswordLength = 10;

  Future<void> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    if (state is OwnerRegisterLoading) return;
    final name = fullName.trim();
    final mail = email.trim();
    final error = switch (null) {
      _ when name.isEmpty => 'venue_auth.register.name_required',
      _ when !AppRegex.isEmailValid(mail) => 'errors.venue_auth.invalid_email',
      _ when password.length < minPasswordLength =>
        'venue_auth.register.password_short',
      _ => null,
    };
    if (error != null) {
      emitIfOpen(OwnerRegisterState.error(error));
      return;
    }

    String? phone;
    String? phoneError;
    normalizePhoneNumberUseCase(phoneNumber).when(
      success: (value) => phone = value,
      failure: (failure) => phoneError = failure.message,
    );
    if (phone == null) {
      emitIfOpen(OwnerRegisterState.error(phoneError!));
      return;
    }

    emitIfOpen(const OwnerRegisterState.loading());
    final result = await venueAuthRepo.registerOwner(
      RegisterOwnerRequestBody(
        fullName: name,
        email: mail,
        phoneNumber: phone!,
        password: password,
      ),
    );
    result.when(
      success: (_) => emitIfOpen(
        OwnerRegisterState.success(email: mail, phoneNumber: phoneNumber),
      ),
      failure: (failure) =>
          emitIfOpen(OwnerRegisterState.error(failure.message)),
    );
  }

  Future<void> resendActivation() async {
    final current = state;
    if (current is! OwnerRegisterSuccess || current.resending) return;
    emitIfOpen(current.copyWith(resending: true, resent: false));
    final result = await venueAuthRepo.resendVerification(current.email);
    emitIfOpen(
      current.copyWith(
        resending: false,
        resent: result.when(success: (_) => true, failure: (_) => false),
      ),
    );
  }
}
