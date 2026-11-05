import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_chip_widget.dart';
import '../../data/models/tactics_board_model.dart';
import '../cubit/tactical_board_cubit.dart';

class TacticalBenchWidget extends StatelessWidget {
  const TacticalBenchWidget({
    required this.board,
    required this.names,
    super.key,
  });

  final TacticsBoardModel board;
  final Map<String, String> names;

  @override
  Widget build(BuildContext context) {
    final bench = names.keys.where((id) => !board.slots.contains(id)).toList();
    if (bench.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'teams.tactics.bench'.tr(context: context),
          style: AppTextStyles.font14Bold,
        ),
        hSpace(4),
        Text(
          'teams.tactics.bench_hint'.tr(context: context),
          style: AppTextStyles.font12Regular,
        ),
        hSpace(8),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            for (final id in bench)
              CustomChipWidget(
                label: names[id] ?? '—',
                isSelected: false,
                onTap: () {
                  HapticFeedback.lightImpact();
                  context.read<TacticalBoardCubit>().benchToPitch(id);
                },
              ),
          ],
        ),
      ],
    );
  }
}
