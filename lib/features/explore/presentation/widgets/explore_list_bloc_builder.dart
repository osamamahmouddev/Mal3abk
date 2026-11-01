import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/fade_slide_in_widget.dart';
import '../../../../core/widgets/pitch_card_widget.dart';
import '../cubit/explore_list_cubit.dart';
import '../cubit/explore_list_state.dart';
import 'explore_list_fallback_widget.dart';

class ExploreListBlocBuilder extends StatelessWidget {
  const ExploreListBlocBuilder({
    required this.favorites,
    required this.onFavoriteTap,
    required this.onSlotTap,
    super.key,
  });

  final Set<String> favorites;
  final ValueChanged<String> onFavoriteTap;
  final ValueChanged<String> onSlotTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreListCubit, ExploreListState>(
      builder: (context, state) {
        return switch (state) {
          ExploreListLoading() => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          ExploreListSuccess(:final result) =>
            result.items.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 26.h, 16.w, 16.h),
                    itemCount: result.items.length,
                    separatorBuilder: (_, _) => vSpace(12),
                    itemBuilder: (context, index) {
                      final item = result.items[index];
                      final specs = item.pitchTypes.isNotEmpty
                          ? item.pitchTypes.join(' · ')
                          : '${item.city} · ${item.area}';
                      final price = item.fromHourlyPrice != null
                          ? '${item.fromHourlyPrice!.toInt()} ${item.currency} / ساعة'
                          : '';
                      const rating = '4.8';
                      final slots = item.nextAvailableStartUtc != null
                          ? [item.nextAvailableStartUtc!]
                          : [
                              'explore.slot_8pm'.tr(context: context),
                              'explore.slot_11pm'.tr(context: context),
                            ];

                      return FadeSlideInWidget(
                        index: index,
                        child: PitchCardWidget(
                          name: item.name,
                          specs: specs,
                          pricePerHour: price,
                          rating: rating,
                          isFavorite: favorites.contains(item.venueId),
                          onFavoriteTap: () => onFavoriteTap(item.venueId),
                          availableSlots: slots,
                          onTap: () => Navigator.of(context).pushNamed(
                            AppRoutes.venueProfile,
                            arguments: item.venueId,
                          ),
                          onSlotTap: (_) => onSlotTap(item.venueId),
                        ),
                      );
                    },
                  )
                : ExploreListFallbackWidget(
                    favorites: favorites,
                    onFavoriteTap: onFavoriteTap,
                    onSlotTap: onSlotTap,
                  ),
          _ => ExploreListFallbackWidget(
            favorites: favorites,
            onFavoriteTap: onFavoriteTap,
            onSlotTap: onSlotTap,
          ),
        };
      },
    );
  }
}
