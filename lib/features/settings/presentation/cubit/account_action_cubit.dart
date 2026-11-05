import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../domain/repos/account_repo.dart';
import '../../domain/use_cases/delete_account_use_case.dart';
import 'account_action.dart';
import 'account_action_state.dart';

class AccountActionCubit extends Cubit<AccountActionState>
    with SafeEmitCubitMixin<AccountActionState> {
  AccountActionCubit({
    required this.accountRepo,
    required this.deleteAccountUseCase,
  }) : super(const AccountActionState.initial());

  static const Set<String> supportedLanguages = {'ar', 'en'};

  final AccountRepo accountRepo;
  final DeleteAccountUseCase deleteAccountUseCase;

  bool get _busy => state is AccountActionLoading;

  /// Saves the language on the account so server-rendered texts follow it.
  Future<void> changeLanguage(String languageCode) async {
    if (_busy || !supportedLanguages.contains(languageCode)) return;
    emitIfOpen(const AccountActionState.loading(AccountAction.changeLanguage));
    final result = await accountRepo.setLanguage(languageCode);
    result.when(
      success: (_) =>
          emitIfOpen(AccountActionState.languageChanged(languageCode)),
      failure: (failure) =>
          emitIfOpen(AccountActionState.error(failure.message)),
    );
  }

  Future<void> exportData({required String stepUpToken}) async {
    if (_busy) return;
    emitIfOpen(const AccountActionState.loading(AccountAction.exportData));
    final result = await accountRepo.exportData(stepUpToken: stepUpToken);
    result.when(
      success: (data) => emitIfOpen(AccountActionState.exported(data)),
      failure: (failure) =>
          emitIfOpen(AccountActionState.error(failure.message)),
    );
  }

  Future<void> deleteAccount({required String stepUpToken}) async {
    if (_busy) return;
    emitIfOpen(const AccountActionState.loading(AccountAction.deleteAccount));
    final result = await deleteAccountUseCase(stepUpToken: stepUpToken);
    result.when(
      success: (_) => emitIfOpen(const AccountActionState.deleted()),
      failure: (failure) =>
          emitIfOpen(AccountActionState.error(failure.message)),
    );
  }
}
