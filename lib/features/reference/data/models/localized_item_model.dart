import 'package:json_annotation/json_annotation.dart';

part 'localized_item_model.g.dart';

@JsonSerializable()
class LocalizedItemModel {
  const LocalizedItemModel({
    required this.code,
    required this.nameAr,
    required this.nameEn,
  });

  final String code;
  final String nameAr;
  final String nameEn;

  String nameFor(String languageCode) => languageCode == 'ar' ? nameAr : nameEn;

  factory LocalizedItemModel.fromJson(Map<String, dynamic> json) =>
      _$LocalizedItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocalizedItemModelToJson(this);
}
