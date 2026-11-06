import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/challenge_response_cubit.dart';
import 'challenge_schedule_picker_widget.dart';

class CounterProposalSheetWidget extends HookWidget {
  const CounterProposalSheetWidget({
    required this.challengeId,
    required this.teamId,
    required this.durationMinutes,
    super.key,
  });

  final String challengeId;
  final String teamId;
  final int durationMinutes;

  @override
  Widget build(BuildContext context) {
    final initial = useMemoized(ChallengeSchedulePickerWidget.firstAvailable);
    final day = useState(initial.$1);
    final hour = useState(initial.$2);
    final duration = useState(
      ChallengeSchedulePickerWidget.durations.contains(durationMinutes)
          ? durationMinutes
          : 90,
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'matches.challenge.counter'.tr(context: context),
                style: AppTextStyles.font18Bold,
              ),
              hSpace(16),
              ChallengeSchedulePickerWidget(
                day: day.value,
                hour: hour.value,
                durationMinutes: duration.value,
                onDayChanged: (value) {
                  day.value = value;
                  if (value == CairoTime.today() &&
                      hour.value <= CairoTime.now().hour) {
                    hour.value = ChallengeSchedulePickerWidget.firstAvailable(
                      preferredHour: hour.value,
                    ).$2;
                  }
                },
                onHourChanged: (value) => hour.value = value,
                onDurationChanged: (value) => duration.value = value,
              ),
              hSpace(20),
              CustomButton(
                text: 'matches.challenge.counter_send'.tr(context: context),
                height: 50.h,
                borderRadius: 12,
                textStyle: AppTextStyles.font16Bold.copyWith(
                  color: AppColors.white,
                ),
                onTap: () {
                  HapticFeedback.lightImpact();
                  context.read<ChallengeResponseCubit>().counterPropose(
                    challengeId,
                    teamId,
                    proposedUtc: CairoTime.toUtc(day.value, hour.value),
                    durationMinutes: duration.value,
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
