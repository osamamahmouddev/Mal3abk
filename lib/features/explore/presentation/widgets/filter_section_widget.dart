import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';

class FilterSectionWidget extends StatelessWidget {
  const FilterSectionWidget({
    required this.titleKey,
    required this.optionKeys,
    required this.selected,
    required this.onToggle,
    super.key,
    this.hintKey,
  });

  final String titleKey;
  final String? hintKey;
  final List<String> optionKeys;
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
              Text(
                'explore.filters.$titleKey'.tr(context: context),
                style: AppTextStyles.font15Bold,
              ),
              if (hintKey != null)
                Text(
                  'explore.filters.$hintKey'.tr(context: context),
                  style: AppTextStyles.font12Regular,
                ),
            ],
          ),
          hSpace(14),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              for (final key in optionKeys)
                SelectableTileWidget(
                  title: 'explore.filters.$key'.tr(context: context),
                  isSelected: selected.contains(key),
                  onTap: () => onToggle(key),
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
