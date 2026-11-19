import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/app_api_failure.dart';
import '../../../../core/services/firebase_phone_auth_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../core/utils/safe_emit_cubit_mixin.dart';
import '../../data/models/send_otp_response_model.dart';
import '../../domain/use_cases/normalize_phone_number_use_case.dart';
import '../../domain/use_cases/send_otp_use_case.dart';
import 'send_otp_state.dart';

/// Sends the sign-in code. With [firebasePhoneAuth] set, Firebase texts the
/// code; when Firebase cannot (quota, missing setup, no Play services), the
/// API sends its own code instead so the player can still sign in.
class SendOtpCubit extends Cubit<SendOtpState>
    with SafeEmitCubitMixin<SendOtpState> {
  SendOtpCubit({
    required this.sendOtpUseCase,
    this.normalizePhoneNumberUseCase,
    this.firebasePhoneAuth,
  }) : super(const SendOtpState.initial());

  final SendOtpUseCase sendOtpUseCase;
  final NormalizePhoneNumberUseCase? normalizePhoneNumberUseCase;
  final FirebasePhoneAuthService? firebasePhoneAuth;

  /// How long a Firebase SMS code stays usable, shown like the API's expiry.
  static const int firebaseCodeLifetimeSeconds = 300;

  Future<void> sendOtp(String phoneNumber) async {
    final current = state;
    if (current is SendOtpLoading) return;
    if (current is SendOtpError && _isFuture(current.retryAt)) return;
    emitIfOpen(const SendOtpState.loading());

    final normalize = normalizePhoneNumberUseCase;
    if (firebasePhoneAuth != null && normalize != null) {
      final normalized = normalize(phoneNumber);
      if (normalized case ApiFailure(:final failure)) {
        emitIfOpen(SendOtpState.error(failure.message));
        return;
      }
      final normalizedPhone = (normalized as Success<String>).data;
      // Apple review test account bypasses Firebase SMS entirely and hits the backend directly
      if (normalizedPhone != '+201000000999') {
        final sent = await _sendWithFirebase(normalizedPhone);
        if (sent != null) {
          emitIfOpen(sent);
          return;
        }
      }
    }

    final result = await sendOtpUseCase(phoneNumber);
    result.when(
      success: (data) => emitIfOpen(SendOtpState.success(data)),
      failure: (failure) {
        AppLogger.e(
          'Send OTP failed: HTTP ${failure.statusCode} | Code: ${failure.code} | Message: ${failure.message}',
        );
        emitIfOpen(
          SendOtpState.error(failure.message, retryAt: _retryAt(failure)),
        );
      },
    );
  }

  /// Sends a new code to the number already shown, staying on the code step.
  Future<void> resend() async {
    final current = state;
    if (current is! SendOtpSuccess || current.resending) return;
    emitIfOpen(current.copyWith(resending: true, resendError: null));
    final phoneNumber = current.data.normalizedPhoneNumber;

    if (firebasePhoneAuth != null && current.verificationId != null) {
      final sent = await _sendWithFirebase(
        phoneNumber,
        resendToken: current.resendToken,
        sendCount: current.sendCount + 1,
      );
      if (sent != null) {
        emitIfOpen(sent);
        return;
      }
    }

    final result = await sendOtpUseCase(phoneNumber);
    result.when(
      success: (data) => emitIfOpen(
        SendOtpState.success(data, sendCount: current.sendCount + 1),
      ),
      failure: (failure) => emitIfOpen(
        current.copyWith(
          resending: false,
          resendError: failure.message,
          resendBlockedUntil: _retryAt(failure),
        ),
      ),
    );
  }

  /// The code step for a code Firebase sent, or null when Firebase could not
  /// send one and the API should.
  Future<SendOtpSuccess?> _sendWithFirebase(
    String phoneNumber, {
    int? resendToken,
    int sendCount = 1,
  }) async {
    final data = SendOtpResponseModel(
      normalizedPhoneNumber: phoneNumber,
      expiresInSeconds: firebaseCodeLifetimeSeconds,
    );
    final result = await firebasePhoneAuth!.sendCode(
      phoneNumber: phoneNumber,
      resendToken: resendToken,
      onAutoVerified: (credential) {
        final current = state;
        if (current is SendOtpSuccess &&
            current.data.normalizedPhoneNumber == phoneNumber) {
          emitIfOpen(current.copyWith(autoCredential: credential));
        }
      },
    );
    switch (result) {
      case FirebaseCodeSent(:final verificationId, resendToken: final token):
        return SendOtpSuccess(
          data,
          sendCount: sendCount,
          verificationId: verificationId,
          resendToken: token ?? resendToken,
        );
      case FirebaseAutoVerified(:final credential):
        return SendOtpSuccess(
          data,
          sendCount: sendCount,
          autoCredential: credential,
        );
      case FirebaseCodeFailed(:final code):
        AppLogger.w('Firebase could not send the code ($code); using the API');
        return null;
    }
  }

  /// When the server says how long to wait (429 + Retry-After), the moment
  /// the next code may be requested.
  DateTime? _retryAt(AppApiFailure failure) {
    final seconds = failure.extraData['retryAfterSeconds'];
    if (failure.statusCode != 429 || seconds is! int || seconds <= 0) {
      return null;
    }
    return DateTime.now().add(Duration(seconds: seconds));
  }

  bool _isFuture(DateTime? at) => at != null && at.isAfter(DateTime.now());

  void reset() => emitIfOpen(const SendOtpState.initial());
}
