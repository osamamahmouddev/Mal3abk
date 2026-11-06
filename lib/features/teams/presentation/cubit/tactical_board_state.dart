import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/tactics_board_model.dart';

part 'tactical_board_state.freezed.dart';

@freezed
sealed class TacticalBoardState with _$TacticalBoardState {
  const factory TacticalBoardState.initial() = TacticalBoardInitial;
  const factory TacticalBoardState.loading() = TacticalBoardLoading;
  const factory TacticalBoardState.success(
    TacticsBoardModel board,
    int? selectedSlot,
  ) = TacticalBoardSuccess;
  const factory TacticalBoardState.error(String message) = TacticalBoardError;
}
