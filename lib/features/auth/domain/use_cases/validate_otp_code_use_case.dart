import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';

/// The API sends 6-digit codes; this rejects anything else before a request
/// spends one of the limited verification attempts.
class ValidateOtpCodeUseCase {
  ValidateOtpCodeUseCase();

  static final RegExp _sixDigits = RegExp(r'^\d{6}$');

  ApiResult<String> call(String rawCode) {
    final code = rawCode.toLatinDigits().trim();
    if (!_sixDigits.hasMatch(code)) {
      return const ApiResult.failure(
        AppApiFailure(
          message: 'errors.identity.otp_format',
          code: 'otp.invalid_format',
        ),
      );
    }
    return ApiResult.success(code);
  }
}
