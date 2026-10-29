import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/features/auth/data/models/send_otp_response_model.dart';
import 'package:mal3abk/features/auth/data/models/verify_otp_response_model.dart';

const testPhoneNumber = '+201012345678';
const testCode = '123456';

const sendOtpResponse = SendOtpResponseModel(
  normalizedPhoneNumber: testPhoneNumber,
  expiresInSeconds: 300,
);

const verifyOtpResponse = VerifyOtpResponseModel(
  userId: 'user-1',
  phoneNumber: testPhoneNumber,
  fullName: 'Player',
  roles: ['Player'],
  isNewUser: false,
  accessToken: 'access-1',
  refreshToken: 'refresh-1',
  expiresIn: 900,
);

const serverFailure = AppApiFailure(
  message: 'errors.identity.invalid_otp',
  code: 'Identity.InvalidOtpCode',
  statusCode: 400,
);
