import '../../features/reference/data/models/governorate_model.dart';

/// Turns the city and area codes the API stores (`cairo`, `nasr_city`) into
/// names a player can read, in their language.
class LocationNames {
  const LocationNames._();

  /// "مدينة نصر، القاهرة" (or "Nasr City, Cairo"). Falls back to a tidied-up
  /// version of the raw value when the reference list has no match yet.
  static String display({
    required String languageCode,
    required List<GovernorateModel> governorates,
    String? city,
    String? area,
  }) {
    final governorate = _governorate(governorates, city);
    final cityName = governorate?.nameFor(languageCode) ?? _tidy(city);
    final areaName = _areaName(governorate, area, languageCode) ?? _tidy(area);
    final separator = languageCode == 'ar' ? '، ' : ', ';
    return [areaName, cityName].where((p) => p.isNotEmpty).join(separator);
  }

  static GovernorateModel? _governorate(
    List<GovernorateModel> governorates,
    String? city,
  ) {
    if (city == null || city.trim().isEmpty) return null;
    return governorates.where((g) => g.matches(city)).firstOrNull;
  }

  static String? _areaName(
    GovernorateModel? governorate,
    String? area,
    String languageCode,
  ) {
    if (governorate == null || area == null || area.trim().isEmpty) {
      return null;
    }
    final key = area.trim().toLowerCase();
    final match = governorate.areas
        .where(
          (a) =>
              a.code.toLowerCase() == key ||
              a.nameEn.toLowerCase() == key ||
              a.nameAr == area.trim(),
        )
        .firstOrNull;
    return match?.nameFor(languageCode);
  }

  /// "nasr_city" → "Nasr City".
  static String _tidy(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return '';
    return text
        .split(RegExp(r'[_\s]+'))
        .where((word) => word.isNotEmpty)
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .join(' ');
  }
}
