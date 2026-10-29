import '../../../../core/network/api_result.dart';
import '../../../auth/domain/use_cases/normalize_phone_number_use_case.dart';
import '../../data/models/start_phone_change_request_body.dart';
import '../../data/models/start_phone_change_response_model.dart';
import '../../data/models/step_up_response_model.dart';
import '../repos/phone_change_repo.dart';

/// Validates the new number, gets a 5-minute step-up token, then starts the
/// change; the API sends a code to the current phone.
class StartPhoneChangeUseCase {
  StartPhoneChangeUseCase({
    required this.phoneChangeRepo,
    required this.normalizePhoneNumberUseCase,
  });

  final PhoneChangeRepo phoneChangeRepo;
  final NormalizePhoneNumberUseCase normalizePhoneNumberUseCase;

  Future<ApiResult<StartPhoneChangeResponseModel>> call(
    String rawNewPhoneNumber,
  ) async {
    final phoneResult = normalizePhoneNumberUseCase(rawNewPhoneNumber);
    if (phoneResult case ApiFailure(:final failure)) {
      return ApiResult.failure(failure);
    }
    final newPhoneNumber = (phoneResult as Success<String>).data;

    final stepUpResult = await phoneChangeRepo.stepUp();
    if (stepUpResult case ApiFailure(:final failure)) {
      return ApiResult.failure(failure);
    }
    final stepUp = (stepUpResult as Success<StepUpResponseModel>).data;

    return phoneChangeRepo.startPhoneChange(
      StartPhoneChangeRequestBody(
        newPhoneNumber: newPhoneNumber,
        stepUpToken: stepUp.stepUpToken,
      ),
    );
  }
}
