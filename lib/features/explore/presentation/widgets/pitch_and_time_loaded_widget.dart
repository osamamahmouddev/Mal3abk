import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/widgets/fade_slide_in_widget.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/empty_note_box_widget.dart';
import '../../../../core/widgets/price_action_footer_widget.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../data/models/venue_availability_model.dart';
import '../cubit/pitch_booking_cubit.dart';
import '../cubit/pitch_booking_state.dart';
import 'pitch_day_selector_widget.dart';
import 'pitch_slot_legend_widget.dart';
import 'pitch_time_slot_tile_widget.dart';

/// Pitch tabs, day strip and the slot grid for one venue, all in Cairo time.
class PitchAndTimeLoadedWidget extends StatelessWidget {
  const PitchAndTimeLoadedWidget({
    required this.state,
    required this.venueName,
    super.key,
  });

  final PitchBookingLoaded state;
  final String venueName;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final cubit = context.read<PitchBookingCubit>();
    final pitches = state.availability.pitches;
    final pitch = state.currentPitch;
    final slots = pitch?.slots ?? const <SlotModel>[];
    final visibleSlots = state.visibleSlots;
    final selected = state.selectedSlot;
    final quote = state.quote;
    String egp(double value) => 'common.price_egp'.tr(
      context: context,
      args: [value.round().toLocalizedDigits(lang)],
    );
    String t(String key, [List<String>? args]) =>
        'explore.slots.$key'.tr(context: context, args: args);

    final day = CairoTime.today().add(Duration(days: state.selectedDayIndex));
    double? fromPrice(PitchSlotsModel p) {
      final prices = [
        for (final s in p.slots)
          if (s.price != null) s.price!,
      ];
      return prices.isEmpty ? null : prices.reduce((a, b) => a < b ? a : b);
    }

    final price = quote?.total ?? selected?.price;

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(title: t('title'), subtitle: venueName),
      bottomNavigationBar: PriceActionFooterWidget(
        caption: selected == null || pitch == null
            ? t('pick_slot')
            : [
                pitch.name,
                CairoTime.time(CairoTime.parseUtc(selected.startUtc), lang),
                'matches.minutes'.tr(
                  context: context,
                  args: [pitch.slotMinutes.toLocalizedDigits(lang)],
                ),
              ].join(' · '),
        price: price == null ? '—' : egp(price),
        ctaText: t('continue'),
        onTap: () {
          if (selected == null || state.selectedSlotTaken) {
            AppTopSnackBar.showError(
              context,
              state.selectedSlotTaken ? t('taken_live') : t('pick_slot'),
            );
            return;
          }
          HapticFeedback.lightImpact();
          Navigator.of(
            context,
          ).pushNamed(AppRoutes.bookingReview, arguments: cubit);
        },
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        children: [
          PitchDaySelectorWidget(
            selectedIndex: state.selectedDayIndex,
            onSelect: cubit.selectDay,
          ),
          hSpace(16),
          if (pitches.length > 1) ...[
            SizedBox(
              height: 76.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: pitches.length,
                separatorBuilder: (_, _) => vSpace(8),
                itemBuilder: (context, i) {
                  final from = fromPrice(pitches[i]);
                  return SizedBox(
                    width: 150.w,
                    child: SelectableTileWidget(
                      title: pitches[i].name,
                      subtitle: from == null ? null : t('from', [egp(from)]),
                      subtitleStyle: AppTextStyles.font12Regular,
                      boldTitle: true,
                      isSelected: state.selectedPitchIndex == i,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        cubit.selectPitch(i);
                      },
                      height: 76,
                      horizontalPadding: 10,
                      borderRadius: 14,
                    ),
                  );
                },
              ),
            ),
            hSpace(16),
          ],
          AnimatedSwitcher(
            duration: AppAnimations.duration(context, AppAnimations.base),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            layoutBuilder: (current, previous) => Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [...previous, ?current],
            ),
            child: Text(
              t('section', [
                CairoTime.shortDate(CairoTime.toUtc(day, 12), lang),
              ]),
              key: ValueKey(state.selectedDayIndex),
              style: AppTextStyles.font15Bold,
            ),
          ),
          hSpace(14),
          AnimatedSwitcher(
            duration: AppAnimations.duration(context, AppAnimations.slow),
            switchInCurve: AppAnimations.standard,
            switchOutCurve: AppAnimations.exit,
            layoutBuilder: (current, previous) => Stack(
              alignment: Alignment.topCenter,
              children: [...previous, ?current],
            ),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.97, end: 1).animate(animation),
                child: child,
              ),
            ),
            child: KeyedSubtree(
              key: ValueKey(
                '${state.selectedDayIndex}-${state.selectedPitchIndex}-'
                '${state.slotFilter}-${state.isSlotsLoading}',
              ),
              child: () {
                if (state.isSlotsLoading) {
                  return const ShimmerListSkeletonWidget(
                    itemHeight: 52,
                    itemCount: 3,
                    padding: EdgeInsets.zero,
                  );
                }
                if (slots.isEmpty) {
                  return EmptyNoteBoxWidget(text: t('no_slots'));
                }
                if (visibleSlots.isEmpty) {
                  return EmptyNoteBoxWidget(text: t('no_filtered_slots'));
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 8.w,
                    childAspectRatio: 1.8,
                  ),
                  itemCount: visibleSlots.length,
                  itemBuilder: (context, i) {
                    final slot = visibleSlots[i];
                    final start = CairoTime.fromUtc(
                      CairoTime.parseUtc(slot.startUtc),
                    );
                    return FadeSlideInWidget(
                      // A wave across the grid: row plus column.
                      index: i ~/ 3 + i % 3,
                      child: PitchTimeSlotTileWidget(
                        // One state per slot of this pitch: a tile only
                        // animates when its own slot changes, never when
                        // the day, pitch or filter shows another slot.
                        key: ValueKey('${pitch?.pitchId}|${slot.startUtc}'),
                        time: CairoTime.time(
                          CairoTime.parseUtc(slot.startUtc),
                          lang,
                        ),
                        isBooked: !slot.isAvailable,
                        isSelected: selected?.startUtc == slot.startUtc,
                        isNextDay: DateTime(
                          start.year,
                          start.month,
                          start.day,
                        ).isAfter(day),
                        onTap: () {
                          HapticFeedback.selectionClick();
                          cubit.selectSlot(slot);
                        },
                      ),
                    );
                  },
                );
              }(),
            ),
          ),
          hSpace(16),
          PitchSlotLegendWidget(
            activeFilter: state.slotFilter,
            onSelect: cubit.toggleSlotFilter,
          ),
        ],
      ),
    );
  }
}
