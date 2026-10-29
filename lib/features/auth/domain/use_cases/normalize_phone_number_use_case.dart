import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';

/// Validates an Egyptian mobile number (010, 011, 012, 015) and returns it
/// in E.164 form (`+201XXXXXXXXX`), matching the API's normalization.
class NormalizePhoneNumberUseCase {
  NormalizePhoneNumberUseCase();

  static final RegExp _nonDigits = RegExp(r'\D');
  static final RegExp _nationalMobile = RegExp(r'^1[0125]\d{8}$');

  ApiResult<String> call(String rawPhoneNumber) {
    final digits = rawPhoneNumber.toLatinDigits().replaceAll(_nonDigits, '');
    final national = switch (digits) {
      final d when d.startsWith('0020') => d.substring(4),
      final d when d.startsWith('20') && d.length == 12 => d.substring(2),
      final d when d.startsWith('0') => d.substring(1),
      final d => d,
    };

    if (!_nationalMobile.hasMatch(national)) {
      return const ApiResult.failure(
        AppApiFailure(
          message: 'errors.identity.invalid_phone',
          code: 'PhoneNumber.InvalidEgyptianNumber',
        ),
      );
    }
    return ApiResult.success('+20$national');
  }
}
