import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/booking_policy_model.dart';
import '../../domain/repos/venue_policies_repo.dart';

part 'venue_policies_cubit.freezed.dart';

@freezed
abstract class VenuePoliciesState with _$VenuePoliciesState {
  const factory VenuePoliciesState({
    @Default(BookingPolicyModel(BookingPolicyModel.defaults))
    BookingPolicyModel policy,
    @Default(true) bool loading,
    @Default(false) bool saving,
    @Default(false) bool dirty,
    String? error,
  }) = _VenuePoliciesState;
}

/// The venue's booking policy: proof and review windows, cancellation and
/// refund, no-show, late arrival, rescheduling and extra terms.
class VenuePoliciesCubit extends Cubit<VenuePoliciesState>
    with SafeEmitCubitMixin<VenuePoliciesState> {
  VenuePoliciesCubit({required this.venuePoliciesRepo, required this.venueId})
    : super(const VenuePoliciesState());

  final VenuePoliciesRepo venuePoliciesRepo;
  final String venueId;

  Future<void> load() async {
    final result = await venuePoliciesRepo.getPolicy(venueId);
    result.when(
      success: (p) => emitIfOpen(
        state.copyWith(policy: p, loading: false, dirty: false, error: null),
      ),
      failure: (f) =>
          emitIfOpen(state.copyWith(loading: false, error: f.message)),
    );
  }

  void choose(Map<String, Object?> patch) => emitIfOpen(
    state.copyWith(policy: state.policy.patch(patch), dirty: true),
  );

  void setTerms(String text) =>
      choose({'terms': text.trim().isEmpty ? null : text});

  /// Returns the failure key, or null once saved.
  Future<String?> save() async {
    emitIfOpen(state.copyWith(saving: true));
    final result = await venuePoliciesRepo.savePolicy(venueId, state.policy);
    emitIfOpen(state.copyWith(saving: false));
    return result.when(
      success: (_) {
        load();
        return null;
      },
      failure: (f) => f.message,
    );
  }
}
