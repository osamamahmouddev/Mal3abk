import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/di/service_locator.dart';
import '../cubit/pitch_booking_cubit.dart';
import '../widgets/pitch_and_time_bloc_builder.dart';

class PitchAndTimeScreen extends HookWidget {
  const PitchAndTimeScreen({this.venueId, super.key});

  final String? venueId;

  static const String defaultVenueId = 'd4f21692-d657-46a4-9961-191d88dccdef';

  @override
  Widget build(BuildContext context) {
    final targetVenueId = venueId ?? defaultVenueId;

    return BlocProvider<PitchBookingCubit>(
      create: (_) => sl<PitchBookingCubit>()..loadAvailability(targetVenueId),
      child: PitchAndTimeBlocBuilder(venueId: targetVenueId),
    );
  }
}
