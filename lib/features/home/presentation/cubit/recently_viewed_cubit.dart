import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../../explore/data/models/explore_venue_card_model.dart';
import '../../../explore/domain/repos/explore_repo.dart';

/// Venues the player opened lately; empty on failure so home just hides it.
class RecentlyViewedCubit extends Cubit<List<ExploreVenueCardModel>>
    with SafeEmitCubitMixin<List<ExploreVenueCardModel>> {
  RecentlyViewedCubit({required this.exploreRepo}) : super(const []);

  final ExploreRepo exploreRepo;

  Future<void> load() async {
    final result = await exploreRepo.getRecentlyViewed();
    result.maybeWhen(success: emitIfOpen, orElse: () {});
  }

  Future<void> clear() async {
    final before = state;
    emitIfOpen(const []);
    final result = await exploreRepo.clearRecentlyViewed();
    if (result is ApiFailure) emitIfOpen(before);
  }
}
