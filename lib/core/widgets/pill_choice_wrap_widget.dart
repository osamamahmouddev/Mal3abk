import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'selectable_tile_widget.dart';

/// Wrap of 40px rounded pills with a single selection.
class PillChoiceWrapWidget extends StatelessWidget {
  const PillChoiceWrapWidget({
    required this.labels,
    required this.selectedIndex,
    required this.onSelect,
    super.key,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        for (var i = 0; i < labels.length; i++)
          SelectableTileWidget(
            title: labels[i],
            isSelected: selectedIndex == i,
            onTap: () => onSelect(i),
            height: 40,
            borderRadius: 20,
            horizontalPadding: 16,
          ),
      ],
    );
  }
}
