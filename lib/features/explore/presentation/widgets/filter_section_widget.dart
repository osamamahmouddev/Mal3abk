import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';

/// One titled group of filter chips; [options] are (id, label) pairs.
class FilterSectionWidget extends StatelessWidget {
  const FilterSectionWidget({
    required this.title,
    required this.options,
    required this.selected,
    required this.onToggle,
    super.key,
    this.hint,
  });

  final String title;
  final String? hint;
  final List<(String, String)> options;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.lightSurface)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyles.font15Bold),
              if (hint != null) Text(hint!, style: AppTextStyles.font12Regular),
            ],
          ),
          hSpace(14),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              for (final (id, label) in options)
                SelectableTileWidget(
                  title: label,
                  isSelected: selected.contains(id),
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onToggle(id);
                  },
                  height: 40,
                  borderRadius: 10,
                  horizontalPadding: 11,
                  borderColor: AppColors.chipBorder,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
