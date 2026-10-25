import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/empty_note_box_widget.dart';

class HomeEmptyBookingWidget extends StatelessWidget {
  const HomeEmptyBookingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyNoteBoxWidget(
      text: 'home.no_bookings'.tr(context: context),
      minHeight: 80,
    );
  }
}
