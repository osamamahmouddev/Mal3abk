import '../../../../core/network/api_result.dart';
import '../../../auth/domain/use_cases/normalize_phone_number_use_case.dart';
import '../../data/models/start_phone_change_request_body.dart';
import '../../data/models/start_phone_change_response_model.dart';
import '../repos/phone_change_repo.dart';

/// Validates the new number, then starts the change with a step-up token for
/// `change_phone`; the API sends a code to the current phone.
class StartPhoneChangeUseCase {
  StartPhoneChangeUseCase({
    required this.phoneChangeRepo,
    required this.normalizePhoneNumberUseCase,
  });

  final PhoneChangeRepo phoneChangeRepo;
  final NormalizePhoneNumberUseCase normalizePhoneNumberUseCase;

  /// The number in E.164 form, so it can be checked before asking the player
  /// to re-verify.
  ApiResult<String> validate(String rawNewPhoneNumber) =>
      normalizePhoneNumberUseCase(rawNewPhoneNumber);

  Future<ApiResult<StartPhoneChangeResponseModel>> call(
    String rawNewPhoneNumber, {
    required String stepUpToken,
  }) async {
    return validate(rawNewPhoneNumber).when(
      success: (newPhoneNumber) => phoneChangeRepo.startPhoneChange(
        StartPhoneChangeRequestBody(
          newPhoneNumber: newPhoneNumber,
          stepUpToken: stepUpToken,
        ),
      ),
      failure: (failure) async => ApiResult.failure(failure),
    );
  }
}
