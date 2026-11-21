import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../explore/presentation/cubit/pitch_booking_cubit.dart';
import '../widgets/booking_review_bloc_builder.dart';

/// Reviews the slot chosen on the pitch screen, sharing its cubit.
class BookingReviewScreen extends HookWidget {
  const BookingReviewScreen({required this.cubit, super.key});

  final PitchBookingCubit cubit;

  @override
  Widget build(BuildContext context) {
    final agreedToPolicy = useState(false);
    // The price may still be missing (slow or lost answer): ask again rather
    // than wait on a quote nobody is fetching.
    useEffect(() {
      cubit.ensureQuote();
      return null;
    }, [cubit]);
    return BlocProvider<PitchBookingCubit>.value(
      value: cubit,
      child: BookingReviewBlocBuilder(
        agreedToPolicy: agreedToPolicy.value,
        onAgreedChanged: (v) => agreedToPolicy.value = v,
      ),
    );
  }
}
