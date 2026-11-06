import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState.initial() = _Initial;
  const factory SplashState.loading() = SplashLoading;
  const factory SplashState.authenticated() = SplashAuthenticated;
  const factory SplashState.unauthenticated() = SplashUnauthenticated;

  /// Signed in, but the app lock asks for a biometric check first.
  const factory SplashState.locked() = SplashLocked;
}
