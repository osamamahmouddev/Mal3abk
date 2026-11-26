import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app/app_regex.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/venue_auth_repo.dart';
import 'owner_forgot_password_state.dart';

class OwnerForgotPasswordCubit extends Cubit<OwnerForgotPasswordState>
    with SafeEmitCubitMixin<OwnerForgotPasswordState> {
  OwnerForgotPasswordCubit({required this.venueAuthRepo})
    : super(const OwnerForgotPasswordState.initial());

  final VenueAuthRepo venueAuthRepo;

  Future<void> send(String email) async {
    if (state is OwnerForgotPasswordLoading) return;
    if (!AppRegex.isEmailValid(email.trim())) {
      emitIfOpen(
        const OwnerForgotPasswordState.error('errors.venue_auth.invalid_email'),
      );
      return;
    }
    emitIfOpen(const OwnerForgotPasswordState.loading());
    final result = await venueAuthRepo.forgotPassword(email);
    result.when(
      success: (_) => emitIfOpen(const OwnerForgotPasswordState.sent()),
      failure: (failure) =>
          emitIfOpen(OwnerForgotPasswordState.error(failure.message)),
    );
  }
}
