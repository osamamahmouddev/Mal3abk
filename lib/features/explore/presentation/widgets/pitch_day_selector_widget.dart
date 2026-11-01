import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import 'pitch_day_tile_widget.dart';

class PitchDaySelectorWidget extends StatelessWidget {
  const PitchDaySelectorWidget({
    required this.selectedIndex,
    required this.onSelect,
    super.key,
  });

  static const List<String> dayKeys = [
    'sat',
    'sun',
    'mon',
    'tue',
    'wed',
    'thu',
  ];
  static const int firstDate = 26;

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;

    return Row(
      children: [
        for (var i = 0; i < dayKeys.length; i++) ...[
          if (i > 0) vSpace(6),
          Expanded(
            child: PitchDayTileWidget(
              dayName: 'explore.slots.day_${dayKeys[i]}'.tr(context: context),
              dayNumber: (firstDate + i).toLocalizedDigits(languageCode),
              isSelected: selectedIndex == i,
              onTap: () => onSelect(i),
            ),
          ),
        ],
      ],
    );
  }
}
