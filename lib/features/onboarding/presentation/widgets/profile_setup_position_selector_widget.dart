import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';

class ProfileSetupPositionSelectorWidget extends StatelessWidget {
  const ProfileSetupPositionSelectorWidget({
    required this.selectedPositions,
    required this.onToggle,
    super.key,
  });

  static const List<String> positionKeys = [
    'pos_gk',
    'pos_def',
    'pos_mid',
    'pos_fwd',
  ];

  final Set<String> selectedPositions;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < positionKeys.length; i++) ...[
          if (i > 0) vSpace(8),
          Expanded(
            child: SelectableTileWidget(
              title: 'onboarding.profile_setup.${positionKeys[i]}'
                  .tr(context: context),
              isSelected: selectedPositions.contains(positionKeys[i]),
              onTap: () => onToggle(positionKeys[i]),
              height: 46,
              borderRadius: 12,
            ),
          ),
        ],
      ],
    );
  }
}
