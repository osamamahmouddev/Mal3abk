import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/utils/egyptian_phone_input_formatter.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/searchable_picker_sheet_widget.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../data/models/manual_booking_request_body.dart';
import '../cubit/manual_booking_cubit.dart';
import '../cubit/manual_booking_state.dart';
import 'manual_booking_customer_sheet_widget.dart';
import 'manual_booking_time_picker_widget.dart';

class ManualBookingFormWidget extends HookWidget {
  const ManualBookingFormWidget({
    required this.venue,
    this.initialName = '',
    this.initialPhone = '',
    super.key,
  });

  final VenueModel venue;
  final String initialName;
  final String initialPhone;

  static const _durations = [60, 90, 120];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManualBookingCubit>();
    final name = useTextEditingController(text: initialName);
    final phone = useTextEditingController(text: initialPhone);
    final price = useTextEditingController();
    final deposit = useTextEditingController();
    final notes = useTextEditingController();
    final priceEdited = useRef(false);
    String t(String key) => 'venue.manual.$key'.tr(context: context);
    useEffect(() {
      cubit.init();
      return null;
    }, const []);

    return BlocConsumer<ManualBookingCubit, ManualBookingState>(
      listenWhen: (a, b) => a.suggestedPrice != b.suggestedPrice,
      listener: (context, state) {
        final suggested = state.suggestedPrice;
        if (suggested != null && !priceEdited.value) {
          price.text = suggested.round().toString();
        }
      },
      builder: (context, state) {
        final pitches = venue.activePitches;
        final pitchIndex = pitches.indexWhere((p) => p.id == state.pitchId);
        final conflict = cubit.conflict;
        final isPast = cubit.isPast;
        String? err(String field) => state.errors[field]?.tr(context: context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VenueSectionCardWidget(
              title: t('when'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PickerTile(
                    icon: Icons.stadium_rounded,
                    label: t('pitch'),
                    value: pitchIndex < 0
                        ? t('no_active_pitches')
                        : pitches[pitchIndex].name,
                    error: err('pitch'),
                    onTap: pitches.isEmpty
                        ? null
                        : () async {
                            final i = await SearchablePickerSheetWidget.show(
                              context,
                              title: t('pitch'),
                              options: [for (final p in pitches) p.name],
                              selectedIndex: pitchIndex < 0 ? null : pitchIndex,
                              searchHint: t('search_pitch'),
                              emptyText: 'venue.shell.no_match'.tr(
                                context: context,
                              ),
                            );
                            if (i != null) cubit.setPitch(pitches[i].id);
                          },
                  ),
                  hSpace(10),
                  _PickerTile(
                    icon: Icons.calendar_today_rounded,
                    label: t('date'),
                    value: VenueFormat.day(context, state.date),
                    onTap: () async {
                      final today = CairoTime.today();
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: state.date,
                        firstDate: DateTime(today.year - 1),
                        lastDate: DateTime(today.year + 1, 12, 31),
                      );
                      if (picked != null) {
                        cubit.setDate(
                          DateTime(picked.year, picked.month, picked.day),
                        );
                      }
                    },
                  ),
                  hSpace(14),
                  ManualBookingTimePickerWidget(
                    date: state.date,
                    minutes: state.startMinutes,
                    onChanged: cubit.setStart,
                    error: err('time'),
                  ),
                  hSpace(14),
                  Text(t('duration'), style: AppTextStyles.font14SemiBold),
                  hSpace(8),
                  Wrap(
                    spacing: 8.w,
                    children: [
                      for (final d in _durations)
                        ChoiceChip(
                          label: Text(t('duration_$d')),
                          selected: state.durationMinutes == d,
                          onSelected: (_) => cubit.setDuration(d),
                          showCheckmark: false,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            hSpace(12),
            VenueSectionCardWidget(
              title: t('customer'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    controller: name,
                    labelText: t('name_label'),
                    hintText: t('name_hint'),
                    errorText: err('name'),
                    onChanged: (_) {
                      if (state.selectedCustomer != null) {
                        cubit.selectCustomer(null);
                      }
                    },
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton.icon(
                      icon: const Icon(Icons.groups_rounded, size: 18),
                      label: Text(t('registered_customer')),
                      onPressed: () async {
                        final customer =
                            await ManualBookingCustomerSheetWidget.show(
                              context,
                              cubit: cubit,
                              initialSearch: name.text,
                            );
                        if (customer == null) return;
                        name.text = customer.name;
                        if (customer.phone != null) {
                          phone.text = customer.phone!;
                        }
                        cubit.selectCustomer(customer);
                      },
                    ),
                  ),
                  CustomTextFormField(
                    controller: phone,
                    labelText: t('phone_label'),
                    hintText: '010 1234 5678',
                    keyboardType: TextInputType.phone,
                    textDirection: TextDirection.ltr,
                    inputFormatters: const [EgyptianPhoneInputFormatter()],
                    errorText: err('phone'),
                  ),
                  if (state.selectedCustomer case final c?) ...[
                    hSpace(10),
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        [
                          'venue.manual.selected_customer'.tr(
                            context: context,
                            args: [
                              c.name,
                              VenueFormat.number(context, c.totalBookings),
                            ],
                          ),
                          if (c.noShows > 0)
                            'venue.manual.customer_no_shows'.tr(
                              context: context,
                              args: [VenueFormat.number(context, c.noShows)],
                            ),
                        ].join('\n'),
                        style: AppTextStyles.font12SemiBold.copyWith(
                          color: AppColors.successText,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            hSpace(12),
            VenueSectionCardWidget(
              title: t('payment'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    controller: price,
                    labelText: t('price_label'),
                    hintText: '0',
                    keyboardType: TextInputType.number,
                    errorText: err('price'),
                    onChanged: (_) => priceEdited.value = true,
                  ),
                  hSpace(12),
                  Text(t('status'), style: AppTextStyles.font14SemiBold),
                  hSpace(8),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      for (final p in ManualPaymentStatus.values)
                        ChoiceChip(
                          label: Text(t('payment_${p.name}')),
                          selected: state.payment == p,
                          onSelected:
                              isPast && p == ManualPaymentStatus.unconfirmed
                              ? null
                              : (_) => cubit.setPayment(p),
                          showCheckmark: false,
                        ),
                    ],
                  ),
                  hSpace(6),
                  Text(
                    t('payment_${state.payment.name}_hint'),
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (isPast) ...[
                    hSpace(4),
                    Text(
                      t('past_note'),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.goldText,
                      ),
                    ),
                  ],
                  if (err('payment') case final e?) ...[
                    hSpace(4),
                    Text(
                      e,
                      style: AppTextStyles.font12SemiBold.copyWith(
                        color: AppColors.redText,
                      ),
                    ),
                  ],
                  if (state.payment == ManualPaymentStatus.deposit ||
                      state.payment == ManualPaymentStatus.awaiting) ...[
                    hSpace(12),
                    CustomTextFormField(
                      controller: deposit,
                      labelText: state.payment == ManualPaymentStatus.deposit
                          ? t('deposit_paid_label')
                          : t('deposit_required_label'),
                      hintText: '0',
                      keyboardType: TextInputType.number,
                      errorText: err('deposit'),
                    ),
                  ],
                  hSpace(12),
                  CustomTextFormField(
                    controller: notes,
                    labelText: t('notes_label'),
                    hintText: t('notes_hint'),
                    errorText: err('notes'),
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
            hSpace(12),
            Text(
              t('race_note'),
              style: AppTextStyles.font12Regular.copyWith(
                color: AppColors.textMuted,
              ),
            ),
            if (conflict != null) ...[
              hSpace(12),
              AlertBannerWidget(
                type: AlertBannerType.warning,
                message: conflict.isBlocked
                    ? 'venue.manual.conflict_blocked'.tr(
                        context: context,
                        args: [
                          (conflict.reason?.isNotEmpty ?? false)
                              ? conflict.reason!
                              : t('blocked'),
                        ],
                      )
                    : 'venue.manual.conflict_booking'.tr(
                        context: context,
                        args: [
                          (conflict.customerName?.isNotEmpty ?? false)
                              ? conflict.customerName!
                              : t('existing_booking'),
                          '${VenueFormat.time(context, conflict.startUtc)} – ${VenueFormat.time(context, conflict.endUtc)}',
                        ],
                      ),
              ),
            ],
            if (state.serverError case final e?) ...[
              hSpace(12),
              AlertBannerWidget(
                type: AlertBannerType.error,
                message: e.tr(context: context),
              ),
            ],
            hSpace(16),
            CustomButton(
              text: conflict != null
                  ? t('submit_unavailable')
                  : state.payment == ManualPaymentStatus.awaiting ||
                        state.payment == ManualPaymentStatus.unconfirmed
                  ? t('submit_hold')
                  : t('submit'),
              height: 54.h,
              borderRadius: 16,
              enabled: conflict == null,
              isLoading: state.submitting,
              textStyle: AppTextStyles.font16Bold.copyWith(
                color: AppColors.white,
              ),
              onTap: () {
                FocusScope.of(context).unfocus();
                cubit.submit(
                  customerName: name.text,
                  customerPhone: phone.text,
                  price: price.text,
                  deposit: deposit.text,
                  notes: notes.text,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _PickerTile extends StatelessWidget {
  const _PickerTile({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
    this.error,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.font14SemiBold),
        hSpace(6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: error != null
                    ? AppColors.brandRed
                    : AppColors.borderInput,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18.r, color: AppColors.textSecondary),
                SizedBox(width: 10.w),
                Expanded(child: Text(value, style: AppTextStyles.font14Medium)),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textMuted,
                  size: 20.r,
                ),
              ],
            ),
          ),
        ),
        if (error != null) ...[
          hSpace(4),
          Text(
            error!,
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.redText,
            ),
          ),
        ],
      ],
    );
  }
}
