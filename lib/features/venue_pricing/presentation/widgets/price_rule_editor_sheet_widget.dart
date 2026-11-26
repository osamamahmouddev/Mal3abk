import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/sheet_drag_handle_widget.dart';
import '../../../venue_setup/data/models/venue_setup_form.dart';
import '../../../venue_setup/presentation/widgets/week_hours_editor_widget.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../data/models/price_rule_model.dart';
import '../cubit/venue_pricing_cubit.dart';
import '../pricing_format.dart';

/// Adds or edits a price rule or a temporary discount. Pops true once saved.
class PriceRuleEditorSheetWidget extends HookWidget {
  const PriceRuleEditorSheetWidget({
    required this.venue,
    required this.initial,
    super.key,
  });

  final VenueModel venue;
  final PriceRuleDraft initial;

  static Future<bool?> show(
    BuildContext context, {
    required VenuePricingCubit cubit,
    required VenueModel venue,
    required PriceRuleDraft draft,
  }) => showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: PriceRuleEditorSheetWidget(venue: venue, initial: draft),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenuePricingCubit>();
    final draft = useState(initial);
    final name = useTextEditingController(text: initial.name);
    final value = useTextEditingController(text: initial.value);
    final minDuration = useTextEditingController(
      text: initial.minDurationMinutes,
    );
    final error = useState<String?>(null);
    final d = draft.value;
    String t(String key) => 'venue.pricing.editor.$key'.tr(context: context);
    final today = CairoTime.today();

    PriceRuleDraft current() => draft.value.copyWith(
      name: name.text,
      value: value.text,
      minDurationMinutes: minDuration.text.trim(),
    );

    Future<void> pickDate(bool start) async {
      final existing = start ? d.startDate : d.endDate;
      final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.tryParse(existing) ?? today,
        firstDate: DateTime(today.year - 1),
        lastDate: DateTime(today.year + 3, 12, 31),
      );
      if (picked == null) return;
      final text = VenueFormat.apiDate(picked);
      draft.value = start
          ? draft.value.copyWith(startDate: text)
          : draft.value.copyWith(endDate: text);
    }

    void quickRange(int? days) => draft.value = draft.value.copyWith(
      startDate: days == null ? '' : VenueFormat.apiDate(today),
      endDate: days == null
          ? ''
          : VenueFormat.apiDate(today.add(Duration(days: days))),
    );

    Widget timeField(String label, String v, ValueChanged<String> onChanged) =>
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.font12SemiBold),
              Row(
                children: [
                  Expanded(
                    child: v.isEmpty
                        ? TextButton(
                            onPressed: () => onChanged('18:00'),
                            child: Text(t('set_time')),
                          )
                        : HalfHourTimeDropdownWidget(
                            value: v,
                            onChanged: onChanged,
                          ),
                  ),
                  if (v.isNotEmpty)
                    IconButton(
                      onPressed: () => onChanged(''),
                      icon: const Icon(Icons.close_rounded, size: 18),
                    ),
                ],
              ),
            ],
          ),
        );

    final pitchIndex = venue.pitches.indexWhere((p) => p.id == d.pitchId);
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
                d.isDiscount
                    ? (d.id == null ? t('new_discount') : t('edit_discount'))
                    : (d.id == null ? t('new_rule') : t('edit_rule')),
                style: AppTextStyles.font18Bold,
              ),
              if (d.isDiscount) ...[
                hSpace(4),
                Text(
                  t('discount_intro'),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
              hSpace(12),
              if (d.id == null && !d.isDiscount) ...[
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: [
                    for (final k in PriceRuleDraft.kinds.where(
                      (k) => k != 'Discount',
                    ))
                      ChoiceChip(
                        label: Text(PricingFormat.kindLabel(context, k)),
                        selected: d.kind == k,
                        showCheckmark: false,
                        onSelected: (_) {
                          final fresh = PriceRuleDraft.empty(
                            k,
                            PricingFormat.kindLabel(context, k),
                          );
                          draft.value = fresh.copyWith(
                            pitchId: () => d.pitchId,
                          );
                          name.text = fresh.name;
                        },
                      ),
                  ],
                ),
                hSpace(4),
                Text(
                  'venue.pricing.kind_hint.${d.kind}'.tr(context: context),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                hSpace(12),
              ],
              if (PriceRuleDraft.allowed[d.kind]!.length > 1) ...[
                Text(t('adjustment'), style: AppTextStyles.font13SemiBold),
                hSpace(6),
                Wrap(
                  spacing: 6.w,
                  children: [
                    for (final a in PriceRuleDraft.allowed[d.kind]!)
                      ChoiceChip(
                        label: Text(
                          'venue.pricing.adjustment.$a'.tr(context: context),
                        ),
                        selected: d.adjustment == a,
                        showCheckmark: false,
                        onSelected: (_) =>
                            draft.value = draft.value.copyWith(adjustment: a),
                      ),
                  ],
                ),
                hSpace(12),
              ],
              CustomTextFormField(
                controller: name,
                labelText: d.isDiscount ? t('discount_name') : t('name'),
                hintText: d.isDiscount ? t('discount_name_hint') : t('name'),
              ),
              hSpace(12),
              CustomTextFormField(
                controller: value,
                labelText: d.isPercent
                    ? (d.isDiscount ? t('discount_percent') : t('percent'))
                    : d.adjustment == 'FixedAmountOff'
                    ? t('amount_off')
                    : t('hourly_rate'),
                hintText: d.isPercent ? '20' : '300',
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
              ),
              hSpace(12),
              Text(t('pitch'), style: AppTextStyles.font13SemiBold),
              DropdownButton<String?>(
                isExpanded: true,
                value: pitchIndex < 0 ? null : d.pitchId,
                items: [
                  DropdownMenuItem<String?>(
                    value: null,
                    child: Text(
                      'venue.pricing.all_pitches'.tr(context: context),
                    ),
                  ),
                  for (final p in venue.pitches)
                    DropdownMenuItem<String?>(value: p.id, child: Text(p.name)),
                ],
                onChanged: (v) =>
                    draft.value = draft.value.copyWith(pitchId: () => v),
              ),
              if (d.kind != 'Base') ...[
                hSpace(12),
                Row(
                  children: [
                    timeField(
                      t('from_time'),
                      d.startTime,
                      (v) => draft.value = draft.value.copyWith(startTime: v),
                    ),
                    SizedBox(width: 8.w),
                    timeField(
                      t('to_time'),
                      d.endTime,
                      (v) => draft.value = draft.value.copyWith(endTime: v),
                    ),
                  ],
                ),
                if (d.isDiscount) ...[
                  hSpace(8),
                  Wrap(
                    spacing: 6.w,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(t('quick'), style: AppTextStyles.font12Medium),
                      ActionChip(
                        label: Text(t('week')),
                        onPressed: () => quickRange(7),
                      ),
                      ActionChip(
                        label: Text(t('two_weeks')),
                        onPressed: () => quickRange(14),
                      ),
                      ActionChip(
                        label: Text(t('month')),
                        onPressed: () => quickRange(30),
                      ),
                      ActionChip(
                        label: Text(t('always')),
                        onPressed: () => quickRange(null),
                      ),
                    ],
                  ),
                ],
                if (d.kind == 'SpecialDate' || d.isDiscount) ...[
                  hSpace(8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => pickDate(true),
                          child: Text(
                            d.startDate.isEmpty
                                ? t('from_date')
                                : '${t('from_date')}: ${d.startDate}',
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => pickDate(false),
                          child: Text(
                            d.endDate.isEmpty
                                ? t('to_date')
                                : '${t('to_date')}: ${d.endDate}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (d.kind != 'Holiday') ...[
                  hSpace(12),
                  Text(t('days'), style: AppTextStyles.font13SemiBold),
                  hSpace(6),
                  Wrap(
                    spacing: 6.w,
                    runSpacing: 6.h,
                    children: [
                      for (final day in DayHours.dayOrder)
                        FilterChip(
                          label: Text(PricingFormat.dayName(context, day)),
                          selected: d.days.contains(day),
                          onSelected: (on) =>
                              draft.value = draft.value.copyWith(
                                days: on
                                    ? [...d.days, day]
                                    : [
                                        for (final x in d.days)
                                          if (x != day) x,
                                      ],
                              ),
                        ),
                    ],
                  ),
                ],
                if (d.isDiscount) ...[
                  hSpace(12),
                  CustomTextFormField(
                    controller: minDuration,
                    labelText: t('min_duration'),
                    hintText: t('min_duration_hint'),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ],
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(t('active')),
                value: d.isActive,
                onChanged: (v) =>
                    draft.value = draft.value.copyWith(isActive: v),
              ),
              if (error.value case final e?) ...[
                Text(
                  e.tr(context: context),
                  style: AppTextStyles.font12SemiBold.copyWith(
                    color: AppColors.redText,
                  ),
                ),
                hSpace(8),
              ],
              BlocBuilder<VenuePricingCubit, VenuePricingState>(
                buildWhen: (a, b) => a.saving != b.saving,
                builder: (context, state) => CustomButton(
                  text: d.isDiscount ? t('save_discount') : t('save'),
                  height: 50.h,
                  borderRadius: 14,
                  isLoading: state.saving,
                  textStyle: AppTextStyles.font15Bold.copyWith(
                    color: AppColors.white,
                  ),
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    final result = await cubit.save(current());
                    if (result == null) {
                      navigator.pop(true);
                    } else {
                      error.value = result;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
