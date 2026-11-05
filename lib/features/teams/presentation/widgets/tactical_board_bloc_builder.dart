import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_skeleton_widget.dart';
import '../cubit/tactical_board_cubit.dart';
import '../cubit/tactical_board_state.dart';
import 'tactical_bench_widget.dart';
import 'tactical_formation_selector_widget.dart';
import 'tactical_pitch_painter.dart';
import 'tactical_player_disc_widget.dart';

class TacticalBoardBlocBuilder extends StatelessWidget {
  const TacticalBoardBlocBuilder({required this.names, super.key});

  /// Player id -> display name, from the team roster.
  final Map<String, String> names;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TacticalBoardCubit, TacticalBoardState>(
      builder: (context, state) {
        if (state is! TacticalBoardSuccess) {
          return const CustomSkeletonWidget(height: 480, borderRadius: 18);
        }
        final board = state.board;
        final positions = board.formation.positions;
        final cubit = context.read<TacticalBoardCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TacticalFormationSelectorWidget(board: board),
            hSpace(12),
            ClipRRect(
              borderRadius: BorderRadius.circular(18.r),
              child: AspectRatio(
                aspectRatio: 0.68,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final w = constraints.maxWidth;
                    final h = constraints.maxHeight;
                    return Stack(
                      children: [
                        const Positioned.fill(
                          child: CustomPaint(painter: TacticalPitchPainter()),
                        ),
                        for (final (slot, position) in positions.indexed)
                          AnimatedPositioned(
                            key: ValueKey('slot-$slot'),
                            duration: const Duration(milliseconds: 260),
                            curve: Curves.easeOutCubic,
                            left: position.dx * w - 36.w,
                            top: (1 - position.dy) * h - 28.r,
                            child: TacticalPlayerDiscWidget(
                              slot: slot,
                              label: switch (board.slots[slot]) {
                                final id? => (names[id] ?? '؟').initials,
                                null => '+',
                              },
                              name: switch (board.slots[slot]) {
                                final id? => names[id] ?? '',
                                null => 'teams.tactics.empty'.tr(
                                  context: context,
                                ),
                              },
                              isSelected: state.selectedSlot == slot,
                              isGoalkeeper: slot == 0,
                              onTap: () => cubit.tapSlot(slot),
                              onSwap: cubit.swap,
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
            hSpace(8),
            Text(
              'teams.tactics.hint'.tr(context: context),
              style: AppTextStyles.font12Regular,
              textAlign: TextAlign.center,
            ),
            hSpace(14),
            TacticalBenchWidget(board: board, names: names),
          ],
        );
      },
    );
  }
}
