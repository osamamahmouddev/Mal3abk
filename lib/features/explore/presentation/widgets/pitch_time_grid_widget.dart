import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import 'pitch_time_slot_tile_widget.dart';

class PitchTimeGridWidget extends StatelessWidget {
  const PitchTimeGridWidget({
    required this.selectedKey,
    required this.onSelect,
    super.key,
  });

  static const int columns = 3;

  /// (time key, booked, next day)
  static const List<(String, bool, bool)> slots = [
    ('t4', true, false),
    ('t6', true, false),
    ('t7', false, false),
    ('t8', false, false),
    ('t9', true, false),
    ('t10', false, false),
    ('t11', false, false),
    ('t12', false, true),
    ('t1', false, true),
  ];

  final String selectedKey;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final rows = (slots.length / columns).ceil();

    return Column(
      children: [
        for (var r = 0; r < rows; r++) ...[
          if (r > 0) hSpace(8),
          Row(
            children: [
              for (var c = 0; c < columns; c++) ...[
                if (c > 0) vSpace(8),
                Expanded(
                  child: r * columns + c < slots.length
                      ? PitchTimeSlotTileWidget(
                          time: 'explore.slots.${slots[r * columns + c].$1}'
                              .tr(context: context),
                          isBooked: slots[r * columns + c].$2,
                          isNextDay: slots[r * columns + c].$3,
                          isSelected: selectedKey == slots[r * columns + c].$1,
                          onTap: () => onSelect(slots[r * columns + c].$1),
                        )
                      : const RepaintBoundary(),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}
