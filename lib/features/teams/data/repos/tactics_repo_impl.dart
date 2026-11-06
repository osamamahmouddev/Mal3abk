import 'dart:convert';

import '../../../../core/local_storage/secure_storage.dart';
import '../../domain/repos/tactics_repo.dart';
import '../models/tactics_board_model.dart';

/// Line-ups are a captain's private planning, so they stay on the device.
class TacticsRepoImpl implements TacticsRepo {
  const TacticsRepoImpl();

  static String keyFor(String teamId) => 'tactics_board_$teamId';

  @override
  Future<TacticsBoardModel?> load(String teamId) async {
    final raw = await SharedPrefHelper.getString(keyFor(teamId));
    if (raw.isEmpty) return null;
    try {
      return TacticsBoardModel.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } on FormatException {
      return null;
    }
  }

  @override
  Future<void> save(String teamId, TacticsBoardModel board) =>
      SharedPrefHelper.setData(keyFor(teamId), jsonEncode(board.toJson()));
}
