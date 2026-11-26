import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/searchable_picker_sheet_widget.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../cubit/venue_calendar_cubit.dart';
import '../cubit/venue_calendar_state.dart';

/// View switch, period navigation and the week view's pitch.
class CalendarToolbarWidget extends StatelessWidget {
  const CalendarToolbarWidget({
    required this.venue,
    required this.state,
    super.key,
  });

  final VenueModel venue;
  final VenueCalendarState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueCalendarCubit>();
    final lang = context.locale.languageCode;
    String t(String key) => 'venue.calendar.$key'.tr(context: context);
    String fmt(String pattern, DateTime d) {
      final text = intl.DateFormat(pattern, lang).format(d);
      return lang == 'ar' ? text.toArabicDigits() : text;
    }

    final weekStart = VenueCalendarCubit.weekStart(state.date);
    final title = switch (state.view) {
      VenueCalendarView.day => fmt('EEEE d MMMM', state.date),
      VenueCalendarView.week =>
        '${fmt('d MMM', weekStart)} – ${fmt('d MMM', DateTime(weekStart.year, weekStart.month, weekStart.day + 6))}',
      VenueCalendarView.month => fmt('MMMM y', state.date),
    };
    final pitches = venue.activePitches;
    final weekPitch = pitches
        .where((p) => p.id == state.weekPitchId)
        .firstOrNull;

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 10.h),
      child: Column(
        children: [
          SegmentedButton<VenueCalendarView>(
            segments: [
              for (final v in VenueCalendarView.values)
                ButtonSegment(value: v, label: Text(t('view_${v.name}'))),
            ],
            selected: {state.view},
            showSelectedIcon: false,
            onSelectionChanged: (s) => cubit.setView(s.first),
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: AppColors.brandNavy,
              selectedForegroundColor: AppColors.white,
              textStyle: AppTextStyles.font13Bold,
              visualDensity: VisualDensity.compact,
            ),
          ),
          hSpace(8),
          Row(
            children: [
              IconButton(
                tooltip: t('previous'),
                onPressed: () => cubit.step(forward: false),
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              Expanded(
                child: Semantics(
                  liveRegion: true,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font15Bold,
                  ),
                ),
              ),
              IconButton(
                tooltip: t('next'),
                onPressed: () => cubit.step(forward: true),
                icon: const Icon(Icons.chevron_right_rounded),
              ),
              TextButton(onPressed: cubit.goToday, child: Text(t('today'))),
            ],
          ),
          if (state.view == VenueCalendarView.week && pitches.isNotEmpty)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: ActionChip(
                avatar: const Icon(Icons.stadium_rounded, size: 16),
                label: Text(weekPitch?.name ?? t('choose_pitch')),
                onPressed: () async {
                  final i = await SearchablePickerSheetWidget.show(
                    context,
                    title: t('choose_pitch'),
                    options: [for (final p in pitches) p.name],
                    selectedIndex: pitches.indexOf(weekPitch ?? pitches.first),
                    searchHint: t('search_pitch'),
                    emptyText: 'venue.shell.no_match'.tr(context: context),
                  );
                  if (i != null) cubit.setWeekPitch(pitches[i].id);
                },
              ),
            ),
        ],
      ),
    );
  }
}
