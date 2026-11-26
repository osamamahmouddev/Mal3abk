import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_tab_bar_widget.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../domain/repos/venue_schedule_repo.dart';
import '../cubit/venue_schedule_cubit.dart';
import '../widgets/schedule_closures_tab_widget.dart';
import '../widgets/schedule_rules_tab_widget.dart';
import '../widgets/schedule_week_tab_widget.dart';

/// Opening hours of the venue or one pitch, closed days and holidays, and
/// booking rules, like the web "hours" page.
class VenueScheduleScreen extends StatefulWidget {
  const VenueScheduleScreen({super.key});

  @override
  State<VenueScheduleScreen> createState() => _VenueScheduleScreenState();
}

class _VenueScheduleScreenState extends State<VenueScheduleScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    String t(String key) => 'venue.schedule.$key'.tr(context: context);
    return BlocProvider<VenueScheduleCubit>(
      create: (_) => VenueScheduleCubit(
        venueScheduleRepo: sl<VenueScheduleRepo>(),
        venueId: session.venue.id,
      )..load(),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(title: t('title')),
        body: BlocBuilder<VenueScheduleCubit, VenueScheduleState>(
          buildWhen: (a, b) => a.pitchId != b.pitchId,
          builder: (context, state) {
            final cubit = context.read<VenueScheduleCubit>();
            return Column(
              children: [
                SizedBox(
                  height: 52.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(end: 8.w),
                        child: ChoiceChip(
                          label: Text(t('all_pitches')),
                          selected: state.pitchId == null,
                          onSelected: (_) => cubit.selectPitch(null),
                        ),
                      ),
                      for (final p in session.venue.pitches)
                        Padding(
                          padding: EdgeInsetsDirectional.only(end: 8.w),
                          child: ChoiceChip(
                            label: Text(p.name),
                            selected: state.pitchId == p.id,
                            onSelected: (_) => cubit.selectPitch(p.id),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  color: AppColors.white,
                  child: CustomTabBarWidget(
                    tabs: [t('tab_week'), t('tab_closures'), t('tab_rules')],
                    selectedIndex: _tab,
                    onTabSelected: (i) => setState(() => _tab = i),
                  ),
                ),
                Expanded(
                  child: switch (_tab) {
                    0 => const ScheduleWeekTabWidget(),
                    1 => ScheduleClosuresTabWidget(venue: session.venue),
                    _ => ScheduleRulesTabWidget(key: ValueKey(state.pitchId)),
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Shows what a save did. A change that hits confirmed bookings lists them
/// and asks whether to go on; [retry] then sends it with `confirm`.
Future<void> handleScheduleOutcome(
  BuildContext context,
  ScheduleSaveOutcome outcome, {
  required String success,
  required Future<ScheduleSaveOutcome> Function() retry,
}) async {
  switch (outcome) {
    case ScheduleSaved():
      AppTopSnackBar.showSuccess(context, success);
    case ScheduleSaveFailed(:final message):
      AppTopSnackBar.showError(context, message.tr(context: context));
    case ScheduleNeedsConfirm(:final affected):
      final go = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(
            'venue.schedule.affected_title'.tr(
              context: context,
              args: ['${affected.length}'],
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('venue.schedule.affected_body'.tr(context: context)),
                SizedBox(height: 8.h),
                for (final b in affected)
                  Text(
                    '• ${b.reference} — ${VenueFormat.dateTime(context, b.startUtc)}',
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text('common.cancel'.tr(context: context)),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text('venue.schedule.continue'.tr(context: context)),
            ),
          ],
        ),
      );
      if (go != true || !context.mounted) return;
      final second = await retry();
      if (!context.mounted) return;
      await handleScheduleOutcome(
        context,
        second,
        success: success,
        retry: retry,
      );
  }
}
