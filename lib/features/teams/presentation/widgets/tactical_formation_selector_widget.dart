import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/widgets/custom_chip_widget.dart';
import '../../data/models/formation_model.dart';
import '../../data/models/tactics_board_model.dart';
import '../cubit/tactical_board_cubit.dart';

class TacticalFormationSelectorWidget extends StatelessWidget {
  const TacticalFormationSelectorWidget({required this.board, super.key});

  final TacticsBoardModel board;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final cubit = context.read<TacticalBoardCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8.w,
          children: [
            for (final size in const [5, 7, 11])
              CustomChipWidget(
                // Both sides have the same number: "٥ ضد ٥".
                label: 'teams.tactics.size'.tr(
                  context: context,
                  args: [
                    size.toLocalizedDigits(lang),
                    size.toLocalizedDigits(lang),
                  ],
                ),
                isSelected: board.playersPerSide == size,
                onTap: () {
                  HapticFeedback.lightImpact();
                  cubit.changeSize(size);
                },
              ),
          ],
        ),
        hSpace(8),
        Wrap(
          spacing: 8.w,
          children: [
            for (final formation in FormationModel.forSize(
              board.playersPerSide,
            ))
              CustomChipWidget(
                label: formation.name,
                isSelected: board.formationName == formation.name,
                onTap: () {
                  HapticFeedback.lightImpact();
                  cubit.changeFormation(formation);
                },
              ),
          ],
        ),
      ],
    );
  }
}
