import 'package:json_annotation/json_annotation.dart';

part 'my_profile_model.g.dart';

@JsonSerializable()
class MyProfileModel {
  const MyProfileModel({
    required this.userId,
    required this.fullName,
    required this.phoneNumber,
    this.email,
    this.city,
    this.area,
    this.positions = const [],
    this.skillLevel,
    this.language = 'ar',
    this.onboardingComplete = false,
    this.avatarUrl,
  });

  final String userId;
  final String fullName;
  final String phoneNumber;
  final String? email;
  final String? city;
  final String? area;
  final List<String> positions;
  final String? skillLevel;
  final String language;
  final bool onboardingComplete;
  final String? avatarUrl;

  factory MyProfileModel.fromJson(Map<String, dynamic> json) =>
      _$MyProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyProfileModelToJson(this);
}
