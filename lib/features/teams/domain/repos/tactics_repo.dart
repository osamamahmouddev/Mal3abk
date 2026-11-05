import '../../data/models/tactics_board_model.dart';

abstract class TacticsRepo {
  Future<TacticsBoardModel?> load(String teamId);
  Future<void> save(String teamId, TacticsBoardModel board);
}
