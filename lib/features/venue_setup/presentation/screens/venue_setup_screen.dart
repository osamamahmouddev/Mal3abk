import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../cubit/venue_setup_cubit.dart';
import '../cubit/venue_setup_state.dart';
import '../widgets/venue_setup_hours_step_widget.dart';
import '../widgets/venue_setup_pitches_step_widget.dart';
import '../widgets/venue_setup_place_step_widget.dart';
import '../widgets/venue_setup_review_step_widget.dart';
import '../widgets/venue_setup_steps_header_widget.dart';

/// Creates a venue or edits one, in the web dashboard's four steps. Pops the
/// venue id so the dashboard opens it.
class VenueSetupScreen extends StatelessWidget {
  const VenueSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueSetupCubit>();
    void close() => Navigator.of(context).pop(cubit.venueId);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) close();
      },
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'venue.setup.title'.tr(context: context),
          onBackTap: close,
        ),
        body: BlocBuilder<VenueSetupCubit, VenueSetupState>(
          builder: (context, state) {
            final note = state.lastAdminNote;
            return ListView(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
              children: [
                VenueSetupStepsHeaderWidget(state: state),
                hSpace(14),
                if (note != null &&
                    (state.approvalStatus == 'NeedsInfo' ||
                        state.approvalStatus == 'Rejected')) ...[
                  AlertBannerWidget(
                    type: state.approvalStatus == 'Rejected'
                        ? AlertBannerType.error
                        : AlertBannerType.warning,
                    message:
                        '${'venue.setup.admin_note_${state.approvalStatus == 'Rejected' ? 'rejected' : 'needs_info'}'.tr(context: context)} $note',
                  ),
                  hSpace(14),
                ],
                Text(
                  'venue.setup.step_${state.step}'.tr(context: context),
                  style: AppTextStyles.font20Bold,
                ),
                hSpace(12),
                switch (state.step) {
                  1 => const VenueSetupPlaceStepWidget(),
                  2 => const VenueSetupPitchesStepWidget(),
                  3 => const VenueSetupHoursStepWidget(),
                  _ => VenueSetupReviewStepWidget(onOpenDashboard: close),
                },
                if (state.error case final error?) ...[
                  hSpace(12),
                  AlertBannerWidget(
                    type: AlertBannerType.error,
                    message: error.tr(context: context),
                  ),
                ],
                if (state.step > 1) ...[
                  hSpace(12),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton.icon(
                      onPressed: () => cubit.goTo(state.step - 1),
                      icon: const Icon(Icons.arrow_back_rounded, size: 18),
                      label: Text('venue.setup.back'.tr(context: context)),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
