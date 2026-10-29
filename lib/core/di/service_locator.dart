import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/apis/auth_api_service.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../../features/auth/domain/use_cases/logout_all_use_case.dart';
import '../../features/auth/domain/use_cases/logout_use_case.dart';
import '../../features/auth/domain/use_cases/normalize_phone_number_use_case.dart';
import '../../features/auth/domain/use_cases/send_otp_use_case.dart';
import '../../features/auth/domain/use_cases/validate_otp_code_use_case.dart';
import '../../features/auth/domain/use_cases/verify_otp_use_case.dart';
import '../../features/auth/presentation/cubit/logout_cubit.dart';
import '../../features/auth/presentation/cubit/send_otp_cubit.dart';
import '../../features/auth/presentation/cubit/verify_otp_cubit.dart';
import '../../features/phone_change/data/apis/phone_change_api_service.dart';
import '../../features/phone_change/data/repos/phone_change_repo_impl.dart';
import '../../features/phone_change/domain/repos/phone_change_repo.dart';
import '../../features/phone_change/domain/use_cases/recover_phone_use_case.dart';
import '../../features/phone_change/domain/use_cases/start_phone_change_use_case.dart';
import '../../features/phone_change/domain/use_cases/verify_new_phone_use_case.dart';
import '../../features/phone_change/domain/use_cases/verify_old_phone_use_case.dart';
import '../../features/phone_change/presentation/cubit/recover_phone_cubit.dart';
import '../../features/phone_change/presentation/cubit/start_phone_change_cubit.dart';
import '../../features/phone_change/presentation/cubit/verify_new_phone_cubit.dart';
import '../../features/phone_change/presentation/cubit/verify_old_phone_cubit.dart';
import '../../features/splash/data/repos/splash_repo_impl.dart';
import '../../features/splash/domain/repos/splash_repo.dart';
import '../../features/splash/domain/use_cases/check_auth_status_use_case.dart';
import '../../features/splash/presentation/cubit/splash_cubit.dart';
import '../config/env_config.dart';
import '../local_storage/auth_token_storage.dart';
import '../local_storage/device_id_storage.dart';
import '../network/auth_interceptor.dart';
import '../network/dio_factory.dart';
import '../network/token_refresh_api_service.dart';
import '../network/turnstile_token_provider.dart';
import '../routes/app_navigator.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator(EnvConfig envConfig) async {
  if (sl.isRegistered<EnvConfig>()) return;

  // Environment & External
  sl.registerSingleton<EnvConfig>(envConfig);
  sl.registerLazySingleton<AuthTokenStorage>(AuthTokenStorage.new);
  sl.registerLazySingleton<DeviceIdStorage>(DeviceIdStorage.new);
  sl.registerLazySingleton<TurnstileTokenProvider>(
    () => TurnstileTokenProvider(envConfig: sl<EnvConfig>()),
  );
  // The refresh call runs on its own Dio without AuthInterceptor.
  sl.registerLazySingleton<TokenRefreshApiService>(
    () => TokenRefreshApiService(
      DioFactory.createDio(
        envConfig: sl<EnvConfig>(),
        deviceIdStorage: sl<DeviceIdStorage>(),
      ),
    ),
  );
  sl.registerLazySingleton<Dio>(() {
    final dio = DioFactory.createDio(
      envConfig: sl<EnvConfig>(),
      deviceIdStorage: sl<DeviceIdStorage>(),
    );
    dio.interceptors.add(
      AuthInterceptor(
        dio: dio,
        tokenStorage: sl<AuthTokenStorage>(),
        tokenRefreshApiService: sl<TokenRefreshApiService>(),
        onSessionExpired: AppNavigator.openLogin,
      ),
    );
    return dio;
  });

  // Splash Feature
  sl.registerLazySingleton<SplashRepo>(
    () => SplashRepoImpl(tokenStorage: sl<AuthTokenStorage>()),
  );
  sl.registerLazySingleton<CheckAuthStatusUseCase>(
    () => CheckAuthStatusUseCase(splashRepo: sl<SplashRepo>()),
  );
  sl.registerFactory<SplashCubit>(
    () => SplashCubit(checkAuthStatusUseCase: sl<CheckAuthStatusUseCase>()),
  );

  // Auth Feature
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService(sl<Dio>()));
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      authApiService: sl<AuthApiService>(),
      tokenStorage: sl<AuthTokenStorage>(),
      turnstileTokenProvider: sl<TurnstileTokenProvider>(),
    ),
  );
  sl.registerLazySingleton<NormalizePhoneNumberUseCase>(
    NormalizePhoneNumberUseCase.new,
  );
  sl.registerLazySingleton<ValidateOtpCodeUseCase>(ValidateOtpCodeUseCase.new);
  sl.registerLazySingleton<SendOtpUseCase>(
    () => SendOtpUseCase(
      authRepo: sl<AuthRepo>(),
      normalizePhoneNumberUseCase: sl<NormalizePhoneNumberUseCase>(),
    ),
  );
  sl.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(
      authRepo: sl<AuthRepo>(),
      validateOtpCodeUseCase: sl<ValidateOtpCodeUseCase>(),
    ),
  );
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(authRepo: sl<AuthRepo>()),
  );
  sl.registerLazySingleton<LogoutAllUseCase>(
    () => LogoutAllUseCase(authRepo: sl<AuthRepo>()),
  );
  sl.registerFactory<SendOtpCubit>(
    () => SendOtpCubit(sendOtpUseCase: sl<SendOtpUseCase>()),
  );
  sl.registerFactory<VerifyOtpCubit>(
    () => VerifyOtpCubit(verifyOtpUseCase: sl<VerifyOtpUseCase>()),
  );
  sl.registerFactory<LogoutCubit>(
    () => LogoutCubit(
      logoutUseCase: sl<LogoutUseCase>(),
      logoutAllUseCase: sl<LogoutAllUseCase>(),
    ),
  );

  // Phone Change Feature
  sl.registerLazySingleton<PhoneChangeApiService>(
    () => PhoneChangeApiService(sl<Dio>()),
  );
  sl.registerLazySingleton<PhoneChangeRepo>(
    () =>
        PhoneChangeRepoImpl(phoneChangeApiService: sl<PhoneChangeApiService>()),
  );
  sl.registerLazySingleton<StartPhoneChangeUseCase>(
    () => StartPhoneChangeUseCase(
      phoneChangeRepo: sl<PhoneChangeRepo>(),
      normalizePhoneNumberUseCase: sl<NormalizePhoneNumberUseCase>(),
    ),
  );
  sl.registerLazySingleton<VerifyOldPhoneUseCase>(
    () => VerifyOldPhoneUseCase(
      phoneChangeRepo: sl<PhoneChangeRepo>(),
      validateOtpCodeUseCase: sl<ValidateOtpCodeUseCase>(),
    ),
  );
  sl.registerLazySingleton<VerifyNewPhoneUseCase>(
    () => VerifyNewPhoneUseCase(
      phoneChangeRepo: sl<PhoneChangeRepo>(),
      authRepo: sl<AuthRepo>(),
      validateOtpCodeUseCase: sl<ValidateOtpCodeUseCase>(),
    ),
  );
  sl.registerLazySingleton<RecoverPhoneUseCase>(
    () => RecoverPhoneUseCase(
      phoneChangeRepo: sl<PhoneChangeRepo>(),
      authRepo: sl<AuthRepo>(),
    ),
  );
  sl.registerFactory<StartPhoneChangeCubit>(
    () => StartPhoneChangeCubit(
      startPhoneChangeUseCase: sl<StartPhoneChangeUseCase>(),
    ),
  );
  sl.registerFactory<VerifyOldPhoneCubit>(
    () =>
        VerifyOldPhoneCubit(verifyOldPhoneUseCase: sl<VerifyOldPhoneUseCase>()),
  );
  sl.registerFactory<VerifyNewPhoneCubit>(
    () =>
        VerifyNewPhoneCubit(verifyNewPhoneUseCase: sl<VerifyNewPhoneUseCase>()),
  );
  sl.registerFactory<RecoverPhoneCubit>(
    () => RecoverPhoneCubit(recoverPhoneUseCase: sl<RecoverPhoneUseCase>()),
  );
}
