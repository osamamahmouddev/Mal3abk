import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../cubit/pitch_booking_cubit.dart';
import '../cubit/pitch_booking_state.dart';
import 'pitch_and_time_loaded_widget.dart';
import 'pitch_and_time_skeleton_widget.dart';
import 'slot_taken_listener_widget.dart';

class PitchAndTimeBlocBuilder extends StatelessWidget {
  const PitchAndTimeBlocBuilder({
    required this.venueId,
    required this.venueName,
    required this.pitchIndex,
    super.key,
  });

  final String venueId;
  final String venueName;
  final int pitchIndex;

  @override
  Widget build(BuildContext context) {
    final title = 'explore.slots.title'.tr(context: context);
    return BlocBuilder<PitchBookingCubit, PitchBookingState>(
      builder: (context, state) => switch (state) {
        PitchBookingLoaded() => SlotTakenListenerWidget(
          child: PitchAndTimeLoadedWidget(state: state, venueName: venueName),
        ),
        PitchBookingError(:final message) => Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: CustomAppBarWidget(title: title, subtitle: venueName),
          body: CustomStateWidget(
            title: message.tr(context: context),
            description: '',
            actionText: 'common.retry'.tr(context: context),
            onActionTap: () => context
                .read<PitchBookingCubit>()
                .loadAvailability(venueId, pitchIndex: pitchIndex),
          ),
        ),
        _ => Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: CustomAppBarWidget(title: title, subtitle: venueName),
          body: const PitchAndTimeSkeletonWidget(),
        ),
      },
    );
  }
}
