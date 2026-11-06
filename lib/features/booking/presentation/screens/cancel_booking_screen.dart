import 'package:flutter/material.dart';

import '../widgets/cancel_booking_bloc_consumer.dart';

class CancelBookingScreen extends StatelessWidget {
  const CancelBookingScreen({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context) =>
      CancelBookingBlocConsumer(bookingId: bookingId);
}
