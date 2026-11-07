import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/utils/location_names.dart';
import 'package:mal3abk/features/reference/data/models/governorate_model.dart';
import 'package:mal3abk/features/reference/data/models/localized_item_model.dart';

const _cairo = GovernorateModel(
  code: 'cairo',
  nameAr: 'القاهرة',
  nameEn: 'Cairo',
  areas: [
    LocalizedItemModel(
      code: 'nasr_city',
      nameAr: 'مدينة نصر',
      nameEn: 'Nasr City',
    ),
  ],
);

void main() {
  test('shows Arabic names for codes', () {
    expect(
      LocationNames.display(
        languageCode: 'ar',
        governorates: const [_cairo],
        city: 'cairo',
        area: 'nasr_city',
      ),
      'مدينة نصر، القاهرة',
    );
  });

  test('shows English names in English', () {
    expect(
      LocationNames.display(
        languageCode: 'en',
        governorates: const [_cairo],
        city: 'Cairo',
        area: 'Nasr City',
      ),
      'Nasr City, Cairo',
    );
  });

  test('accepts the Arabic area name the profile picker stores', () {
    expect(
      LocationNames.display(
        languageCode: 'ar',
        governorates: const [_cairo],
        city: 'cairo',
        area: 'مدينة نصر',
      ),
      'مدينة نصر، القاهرة',
    );
  });

  test('tidies raw codes until the reference list has loaded', () {
    expect(
      LocationNames.display(
        languageCode: 'en',
        governorates: const [],
        city: 'cairo',
        area: 'nasr_city',
      ),
      'Nasr City, Cairo',
    );
  });

  test('is empty when nothing is set', () {
    expect(
      LocationNames.display(languageCode: 'ar', governorates: const []),
      '',
    );
  });
}
