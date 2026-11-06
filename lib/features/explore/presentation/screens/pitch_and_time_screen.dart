import 'package:flutter/material.dart';

import '../widgets/pitch_and_time_bloc_builder.dart';

/// Which venue to book, its name for the header, and the pitch to open on.
class PitchAndTimeArgs {
  const PitchAndTimeArgs({
    required this.venueId,
    required this.venueName,
    this.pitchIndex = 0,
  });

  final String venueId;
  final String venueName;
  final int pitchIndex;
}

class PitchAndTimeScreen extends StatelessWidget {
  const PitchAndTimeScreen({required this.args, super.key});

  final PitchAndTimeArgs args;

  @override
  Widget build(BuildContext context) => PitchAndTimeBlocBuilder(
    venueId: args.venueId,
    venueName: args.venueName,
    pitchIndex: args.pitchIndex,
  );
}
