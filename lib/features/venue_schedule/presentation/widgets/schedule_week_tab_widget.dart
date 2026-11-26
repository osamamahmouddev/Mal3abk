import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../venue_setup/presentation/widgets/week_hours_editor_widget.dart';
import '../cubit/venue_schedule_cubit.dart';
import '../screens/venue_schedule_screen.dart';

class ScheduleWeekTabWidget extends StatelessWidget {
  const ScheduleWeekTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueScheduleCubit>();
    String t(String key) => 'venue.schedule.$key'.tr(context: context);
    return BlocBuilder<VenueScheduleCubit, VenueScheduleState>(
      builder: (context, state) {
        if (state.loading) {
          return const ShimmerListSkeletonWidget(itemHeight: 70);
        }
        return ListView(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
          children: [
            Text(
              state.pitchId == null
                  ? 'venue.setup.hours.intro'.tr(context: context)
                  : cubit.hasOwnPitchHours
                  ? t('pitch_own_hours')
                  : t('pitch_follows_venue'),
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            hSpace(12),
            WeekHoursEditorWidget(week: state.week, onChanged: cubit.setDay),
            hSpace(8),
            CustomButton(
              text: state.pitchId == null ? t('save_week') : t('save_pitch'),
              height: 52.h,
              borderRadius: 14,
              isLoading: state.saving,
              textStyle: AppTextStyles.font16Bold.copyWith(
                color: AppColors.white,
              ),
              onTap: () async {
                final success = state.pitchId == null
                    ? t('week_saved')
                    : t('pitch_saved');
                final outcome = await cubit.saveWeek();
                if (!context.mounted) return;
                await handleScheduleOutcome(
                  context,
                  outcome,
                  success: success,
                  retry: () => cubit.saveWeek(confirm: true),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
