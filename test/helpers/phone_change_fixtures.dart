import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/phone_change/data/models/start_phone_change_response_model.dart';
import 'package:mal3abk/features/phone_change/data/models/verify_new_phone_response_model.dart';

const testRequestId = '0192d4f8-1111-7000-8000-000000000001';

const stepUpToken = 'step-up-1';

final startResponse = StartPhoneChangeResponseModel(
  requestId: testRequestId,
  expiresAtUtc: DateTime.utc(2026, 10, 29, 12),
);

const verifyNewResponse = VerifyNewPhoneResponseModel(
  success: true,
  newPhoneNumber: '+201112345678',
);

const phoneInUseFailure = AppApiFailure(
  message: 'errors.identity.phone_in_use',
  code: 'Identity.PhoneNumberAlreadyInUse',
  statusCode: 409,
);
