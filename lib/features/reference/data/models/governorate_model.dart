import 'package:json_annotation/json_annotation.dart';

import 'localized_item_model.dart';

part 'governorate_model.g.dart';

@JsonSerializable()
class GovernorateModel {
  const GovernorateModel({
    required this.code,
    required this.nameAr,
    required this.nameEn,
    this.areas = const [],
  });

  final String code;
  final String nameAr;
  final String nameEn;
  final List<LocalizedItemModel> areas;

  String nameFor(String languageCode) => languageCode == 'ar' ? nameAr : nameEn;

  factory GovernorateModel.fromJson(Map<String, dynamic> json) =>
      _$GovernorateModelFromJson(json);

  Map<String, dynamic> toJson() => _$GovernorateModelToJson(this);
}
