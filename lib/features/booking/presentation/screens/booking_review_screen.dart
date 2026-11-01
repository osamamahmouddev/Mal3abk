import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../explore/presentation/cubit/pitch_booking_cubit.dart';
import '../widgets/booking_review_bloc_builder.dart';

class BookingReviewScreen extends HookWidget {
  const BookingReviewScreen({this.cubit, super.key});

  final PitchBookingCubit? cubit;

  @override
  Widget build(BuildContext context) {
    final isTeamBooking = useState(false);
    final agreedToPolicy = useState(false);

    if (cubit != null) {
      return BlocProvider<PitchBookingCubit>.value(
        value: cubit!,
        child: BookingReviewBlocBuilder(
          isTeamBooking: isTeamBooking.value,
          agreedToPolicy: agreedToPolicy.value,
          onTeamBookingChanged: (v) => isTeamBooking.value = v,
          onAgreedChanged: (v) => agreedToPolicy.value = v,
        ),
      );
    }

    return BookingReviewBlocBuilder(
      isTeamBooking: isTeamBooking.value,
      agreedToPolicy: agreedToPolicy.value,
      onTeamBookingChanged: (v) => isTeamBooking.value = v,
      onAgreedChanged: (v) => agreedToPolicy.value = v,
    );
  }
}
