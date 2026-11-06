import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/selectable_tile_widget.dart';
import '../../../profile/data/models/player_attributes.dart';

class ProfileSetupPositionSelectorWidget extends StatelessWidget {
  const ProfileSetupPositionSelectorWidget({
    required this.selectedPositions,
    required this.onToggle,
    super.key,
  });

  static String labelKey(PlayerPosition position) => switch (position) {
    PlayerPosition.goalkeeper => 'onboarding.profile_setup.pos_gk',
    PlayerPosition.defender => 'onboarding.profile_setup.pos_def',
    PlayerPosition.midfielder => 'onboarding.profile_setup.pos_mid',
    PlayerPosition.forward => 'onboarding.profile_setup.pos_fwd',
  };

  final Set<PlayerPosition> selectedPositions;
  final ValueChanged<PlayerPosition> onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final (i, position) in PlayerPosition.values.indexed) ...[
          if (i > 0) vSpace(8),
          Expanded(
            child: SelectableTileWidget(
              title: labelKey(position).tr(context: context),
              isSelected: selectedPositions.contains(position),
              onTap: () {
                HapticFeedback.selectionClick();
                onToggle(position);
              },
              height: 46,
              borderRadius: 12,
            ),
          ),
        ],
      ],
    );
  }
}
