import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/egyptian_phone_input_formatter.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/sheet_drag_handle_widget.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../data/models/manual_booking_request_body.dart';
import '../cubit/venue_calendar_cubit.dart';
import '../cubit/venue_calendar_state.dart';

/// Bottom bar while hours are picked: book them all, or free the picked
/// manual bookings and blocked periods.
class CalendarBulkBarWidget extends StatelessWidget {
  const CalendarBulkBarWidget({
    required this.state,
    required this.canUnblock,
    super.key,
  });

  final VenueCalendarState state;
  final bool canUnblock;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueCalendarCubit>();
    String t(String key) => 'venue.calendar.bulk.$key'.tr(context: context);
    final hours = state.pickedHours.length;
    final taken = state.pickedTaken.length;
    final blockedPicked = state.pickedTaken.values.any((b) => b);
    final canRelease = taken > 0 && (!blockedPicked || canUnblock);
    final summary = hours == 0 && taken == 0
        ? t('hint')
        : [
            if (hours > 0)
              'venue.calendar.bulk.free_count'.tr(
                context: context,
                args: [VenueFormat.number(context, hours)],
              ),
            if (taken > 0)
              'venue.calendar.bulk.taken_count'.tr(
                context: context,
                args: [VenueFormat.number(context, taken)],
              ),
          ].join(' · ');

    Future<void> release() async {
      final result = await cubit.releasePicked();
      if (!context.mounted) return;
      result.when(
        success: (r) => AppTopSnackBar.showSuccess(
          context,
          'venue.calendar.bulk.released'.tr(
                context: context,
                args: [VenueFormat.number(context, r.succeeded)],
              ) +
              (r.failed > 0
                  ? 'venue.calendar.bulk.not_released'.tr(
                      context: context,
                      args: [VenueFormat.number(context, r.failed)],
                    )
                  : ''),
        ),
        failure: (f) =>
            AppTopSnackBar.showError(context, f.message.tr(context: context)),
      );
    }

    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
          boxShadow: [BoxShadow(color: AppColors.navyShadow, blurRadius: 12)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(summary, style: AppTextStyles.font13SemiBold),
            hSpace(10),
            Row(
              children: [
                if (hours > 0)
                  Expanded(
                    child: CustomButton(
                      text: t('book'),
                      height: 44.h,
                      borderRadius: 12,
                      isLoading: state.busy,
                      textStyle: AppTextStyles.font14Bold.copyWith(
                        color: AppColors.white,
                      ),
                      onTap: () => _BulkBookSheet.show(context, cubit),
                    ),
                  ),
                if (hours > 0 && taken > 0) SizedBox(width: 8.w),
                if (taken > 0)
                  Expanded(
                    child: CustomButton(
                      text: t('release'),
                      type: CustomButtonType.outline,
                      height: 44.h,
                      borderRadius: 12,
                      enabled: canRelease,
                      isLoading: state.busy,
                      onTap: release,
                    ),
                  ),
                SizedBox(width: 8.w),
                IconButton(
                  tooltip: 'common.cancel'.tr(context: context),
                  onPressed: () => cubit.clearPicks(stopPicking: true),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BulkBookSheet extends HookWidget {
  const _BulkBookSheet({required this.cubit});

  final VenueCalendarCubit cubit;

  static Future<void> show(BuildContext context, VenueCalendarCubit cubit) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Colors.transparent,
        builder: (_) => _BulkBookSheet(cubit: cubit),
      );

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.calendar.bulk.$key'.tr(context: context);
    final state = cubit.state;
    final hasPast = state.pickedHours.values.any(
      (h) => !h.start.isAfter(DateTime.now().toUtc()),
    );
    final tentative = useState(false);
    final name = useTextEditingController();
    final phone = useTextEditingController();
    final price = useTextEditingController();
    final busy = useState(false);

    Future<void> submit() async {
      final status = tentative.value && !hasPast
          ? ManualPaymentStatus.unconfirmed
          : ManualPaymentStatus.full;
      busy.value = true;
      final result = await cubit.bookPicked(
        status: status,
        customerName: name.text.trim().isEmpty ? null : name.text.trim(),
        customerPhone: phone.text.trim().isEmpty ? null : phone.text.trim(),
        pricePerHour: double.tryParse(price.text.trim()),
      );
      if (!context.mounted) return;
      busy.value = false;
      result.when(
        success: (r) {
          final why = r.failed == 0
              ? ''
              : switch (r.firstErrorCode) {
                  'Booking.PriceUnavailable' => t('why_price'),
                  'Booking.UnconfirmedInThePast' => t('why_past'),
                  _ =>
                    r.firstError != null
                        ? ' (${r.firstError})'
                        : t('why_taken'),
                };
          Navigator.of(context).pop();
          AppTopSnackBar.showSuccess(
            context,
            '${(status == ManualPaymentStatus.unconfirmed ? 'venue.calendar.bulk.booked_tentative' : 'venue.calendar.bulk.booked').tr(context: context, args: [VenueFormat.number(context, r.succeeded)])}${r.failed > 0 ? 'venue.calendar.bulk.not_booked'.tr(context: context, args: [VenueFormat.number(context, r.failed)]) : ''}$why',
          );
        },
        failure: (f) =>
            AppTopSnackBar.showError(context, f.message.tr(context: context)),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: SheetDragHandleWidget()),
              hSpace(12),
              Text(
                'venue.calendar.bulk.sheet_title'.tr(
                  context: context,
                  args: [VenueFormat.number(context, state.pickedHours.length)],
                ),
                style: AppTextStyles.font18Bold,
              ),
              hSpace(14),
              SegmentedButton<bool>(
                segments: [
                  ButtonSegment(value: false, label: Text(t('confirmed'))),
                  ButtonSegment(
                    value: true,
                    label: Text(t('tentative')),
                    enabled: !hasPast,
                  ),
                ],
                selected: {tentative.value && !hasPast},
                showSelectedIcon: false,
                onSelectionChanged: (s) => tentative.value = s.first,
                style: SegmentedButton.styleFrom(
                  selectedBackgroundColor: AppColors.brandNavy,
                  selectedForegroundColor: AppColors.white,
                ),
              ),
              if (hasPast) ...[
                hSpace(6),
                Text(
                  t('past_note'),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.goldText,
                  ),
                ),
              ],
              hSpace(14),
              CustomTextFormField(
                controller: name,
                labelText: t('name_label'),
                hintText: t('name_hint'),
              ),
              hSpace(12),
              CustomTextFormField(
                controller: phone,
                labelText: t('phone_label'),
                hintText: '010 1234 5678',
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr,
                inputFormatters: const [EgyptianPhoneInputFormatter()],
              ),
              hSpace(12),
              CustomTextFormField(
                controller: price,
                labelText: t('price_label'),
                hintText: t('price_hint'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              hSpace(18),
              CustomButton(
                text: t('book_action'),
                height: 50.h,
                borderRadius: 14,
                isLoading: busy.value,
                textStyle: AppTextStyles.font15Bold.copyWith(
                  color: AppColors.white,
                ),
                onTap: submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
