import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../data/models/venue_schedule_models.dart';
import '../cubit/venue_schedule_cubit.dart';
import '../screens/venue_schedule_screen.dart';

/// Booking length, step, notice and how far ahead players can book.
class ScheduleRulesTabWidget extends HookWidget {
  const ScheduleRulesTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueScheduleCubit>();
    final rules = useState<BookingRulesModel>(cubit.currentRules);
    String t(String key) => 'venue.schedule.rules.$key'.tr(context: context);

    Widget option(
      String label,
      int current,
      List<(int, String)> values,
      BookingRulesModel Function(int) apply,
    ) => Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: VenueSectionCardWidget(
        title: label,
        child: Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            for (final (v, text) in values)
              ChoiceChip(
                label: Text(t(text)),
                selected: current == v,
                onSelected: (_) => rules.value = apply(v),
                showCheckmark: false,
              ),
          ],
        ),
      ),
    );

    final r = rules.value;
    return BlocBuilder<VenueScheduleCubit, VenueScheduleState>(
      builder: (context, state) => ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
        children: [
          option(t('min_duration'), r.minDurationMinutes, const [
            (60, 'hour'),
            (90, 'hour_half'),
            (120, 'two_hours'),
          ], (v) => r.copyWith(minDurationMinutes: v)),
          option(t('max_duration'), r.maxDurationMinutes, const [
            (60, 'hour'),
            (120, 'two_hours'),
            (180, 'three_hours'),
          ], (v) => r.copyWith(maxDurationMinutes: v)),
          option(t('increment'), r.incrementMinutes, const [
            (30, 'half_hour'),
            (60, 'hour'),
          ], (v) => r.copyWith(incrementMinutes: v)),
          option(t('min_notice'), r.minNoticeMinutes, const [
            (0, 'now'),
            (60, 'hour'),
            (180, 'three_hours'),
            (1440, 'day'),
          ], (v) => r.copyWith(minNoticeMinutes: v)),
          option(t('max_advance'), r.maxAdvanceDays, const [
            (7, 'week'),
            (14, 'two_weeks'),
            (30, 'month'),
          ], (v) => r.copyWith(maxAdvanceDays: v)),
          CustomButton(
            text: t('save'),
            height: 50.h,
            borderRadius: 14,
            isLoading: state.saving,
            textStyle: AppTextStyles.font15Bold.copyWith(
              color: AppColors.white,
            ),
            onTap: () async {
              final success = t('saved');
              final outcome = await cubit.saveRules(rules.value);
              if (!context.mounted) return;
              await handleScheduleOutcome(
                context,
                outcome,
                success: success,
                retry: () => cubit.saveRules(rules.value),
              );
            },
          ),
          hSpace(8),
        ],
      ),
    );
  }
}
