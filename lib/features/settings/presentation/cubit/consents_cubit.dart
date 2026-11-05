import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/consents_model.dart';
import '../../data/models/record_consent_request_body.dart';
import '../../domain/repos/account_repo.dart';
import 'consents_state.dart';

class ConsentsCubit extends Cubit<ConsentsState>
    with SafeEmitCubitMixin<ConsentsState> {
  ConsentsCubit({required this.accountRepo})
    : super(const ConsentsState.initial());

  final AccountRepo accountRepo;

  Future<void> load() async {
    emitIfOpen(const ConsentsState.loading());
    final result = await accountRepo.getConsents();
    result.when(
      success: (consents) => emitIfOpen(ConsentsState.success(consents)),
      failure: (failure) => emitIfOpen(ConsentsState.error(failure.message)),
    );
  }

  Future<void> set(ConsentType type, {required bool granted}) async {
    final current = state;
    if (current is! ConsentsSuccess) return;
    final previous = current.consents;
    emitIfOpen(
      ConsentsState.success(
        ConsentsModel(
          current: [
            ...previous.current.where((c) => c.type != type.serverName),
            ConsentModel(
              type: type.serverName,
              granted: granted,
              recordedAtUtc: DateTime.now().toUtc(),
            ),
          ],
          history: previous.history,
        ),
      ),
    );
    final result = await accountRepo.recordConsent(type, granted: granted);
    result.when(
      success: (consents) => emitIfOpen(ConsentsState.success(consents)),
      failure: (failure) =>
          emitIfOpen(ConsentsState.success(previous, failure: failure.message)),
    );
  }
}
