import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/venue_setup_cubit.dart';
import '../cubit/venue_setup_state.dart';
import 'week_hours_editor_widget.dart';

/// Step 3: weekly opening hours.
class VenueSetupHoursStepWidget extends StatelessWidget {
  const VenueSetupHoursStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueSetupCubit>();
    String t(String key) => 'venue.setup.hours.$key'.tr(context: context);

    return BlocBuilder<VenueSetupCubit, VenueSetupState>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t('intro'),
            style: AppTextStyles.font13Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          hSpace(12),
          WeekHoursEditorWidget(week: state.week, onChanged: cubit.setDay),
          hSpace(8),
          CustomButton(
            text: t('save_next'),
            height: 52.h,
            borderRadius: 14,
            isLoading: state.saving,
            textStyle: AppTextStyles.font16Bold.copyWith(
              color: AppColors.white,
            ),
            onTap: cubit.saveSchedules,
          ),
        ],
      ),
    );
  }
}
