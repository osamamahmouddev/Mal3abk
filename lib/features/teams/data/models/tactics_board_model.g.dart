// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tactics_board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TacticsBoardModel _$TacticsBoardModelFromJson(Map<String, dynamic> json) =>
    TacticsBoardModel(
      playersPerSide: (json['playersPerSide'] as num).toInt(),
      formationName: json['formationName'] as String,
      slots: (json['slots'] as List<dynamic>).map((e) => e as String?).toList(),
    );

Map<String, dynamic> _$TacticsBoardModelToJson(TacticsBoardModel instance) =>
    <String, dynamic>{
      'playersPerSide': instance.playersPerSide,
      'formationName': instance.formationName,
      'slots': instance.slots,
    };
