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
import '../../../venue_setup/presentation/widgets/week_hours_editor_widget.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../data/models/venue_schedule_models.dart';
import '../cubit/venue_schedule_cubit.dart';
import '../screens/venue_schedule_screen.dart';

/// Upcoming closed days and special hours, public holidays, and adding one.
class ScheduleClosuresTabWidget extends HookWidget {
  const ScheduleClosuresTabWidget({required this.venue, super.key});

  final VenueModel venue;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueScheduleCubit>();
    final today = CairoTime.today();
    final kind = useState(ScheduleOverrideKind.closure);
    final start = useState(today);
    final end = useState<DateTime?>(null);
    final from = useState('15:00');
    final to = useState('16:00');
    final allPitches = useState(true);
    final reason = useTextEditingController();
    String t(String key) => 'venue.schedule.closures.$key'.tr(context: context);
    String kindLabel(String k) =>
        'venue.schedule.closures.kind_$k'.tr(context: context);
    String pitchName(String? id) => id == null
        ? 'venue.schedule.all_pitches'.tr(context: context)
        : venue.pitches.where((p) => p.id == id).firstOrNull?.name ?? '';

    Future<DateTime?> pickDate(DateTime initial) => showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: today,
      lastDate: DateTime(today.year + 2, 12, 31),
    );

    return BlocBuilder<VenueScheduleCubit, VenueScheduleState>(
      builder: (context, state) {
        final year = today.year;
        return ListView(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
          children: [
            VenueSectionCardWidget(
              title: t('upcoming'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (state.special.exceptions.isEmpty)
                    VenueEmptyLineWidget(
                      icon: Icons.event_busy_outlined,
                      text: t('none'),
                    ),
                  for (final x in state.special.exceptions)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        x.reason.isEmpty ? kindLabel(x.kind) : x.reason,
                        style: AppTextStyles.font14SemiBold,
                      ),
                      subtitle: Text(
                        [
                          x.endDate != x.startDate
                              ? '${VenueFormat.day(context, DateTime.parse(x.startDate))} – ${VenueFormat.day(context, DateTime.parse(x.endDate))}'
                              : VenueFormat.day(
                                  context,
                                  DateTime.parse(x.startDate),
                                ),
                          kindLabel(x.kind),
                          if (x.fromTime != null && x.toTime != null)
                            '${HalfHourTimeDropdownWidget.label(context, x.fromTime!.substring(0, 5))} – ${HalfHourTimeDropdownWidget.label(context, x.toTime!.substring(0, 5))}',
                          pitchName(x.pitchId),
                        ].join(' · '),
                        style: AppTextStyles.font12Regular,
                      ),
                      trailing: IconButton(
                        tooltip: 'venue.schedule.closures.remove'.tr(
                          context: context,
                          args: [x.reason],
                        ),
                        onPressed: state.saving
                            ? null
                            : () async {
                                final success = t('removed');
                                final outcome = await cubit.removeOverride(
                                  x.id,
                                );
                                if (!context.mounted) return;
                                await handleScheduleOutcome(
                                  context,
                                  outcome,
                                  success: success,
                                  retry: () => cubit.removeOverride(x.id),
                                );
                              },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: AppColors.brandRed,
                        ),
                      ),
                    ),
                  hSpace(8),
                  OutlinedButton.icon(
                    onPressed: state.saving
                        ? null
                        : () async {
                            final success =
                                'venue.schedule.closures.holidays_done'.tr(
                                  context: context,
                                  args: [VenueFormat.number(context, year)],
                                );
                            Future<ScheduleSaveOutcome> run(bool confirm) =>
                                cubit.closeHolidays(
                                  year: year,
                                  allPitches:
                                      allPitches.value || state.pitchId == null,
                                  confirm: confirm,
                                );
                            final outcome = await run(false);
                            if (!context.mounted) return;
                            await handleScheduleOutcome(
                              context,
                              outcome,
                              success: success,
                              retry: () => run(true),
                            );
                          },
                    icon: const Icon(Icons.celebration_outlined),
                    label: Text(
                      'venue.schedule.closures.holidays'.tr(
                        context: context,
                        args: [VenueFormat.number(context, year)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            hSpace(12),
            VenueSectionCardWidget(
              title: t('add_title'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    spacing: 8.w,
                    children: [
                      for (final k in ScheduleOverrideKind.values)
                        ChoiceChip(
                          label: Text(kindLabel(k.apiName)),
                          selected: kind.value == k,
                          onSelected: (_) => kind.value = k,
                          showCheckmark: false,
                        ),
                    ],
                  ),
                  hSpace(10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final d = await pickDate(start.value);
                            if (d != null) start.value = d;
                          },
                          child: Text(
                            '${t('from_day')}: ${VenueFormat.day(context, start.value)}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final d = await pickDate(end.value ?? start.value);
                            end.value = d;
                          },
                          child: Text(
                            end.value == null
                                ? t('to_day')
                                : '${t('to_day_short')}: ${VenueFormat.day(context, end.value!)}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (kind.value != ScheduleOverrideKind.closure) ...[
                    hSpace(10),
                    Row(
                      children: [
                        Expanded(
                          child: HalfHourTimeDropdownWidget(
                            value: from.value,
                            onChanged: (v) => from.value = v,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: HalfHourTimeDropdownWidget(
                            value: to.value,
                            onChanged: (v) => to.value = v,
                          ),
                        ),
                      ],
                    ),
                  ],
                  hSpace(10),
                  CustomTextFormField(
                    controller: reason,
                    labelText: t('reason'),
                    hintText: t('reason_hint'),
                  ),
                  if (state.pitchId != null)
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: allPitches.value,
                      onChanged: (v) => allPitches.value = v ?? true,
                      title: Text(
                        'venue.schedule.closures.all_pitches_not_only'.tr(
                          context: context,
                          args: [pitchName(state.pitchId)],
                        ),
                      ),
                    ),
                  hSpace(10),
                  CustomButton(
                    text: t('add'),
                    height: 48.h,
                    borderRadius: 14,
                    isLoading: state.saving,
                    textStyle: AppTextStyles.font15Bold.copyWith(
                      color: AppColors.white,
                    ),
                    onTap: () async {
                      final success = t('added');
                      final text = reason.text.trim().isEmpty
                          ? kindLabel(kind.value.apiName)
                          : reason.text.trim();
                      Future<ScheduleSaveOutcome> run(bool confirm) =>
                          cubit.addOverride(
                            kind: kind.value,
                            startDate: VenueFormat.apiDate(start.value),
                            endDate: end.value == null
                                ? null
                                : VenueFormat.apiDate(end.value!),
                            fromTime: from.value,
                            toTime: to.value,
                            reason: text,
                            allPitches:
                                allPitches.value || state.pitchId == null,
                            confirm: confirm,
                          );
                      final outcome = await run(false);
                      if (!context.mounted) return;
                      await handleScheduleOutcome(
                        context,
                        outcome,
                        success: success,
                        retry: () => run(true),
                      );
                      if (outcome is ScheduleSaved) reason.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

extension on ScheduleOverrideKind {
  /// The API's name for the kind (`Closure`, `SpecialHours`, `Break`).
  String get apiName => switch (this) {
    ScheduleOverrideKind.closure => 'Closure',
    ScheduleOverrideKind.specialHours => 'SpecialHours',
    ScheduleOverrideKind.breakTime => 'Break',
  };
}
