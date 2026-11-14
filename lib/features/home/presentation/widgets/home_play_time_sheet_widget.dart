import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/pill_choice_wrap_widget.dart';
import '../../../explore/presentation/widgets/pitch_day_selector_widget.dart';
import '../../data/models/play_time_model.dart';

/// Picks the day (this week) and the kick-off hour for the home search card.
/// Today only offers the hours still ahead.
class HomePlayTimeSheetWidget extends HookWidget {
  const HomePlayTimeSheetWidget({required this.initial, super.key});

  final PlayTimeModel initial;

  static Future<PlayTimeModel?> show(
    BuildContext context, {
    required PlayTimeModel initial,
  }) => showModalBottomSheet<PlayTimeModel>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.transparent,
    builder: (_) => HomePlayTimeSheetWidget(initial: initial),
  );

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final choice = useState(initial);
    final hours = PlayTimeModel.hoursFor(
      choice.value.dayOffset,
      CairoTime.now(),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.borderInput,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            hSpace(20),
            Text(
              'home.play_prompt'.tr(context: context),
              style: AppTextStyles.font18Bold,
            ),
            hSpace(16),
            Text(
              'home.play_day'.tr(context: context),
              style: AppTextStyles.font14SemiBold,
            ),
            hSpace(10),
            PitchDaySelectorWidget(
              selectedIndex: choice.value.dayOffset,
              onSelect: (offset) =>
                  choice.value = choice.value.onDay(offset, CairoTime.now()),
            ),
            hSpace(18),
            Text(
              'home.play_hour'.tr(context: context),
              style: AppTextStyles.font14SemiBold,
            ),
            hSpace(10),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 260.h),
              child: SingleChildScrollView(
                child: PillChoiceWrapWidget(
                  labels: [
                    for (final h in hours) CairoTime.clockLabel(h, lang),
                  ],
                  selectedIndex: hours.indexOf(choice.value.hour),
                  onSelect: (index) => choice.value = PlayTimeModel(
                    dayOffset: choice.value.dayOffset,
                    hour: hours[index],
                  ),
                ),
              ),
            ),
            hSpace(20),
            CustomButton(
              text: 'common.confirm'.tr(context: context),
              height: 52.h,
              borderRadius: 14,
              onTap: () => Navigator.of(context).pop(choice.value),
            ),
          ],
        ),
      ),
    );
  }
}
