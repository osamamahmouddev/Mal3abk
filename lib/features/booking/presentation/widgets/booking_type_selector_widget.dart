import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';

class BookingTypeSelectorWidget extends StatelessWidget {
  const BookingTypeSelectorWidget({
    required this.isTeamBooking,
    required this.onChanged,
    super.key,
  });

  final bool isTeamBooking;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SelectableTileWidget(
            title: 'booking.individual_booking'.tr(context: context),
            isSelected: !isTeamBooking,
            onTap: () => onChanged(false),
            height: 46,
            borderRadius: 12,
          ),
        ),
        vSpace(8),
        Expanded(
          child: SelectableTileWidget(
            title: 'booking.team_booking'.tr(context: context),
            isSelected: isTeamBooking,
            onTap: () => onChanged(true),
            height: 46,
            borderRadius: 12,
          ),
        ),
      ],
    );
  }
}
