import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/pitch_booking_cubit.dart';
import '../cubit/pitch_booking_state.dart';

/// Tells the player, once, that someone else just took the slot they picked
/// (a live update or a lost race). [onTaken] runs after, e.g. to leave the
/// review screen for the slots.
class SlotTakenListenerWidget extends StatelessWidget {
  const SlotTakenListenerWidget({required this.child, this.onTaken, super.key});

  final Widget child;
  final VoidCallback? onTaken;

  static bool _taken(PitchBookingState state) =>
      state is PitchBookingLoaded && state.selectedSlotTaken;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PitchBookingCubit, PitchBookingState>(
      listenWhen: (previous, current) => !_taken(previous) && _taken(current),
      listener: (context, state) {
        HapticFeedback.heavyImpact();
        // A lost race already shows the booking error.
        if (state is PitchBookingLoaded && state.bookingError == null) {
          AppTopSnackBar.showError(
            context,
            'explore.slots.taken_live'.tr(context: context),
          );
        }
        onTaken?.call();
      },
      child: child,
    );
  }
}
