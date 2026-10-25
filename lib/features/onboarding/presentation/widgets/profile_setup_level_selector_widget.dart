import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';

class ProfileSetupLevelSelectorWidget extends StatelessWidget {
  const ProfileSetupLevelSelectorWidget({
    required this.selectedLevel,
    required this.onSelect,
    super.key,
  });

  static const List<String> levelKeys = ['beg', 'mid', 'adv'];

  final String selectedLevel;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < levelKeys.length; i++) ...[
          if (i > 0) vSpace(8),
          Expanded(
            child: SelectableTileWidget(
              title: 'onboarding.profile_setup.level_${levelKeys[i]}_title'
                  .tr(context: context),
              subtitle: 'onboarding.profile_setup.level_${levelKeys[i]}_sub'
                  .tr(context: context),
              isSelected: selectedLevel == levelKeys[i],
              onTap: () => onSelect(levelKeys[i]),
              height: 62,
              borderRadius: 12,
              boldTitle: true,
            ),
          ),
        ],
      ],
    );
  }
}
