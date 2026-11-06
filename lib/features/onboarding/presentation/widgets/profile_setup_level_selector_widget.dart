import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';
import '../../../profile/data/models/player_attributes.dart';

class ProfileSetupLevelSelectorWidget extends StatelessWidget {
  const ProfileSetupLevelSelectorWidget({
    required this.selectedLevel,
    required this.onSelect,
    super.key,
  });

  static String keyFor(SkillLevel level) => switch (level) {
    SkillLevel.beginner => 'beg',
    SkillLevel.intermediate => 'mid',
    SkillLevel.advanced => 'adv',
  };

  final SkillLevel? selectedLevel;

  /// Tapping the selected level clears it; the level is optional.
  final ValueChanged<SkillLevel?> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final (i, level) in SkillLevel.values.indexed) ...[
          if (i > 0) vSpace(8),
          Expanded(
            child: SelectableTileWidget(
              title: 'onboarding.profile_setup.level_${keyFor(level)}_title'.tr(
                context: context,
              ),
              subtitle: 'onboarding.profile_setup.level_${keyFor(level)}_sub'
                  .tr(context: context),
              isSelected: selectedLevel == level,
              onTap: () {
                HapticFeedback.selectionClick();
                onSelect(selectedLevel == level ? null : level);
              },
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
