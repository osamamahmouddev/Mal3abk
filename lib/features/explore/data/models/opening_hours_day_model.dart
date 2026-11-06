import 'package:json_annotation/json_annotation.dart';

part 'opening_hours_day_model.g.dart';

@JsonSerializable()
class OpeningWindowModel {
  const OpeningWindowModel({required this.open, required this.close});

  final String open;
  final String close;

  factory OpeningWindowModel.fromJson(Map<String, dynamic> json) =>
      _$OpeningWindowModelFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningWindowModelToJson(this);
}

@JsonSerializable()
class OpeningHoursDayModel {
  const OpeningHoursDayModel({
    required this.day,
    required this.closed,
    required this.windows,
  });

  final int day;
  final bool closed;
  final List<OpeningWindowModel> windows;

  factory OpeningHoursDayModel.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursDayModelFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningHoursDayModelToJson(this);
}
