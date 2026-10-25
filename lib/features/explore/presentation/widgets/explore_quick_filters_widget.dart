import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';

class ExploreQuickFiltersWidget extends HookWidget {
  const ExploreQuickFiltersWidget({super.key});

  static const List<String> filterKeys = [
    'chip_under_3km',
    'chip_under_160',
    'chip_five_players',
    'covered',
  ];

  @override
  Widget build(BuildContext context) {
    final selected = useState(<String>{'chip_under_3km'});

    return Container(
      height: 36.h,
      alignment: AlignmentDirectional.centerStart,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: filterKeys.length,
        separatorBuilder: (_, _) => vSpace(6),
        itemBuilder: (context, index) {
          final key = filterKeys[index];
          return SelectableTileWidget(
            title: 'explore.$key'.tr(context: context),
            isSelected: selected.value.contains(key),
            onTap: () {
              final next = {...selected.value};
              if (!next.remove(key)) next.add(key);
              selected.value = next;
            },
            height: 36,
            borderRadius: 18,
            horizontalPadding: 13,
            titleStyle: AppTextStyles.font13SemiBold,
            borderColor: AppColors.chipBorder,
          );
        },
      ),
    );
  }
}
