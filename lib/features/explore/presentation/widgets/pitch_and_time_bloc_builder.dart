import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/price_action_footer_widget.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';
import '../cubit/pitch_booking_cubit.dart';
import '../cubit/pitch_booking_state.dart';
import '../../data/models/venue_availability_model.dart';
import 'pitch_day_selector_widget.dart';
import 'pitch_slot_legend_widget.dart';

class PitchAndTimeBlocBuilder extends StatelessWidget {
  const PitchAndTimeBlocBuilder({required this.venueId, super.key});

  final String venueId;

  String _formatSlotTime(String localIso) {
    try {
      final dt = DateTime.parse(localIso);
      final hour = dt.hour;
      final minute = dt.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'م' : 'ص';
      final formattedHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$formattedHour:$minute $period';
    } catch (_) {
      return localIso;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PitchBookingCubit, PitchBookingState>(
      builder: (context, state) {
        return switch (state) {
          PitchBookingLoading() => const Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: CustomAppBarWidget(title: 'المواعيد والملاعب'),
            body: Center(child: CircularProgressIndicator.adaptive()),
          ),
          PitchBookingError(:final message) => Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: const CustomAppBarWidget(title: 'المواعيد والملاعب'),
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
          PitchBookingLoaded() => _PitchBookingLoadedView(
            state: state,
            formatTime: _formatSlotTime,
          ),
          _ => const Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: CustomAppBarWidget(title: 'المواعيد والملاعب'),
            body: Center(child: CircularProgressIndicator.adaptive()),
          ),
        };
      },
    );
  }
}

class _PitchBookingLoadedView extends StatelessWidget {
  const _PitchBookingLoadedView({
    required this.state,
    required this.formatTime,
  });

  final PitchBookingLoaded state;
  final String Function(String) formatTime;

  @override
  Widget build(BuildContext context) {
    final pitches = state.availability.pitches;
    final currentPitch = state.currentPitch;
    final slots = currentPitch?.slots ?? const [];
    final selectedSlot = state.selectedSlot;
    final quote = state.quote;

    final totalPrice = quote != null
        ? '${quote.total.toInt()} ${state.availability.currency}'
        : (selectedSlot?.price != null
              ? '${selectedSlot!.price!.toInt()} ${state.availability.currency}'
              : 'explore.sample1_price'.tr(context: context));

    final depositHint = quote != null
        ? 'العربون: ${quote.deposit.toInt()} ${state.availability.currency}'
        : 'اختر ميعادك المناسب';

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'explore.slots.title'.tr(context: context),
        subtitle:
            currentPitch?.name ?? 'explore.venue.name'.tr(context: context),
      ),
      bottomNavigationBar: PriceActionFooterWidget(
        caption: depositHint,
        price: totalPrice,
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
                      title: pitches[i].name,
                      subtitle: '${pitches[i].slotMinutes} دقيقة',
                      subtitleStyle: AppTextStyles.font12Regular,
                      subtitleOpacity: 0.85,
                      boldTitle: true,
                      isSelected: state.selectedPitchIndex == i,
                      onTap: () =>
                          context.read<PitchBookingCubit>().selectPitch(i),
                      height: 58,
                      borderRadius: 12,
                    ),
                  ),
                ],
              ],
            ),
            hSpace(16),
          ],
          Text(
            'explore.slots.section'.tr(context: context),
            style: AppTextStyles.font15Bold,
          ),
          hSpace(14),
          if (slots.isEmpty)
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
            Wrap(
              spacing: 8.w,
              runSpacing: 10.h,
              children: [
                for (final slot in slots) ...[
                  _SlotChipWidget(
                    slot: slot,
                    isSelected: selectedSlot?.startUtc == slot.startUtc,
                    label:
                        '${formatTime(slot.startLocal)} - ${formatTime(slot.endLocal)}',
                    onTap: slot.isAvailable
                        ? () =>
                              context.read<PitchBookingCubit>().selectSlot(slot)
                        : null,
                  ),
                ],
              ],
            ),
          hSpace(16),
          const PitchSlotLegendWidget(),
          if (state.isQuoting) ...[
            hSpace(16),
            const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator.adaptive(strokeWidth: 2),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SlotChipWidget extends StatelessWidget {
  const _SlotChipWidget({
    required this.slot,
    required this.isSelected,
    required this.label,
    this.onTap,
  });

  final SlotModel slot;
  final bool isSelected;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isAvailable = slot.isAvailable;
    final isHeld = slot.state == 1;
    final isBooked = slot.state == 2;

    Color bg;
    Color border;
    Color text;

    if (isSelected) {
      bg = AppColors.brandRed;
      border = AppColors.brandRed;
      text = AppColors.white;
    } else if (isAvailable) {
      bg = AppColors.white;
      border = AppColors.border;
      text = AppColors.textPrimary;
    } else if (isHeld || isBooked) {
      bg = AppColors.lightGrayBackground;
      border = AppColors.border;
      text = AppColors.mapLabel;
    } else {
      bg = AppColors.lightGrayBackground;
      border = AppColors.border;
      text = AppColors.mapLabel;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: border),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.font13SemiBold.copyWith(
                color: text,
                decoration: (!isAvailable && !isSelected)
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            if (!isAvailable && !isSelected) ...[
              hSpace(2),
              Text(
                isHeld ? 'قيد الدفع' : (isBooked ? 'محجوز' : 'غير متاح'),
                style: AppTextStyles.font11Regular.copyWith(
                  color: AppColors.redText,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
