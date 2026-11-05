import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/formation_model.dart';
import '../../data/models/tactics_board_model.dart';
import '../../domain/repos/tactics_repo.dart';
import 'tactical_board_state.dart';

class TacticalBoardCubit extends Cubit<TacticalBoardState>
    with SafeEmitCubitMixin<TacticalBoardState> {
  TacticalBoardCubit({required this.tacticsRepo})
    : super(const TacticalBoardState.initial());

  final TacticsRepo tacticsRepo;
  late String teamId;
  late List<String> squad;

  Future<void> load(String teamId, List<String> squadPlayerIds) async {
    this.teamId = teamId;
    squad = squadPlayerIds;
    emitIfOpen(const TacticalBoardState.loading());
    final saved = await tacticsRepo.load(teamId);
    final size = saved?.playersPerSide ?? defaultSize(squad.length);
    final formation = saved?.formation ?? FormationModel.forSize(size).first;
    emitIfOpen(
      TacticalBoardState.success(
        arrange(formation, size, saved?.slots ?? const []),
        null,
      ),
    );
  }

  void changeSize(int playersPerSide) =>
      apply(FormationModel.forSize(playersPerSide).first, playersPerSide);

  void changeFormation(FormationModel formation) {
    final current = state;
    if (current is TacticalBoardSuccess) {
      apply(formation, current.board.playersPerSide);
    }
  }

  /// First tap selects a slot; a second tap on another slot swaps the two.
  void tapSlot(int slot) {
    final current = state;
    if (current is! TacticalBoardSuccess) return;
    final selected = current.selectedSlot;
    if (selected == null || selected == slot) {
      emitIfOpen(
        TacticalBoardState.success(
          current.board,
          selected == slot ? null : slot,
        ),
      );
      return;
    }
    swap(selected, slot);
  }

  void swap(int from, int to) {
    final current = state;
    if (current is! TacticalBoardSuccess || from == to) return;
    final slots = [...current.board.slots];
    final moved = slots[from];
    slots[from] = slots[to];
    slots[to] = moved;
    persist(current.board.copyWithSlots(slots));
  }

  /// Puts a bench player into the selected slot (or the first empty one).
  void benchToPitch(String playerId) {
    final current = state;
    if (current is! TacticalBoardSuccess) return;
    final slots = [...current.board.slots];
    final target = current.selectedSlot ?? slots.indexOf(null);
    if (target < 0) return;
    slots[target] = playerId;
    persist(current.board.copyWithSlots(slots));
  }

  void apply(FormationModel formation, int size) {
    final current = state;
    final keep = current is TacticalBoardSuccess
        ? current.board.slots
        : const <String?>[];
    persist(arrange(formation, size, keep));
  }

  TacticsBoardModel arrange(
    FormationModel formation,
    int size,
    List<String?> previous,
  ) {
    final onPitch = previous.whereType<String>().where(squad.contains).toList();
    final bench = squad.where((id) => !onPitch.contains(id));
    final ordered = [...onPitch, ...bench];
    return TacticsBoardModel(
      playersPerSide: size,
      formationName: formation.name,
      slots: List.generate(
        formation.playerCount,
        (i) => i < ordered.length ? ordered[i] : null,
      ),
    );
  }

  void persist(TacticsBoardModel board) {
    emitIfOpen(TacticalBoardState.success(board, null));
    tacticsRepo.save(teamId, board);
  }

  static int defaultSize(int squadSize) => squadSize >= 11
      ? 11
      : squadSize >= 7
      ? 7
      : 5;
}
