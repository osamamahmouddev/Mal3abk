import 'package:json_annotation/json_annotation.dart';

import 'formation_model.dart';

part 'tactics_board_model.g.dart';

/// A team's saved line-up: format, formation and which player stands in each slot.
@JsonSerializable()
class TacticsBoardModel {
  const TacticsBoardModel({
    required this.playersPerSide,
    required this.formationName,
    required this.slots,
  });

  final int playersPerSide;
  final String formationName;
  final List<String?> slots;

  FormationModel get formation =>
      FormationModel.forSize(playersPerSide).firstWhere(
        (f) => f.name == formationName,
        orElse: () => FormationModel.forSize(playersPerSide).first,
      );

  TacticsBoardModel copyWithSlots(List<String?> slots) => TacticsBoardModel(
    playersPerSide: playersPerSide,
    formationName: formationName,
    slots: slots,
  );

  factory TacticsBoardModel.fromJson(Map<String, dynamic> json) =>
      _$TacticsBoardModelFromJson(json);

  Map<String, dynamic> toJson() => _$TacticsBoardModelToJson(this);
}
