import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/price_action_footer_widget.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';
import '../../data/models/venue_availability_model.dart';
import '../cubit/pitch_booking_cubit.dart';
import '../cubit/pitch_booking_state.dart';
import 'pitch_day_selector_widget.dart';
import 'pitch_duration_selector_widget.dart';
import 'pitch_slot_legend_widget.dart';
import 'pitch_time_slot_tile_widget.dart';

class PitchAndTimeBlocBuilder extends StatelessWidget {
  const PitchAndTimeBlocBuilder({required this.venueId, super.key});

  final String venueId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PitchBookingCubit, PitchBookingState>(
      builder: (context, state) {
        return switch (state) {
          PitchBookingLoading() => const Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: CustomAppBarWidget(title: 'اختار الملعب والميعاد'),
            body: Center(child: CircularProgressIndicator.adaptive()),
          ),
          PitchBookingError(:final message) => Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: const CustomAppBarWidget(title: 'اختار الملعب والميعاد'),
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message,
                      style: AppTextStyles.font14Regular.copyWith(
                        color: AppColors.redText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    hSpace(16),
                    CustomButton(
                      text: 'إعادة المحاولة',
                      height: 44.h,
                      onTap: () => context
                          .read<PitchBookingCubit>()
                          .loadAvailability(venueId),
                    ),
                  ],
                ),
              ),
            ),
          ),
          PitchBookingLoaded() => _PitchBookingLoadedView(state: state),
          _ => const Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: CustomAppBarWidget(title: 'اختار الملعب والميعاد'),
            body: Center(child: CircularProgressIndicator.adaptive()),
          ),
        };
      },
    );
  }
}

class _PitchBookingLoadedView extends StatelessWidget {
  const _PitchBookingLoadedView({required this.state});

  final PitchBookingLoaded state;

  String _formatSlotHour(String localIso) {
    try {
      final dt = DateTime.parse(localIso);
      final hour = dt.hour;
      final minute = dt.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'م' : 'ص';
      final formattedHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$formattedHour:$minute $period'.toArabicDigits();
    } catch (_) {
      return localIso;
    }
  }

  bool _isNextDay(String localIso) {
    try {
      final dt = DateTime.parse(localIso);
      return dt.hour >= 0 && dt.hour < 5;
    } catch (_) {
      return false;
    }
  }

  String _formatPitchTitle(PitchSlotsModel pitch, int index) {
    final name = pitch.name.toArabicDigits();
    if (name.contains('لاعب') || name.contains('—')) return name;
    if (index == 0 || name.contains('1') || name.contains('١')) {
      return '$name — ٥ لاعب';
    }
    return '$name — ٧ لاعب';
  }

  String _formatPitchSubtitle(PitchSlotsModel pitch, int index) {
    double? price;
    for (final s in pitch.slots) {
      if (s.price != null) {
        price = s.price;
        break;
      }
    }
    final pVal = price != null
        ? price.toInt().toString().toArabicDigits()
        : (index == 0 ? '١٥٠' : '٢٢٠');
    return '$pVal ج.م/ساعة';
  }

  String _formatSectionTitle(int dayIndex) {
    final target = DateTime.now().add(Duration(days: dayIndex));
    final dayName = DateFormat('EEEE', 'ar').format(target);
    final dayNum = target.day.toString().toArabicDigits();
    final monthName = DateFormat('MMMM', 'ar').format(target);
    return 'المواعيد — $dayName $dayNum $monthName';
  }

  @override
  Widget build(BuildContext context) {
    final pitches = state.availability.pitches;
    final currentPitch = state.currentPitch;
    final slots = currentPitch?.slots ?? const [];
    final selectedSlot = state.selectedSlot;
    final quote = state.quote;

    final slotTimeStr = selectedSlot != null
        ? _formatSlotHour(selectedSlot.startLocal)
        : '٨:٠٠ م';
    final pitchShortName = currentPitch != null
        ? _formatPitchTitle(currentPitch, state.selectedPitchIndex)
            .split('—')
            .first
            .trim()
        : 'ملعب ١';
    final bottomCaption = '$pitchShortName · $slotTimeStr · ساعة';

    final priceVal = quote != null
        ? quote.total.toInt().toString().toArabicDigits()
        : (selectedSlot?.price != null
            ? selectedSlot!.price!.toInt().toString().toArabicDigits()
            : '١٥٠');
    final bottomPrice = '$priceVal ج.م';

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'explore.slots.title'.tr(context: context),
        subtitle: currentPitch != null
            ? '${currentPitch.name.toArabicDigits()} — مدينة نصر'
            : 'ملعب النجوم — مدينة نصر',
      ),
      bottomNavigationBar: PriceActionFooterWidget(
        caption: bottomCaption,
        price: bottomPrice,
        ctaText: 'explore.slots.continue'.tr(context: context),
        onTap: () {
          if (selectedSlot == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('من فضلك اختر ميعاد الحجز أولاً')),
            );
            return;
          }
          Navigator.of(context).pushNamed(
            AppRoutes.bookingReview,
            arguments: context.read<PitchBookingCubit>(),
          );
        },
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        children: [
          PitchDaySelectorWidget(
            selectedIndex: state.selectedDayIndex,
            onSelect: (index) =>
                context.read<PitchBookingCubit>().selectDay(index),
          ),
          hSpace(16),
          if (pitches.isNotEmpty) ...[
            Row(
              children: [
                for (var i = 0; i < pitches.length; i++) ...[
                  if (i > 0) vSpace(8),
                  Expanded(
                    child: SelectableTileWidget(
                      title: _formatPitchTitle(pitches[i], i),
                      subtitle: _formatPitchSubtitle(pitches[i], i),
                      subtitleStyle: AppTextStyles.font12Regular,
                      subtitleOpacity: 0.9,
                      boldTitle: true,
                      isSelected: state.selectedPitchIndex == i,
                      onTap: () =>
                          context.read<PitchBookingCubit>().selectPitch(i),
                      height: 64,
                      borderRadius: 14,
                    ),
                  ),
                ],
              ],
            ),
            hSpace(16),
          ],
          Text(
            _formatSectionTitle(state.selectedDayIndex),
            style: AppTextStyles.font15Bold,
          ),
          hSpace(14),
          if (state.isSlotsLoading)
            Container(
              height: 180.h,
              alignment: Alignment.center,
              child: const CircularProgressIndicator.adaptive(),
            )
          else if (slots.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Text(
                  'لا توجد مواعيد متاحة في هذا اليوم',
                  style: AppTextStyles.font14Regular,
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 8.w,
                childAspectRatio: 1.8,
              ),
              itemCount: slots.length,
              itemBuilder: (context, idx) {
                final slot = slots[idx];
                final isBooked = !slot.isAvailable;
                final isSelected = selectedSlot?.startUtc == slot.startUtc;

                return PitchTimeSlotTileWidget(
                  time: _formatSlotHour(slot.startLocal),
                  isBooked: isBooked,
                  isSelected: isSelected,
                  isNextDay: _isNextDay(slot.startLocal),
                  onTap: () =>
                      context.read<PitchBookingCubit>().selectSlot(slot),
                );
              },
            ),
          hSpace(16),
          const PitchSlotLegendWidget(),
          hSpace(20),
          Text(
            'explore.slots.duration'.tr(context: context),
            style: AppTextStyles.font15Bold,
          ),
          hSpace(12),
          const PitchDurationSelectorWidget(),
        ],
      ),
    );
  }
}
