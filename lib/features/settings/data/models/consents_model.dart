import 'package:json_annotation/json_annotation.dart';

part 'consents_model.g.dart';

@JsonSerializable()
class ConsentModel {
  const ConsentModel({
    required this.type,
    required this.granted,
    this.version,
    required this.recordedAtUtc,
  });

  final String type;
  final bool granted;
  final String? version;
  final DateTime recordedAtUtc;

  factory ConsentModel.fromJson(Map<String, dynamic> json) =>
      _$ConsentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConsentModelToJson(this);
}

@JsonSerializable()
class ConsentsModel {
  const ConsentsModel({this.current = const [], this.history = const []});

  final List<ConsentModel> current;
  final List<ConsentModel> history;

  bool isGranted(String type) =>
      current.where((c) => c.type == type).firstOrNull?.granted ?? false;

  factory ConsentsModel.fromJson(Map<String, dynamic> json) =>
      _$ConsentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConsentsModelToJson(this);
}
