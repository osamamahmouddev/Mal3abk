import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/searchable_picker_sheet_widget.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../../data/models/venue_bookings_query.dart';
import '../cubit/venue_bookings_cubit.dart';

/// Pitch, period, source and sort filters as a row of dropdown chips.
class VenueBookingsFiltersWidget extends StatelessWidget {
  const VenueBookingsFiltersWidget({
    required this.venue,
    required this.query,
    super.key,
  });

  final VenueModel venue;
  final VenueBookingsQuery query;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueBookingsCubit>();
    String t(String key) => 'venue.bookings.filters.$key'.tr(context: context);

    Future<int?> pick(String title, List<String> options, int selected) =>
        SearchablePickerSheetWidget.show(
          context,
          title: title,
          options: options,
          selectedIndex: selected,
          searchHint: t('search'),
          emptyText: t('no_match'),
        );

    final pitchIndex = venue.pitches.indexWhere((p) => p.id == query.pitchId);
    return SizedBox(
      height: 38.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          _DropdownChip(
            label: pitchIndex < 0
                ? t('all_pitches')
                : venue.pitches[pitchIndex].name,
            active: pitchIndex >= 0,
            onTap: () async {
              final i = await pick(t('pitch'), [
                t('all_pitches'),
                for (final p in venue.pitches) p.name,
              ], pitchIndex + 1);
              if (i == null) return;
              await cubit.setQuery(
                query.copyWith(
                  pitchId: () => i == 0 ? null : venue.pitches[i - 1].id,
                ),
              );
            },
          ),
          _DropdownChip(
            label: t('range_${query.range.name}'),
            active: query.range != VenueBookingsRange.all,
            onTap: () async {
              const values = VenueBookingsRange.values;
              final i = await pick(t('range'), [
                for (final r in values) t('range_${r.name}'),
              ], values.indexOf(query.range));
              if (i != null) {
                await cubit.setQuery(query.copyWith(range: values[i]));
              }
            },
          ),
          _DropdownChip(
            label: t('source_${query.source.name}'),
            active: query.source != VenueBookingsSource.all,
            onTap: () async {
              const values = VenueBookingsSource.values;
              final i = await pick(t('source'), [
                for (final s in values) t('source_${s.name}'),
              ], values.indexOf(query.source));
              if (i != null) {
                await cubit.setQuery(query.copyWith(source: values[i]));
              }
            },
          ),
          _DropdownChip(
            label: t('sort_${query.sort.name}'),
            active: false,
            icon: Icons.swap_vert_rounded,
            onTap: () async {
              const values = VenueBookingsSort.values;
              final i = await pick(t('sort'), [
                for (final s in values) t('sort_${s.name}'),
              ], values.indexOf(query.sort));
              if (i != null) {
                await cubit.setQuery(query.copyWith(sort: values[i]));
              }
            },
          ),
        ],
      ),
    );
  }
}

class _DropdownChip extends StatelessWidget {
  const _DropdownChip({
    required this.label,
    required this.active,
    required this.onTap,
    this.icon = Icons.keyboard_arrow_down_rounded,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final fg = active ? AppColors.white : AppColors.textBody;
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.w),
      child: Material(
        color: active ? AppColors.brandNavy : AppColors.white,
        shape: StadiumBorder(
          side: BorderSide(
            color: active ? AppColors.brandNavy : AppColors.chipBorder,
          ),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: AppTextStyles.font13SemiBold.copyWith(color: fg),
                ),
                SizedBox(width: 4.w),
                Icon(icon, size: 16.r, color: fg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
