import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
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

                      final typeLabels = item.pitchTypes.map((t) {
                        final lower = t.toLowerCase();
                        if (lower.contains('5')) return '٥ لاعب';
                        if (lower.contains('7')) return '٧ لاعب';
                        if (lower.contains('10')) return '١٠ لاعب';
                        if (lower.contains('11')) return '١١ لاعب';
                        return t;
                      }).toList();

                      final specsParts = <String>[];
                      if (typeLabels.isNotEmpty) {
                        specsParts.add(typeLabels.join(' · '));
                      } else if (item.area.isNotEmpty) {
                        specsParts.add(item.area);
                      }

                      if (item.distanceKm != null) {
                        specsParts.add(
                          '${item.distanceKm!.toStringAsFixed(1).toArabicDigits()} كم',
                        );
                      }

                      final specs = specsParts.isNotEmpty
                          ? specsParts.join(' · ')
                          : '${item.city} · ${item.area}';

                      final price = item.fromHourlyPrice != null
                          ? '${item.fromHourlyPrice!.toInt().toString().toArabicDigits()} ج.م'
                          : '١٥٠ ج.م';

                      const rating = '٤٫٨';
                      final slots = [
                        'explore.slot_8pm'.tr(context: context),
                        'explore.slot_11pm'.tr(context: context),
                        'explore.slot_12am'.tr(context: context),
                      ];

                      return FadeSlideInWidget(
                        index: index,
                        child: PitchCardWidget(
                          name: item.name,
                          specs: specs,
                          pricePerHour: price,
                          rating: rating,
                          imageUrl: item.coverPhotoUrl,
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
