import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/price_rule_model.dart';
import '../../domain/repos/venue_pricing_repo.dart';

part 'venue_pricing_cubit.freezed.dart';

@freezed
abstract class VenuePricingState with _$VenuePricingState {
  const factory VenuePricingState({
    @Default([]) List<PriceRuleModel> rules,
    @Default(true) bool loading,
    @Default(false) bool saving,
    String? error,

    /// Show only rules for this pitch (and the ones for every pitch).
    String? pitchFilter,
    PriceQuoteModel? quote,
    String? quoteError,
    @Default(false) bool quoting,
  }) = _VenuePricingState;
}

extension VenuePricingStateX on VenuePricingState {
  List<PriceRuleModel> get visible => [
    for (final r in rules)
      if (pitchFilter == null || r.pitchId == null || r.pitchId == pitchFilter)
        r,
  ];

  List<PriceRuleModel> get discounts =>
      visible.where((r) => r.kind == 'Discount').toList();

  bool get hasBase => rules.any((r) => r.kind == 'Base' && r.isActive);
}

/// The web "prices" page: base, peak, weekend, holiday and special-date
/// rules, temporary discounts, and trying a price.
class VenuePricingCubit extends Cubit<VenuePricingState>
    with SafeEmitCubitMixin<VenuePricingState> {
  VenuePricingCubit({required this.venuePricingRepo, required this.venueId})
    : super(const VenuePricingState());

  final VenuePricingRepo venuePricingRepo;
  final String venueId;

  Future<void> load() async {
    final result = await venuePricingRepo.getRules(venueId);
    result.when(
      success: (r) =>
          emitIfOpen(state.copyWith(rules: r, loading: false, error: null)),
      failure: (f) =>
          emitIfOpen(state.copyWith(loading: false, error: f.message)),
    );
  }

  void setPitchFilter(String? pitchId) =>
      emitIfOpen(state.copyWith(pitchFilter: pitchId));

  /// Returns the failure key, or null once saved.
  Future<String?> save(PriceRuleDraft draft) async {
    final problem = draft.error;
    if (problem != null) return problem;
    emitIfOpen(state.copyWith(saving: true));
    final result = await venuePricingRepo.saveRule(venueId, draft);
    emitIfOpen(state.copyWith(saving: false));
    return result.when(
      success: (_) {
        load();
        return null;
      },
      failure: (f) => f.message,
    );
  }

  Future<String?> toggle(PriceRuleModel rule) =>
      save(PriceRuleDraft.fromRule(rule).copyWith(isActive: !rule.isActive));

  Future<String?> delete(PriceRuleModel rule) async {
    emitIfOpen(state.copyWith(saving: true));
    final result = await venuePricingRepo.deleteRule(venueId, rule.id);
    emitIfOpen(state.copyWith(saving: false));
    return result.when(
      success: (_) {
        load();
        return null;
      },
      failure: (f) => f.message,
    );
  }

  Future<void> preview({
    required String pitchId,
    required DateTime startUtc,
    required DateTime endUtc,
  }) async {
    emitIfOpen(state.copyWith(quoting: true, quoteError: null));
    final result = await venuePricingRepo.preview(
      venueId,
      pitchId: pitchId,
      startUtc: startUtc,
      endUtc: endUtc,
    );
    result.when(
      success: (q) => emitIfOpen(state.copyWith(quote: q, quoting: false)),
      failure: (f) => emitIfOpen(
        state.copyWith(
          quote: null,
          quoting: false,
          quoteError: f.code == 'Pricing.NoBasePrice'
              ? 'venue.pricing.preview.no_base'
              : f.message,
        ),
      ),
    );
  }
}
