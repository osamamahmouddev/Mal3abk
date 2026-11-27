import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/sponsored_item_model.dart';
import '../../domain/repos/explore_repo.dart';

/// Promoted venues for the top of explore; empty on failure so the strip just hides.
class FeaturedVenuesCubit extends Cubit<List<SponsoredItemModel>>
    with SafeEmitCubitMixin<List<SponsoredItemModel>> {
  FeaturedVenuesCubit({required this.exploreRepo}) : super(const []);

  final ExploreRepo exploreRepo;

  Future<void> load() async {
    final result = await exploreRepo.getFeaturedVenues();
    result.maybeWhen(success: emitIfOpen, orElse: () {});
  }
}
