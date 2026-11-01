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
import '../../features/booking/data/apis/booking_api_service.dart';
import '../../features/booking/data/repos/booking_repo_impl.dart';
import '../../features/booking/domain/repos/booking_repo.dart';
import '../../features/booking/domain/use_cases/create_booking_use_case.dart';
import '../../features/booking/domain/use_cases/get_booking_quote_use_case.dart';
import '../../features/booking/domain/use_cases/get_my_bookings_use_case.dart';
import '../../features/booking/presentation/cubit/my_bookings_cubit.dart';
import '../../features/explore/data/apis/explore_api_service.dart';
import '../../features/explore/data/repos/explore_repo_impl.dart';
import '../../features/explore/domain/repos/explore_repo.dart';
import '../../features/explore/domain/use_cases/explore_venues_use_case.dart';
import '../../features/explore/domain/use_cases/get_venue_details_use_case.dart';
import '../../features/explore/domain/use_cases/get_venue_pitches_use_case.dart';
import '../../features/explore/presentation/cubit/explore_list_cubit.dart';
import '../../features/explore/presentation/cubit/venue_profile_cubit.dart';
import '../../features/booking/domain/use_cases/get_booking_detail_use_case.dart';
import '../../features/booking/domain/use_cases/submit_booking_proof_use_case.dart';
import '../../features/booking/presentation/cubit/proof_upload_cubit.dart';
import '../../features/explore/domain/use_cases/get_venue_availability_use_case.dart';
import '../../features/explore/domain/use_cases/get_venue_payment_methods_use_case.dart';
import '../../features/explore/presentation/cubit/pitch_booking_cubit.dart';
import '../../features/home/data/apis/home_api_service.dart';
import '../../features/home/data/repos/home_repo_impl.dart';
import '../../features/home/domain/repos/home_repo.dart';
import '../../features/home/domain/use_cases/get_home_feed_use_case.dart';
import '../../features/home/presentation/cubit/home_feed_cubit.dart';
import '../../features/onboarding/presentation/cubit/profile_setup_cubit.dart';
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
import '../../features/profile/data/apis/profile_api_service.dart';
import '../../features/profile/data/repos/profile_repo_impl.dart';
import '../../features/profile/domain/repos/profile_repo.dart';
import '../../features/profile/domain/use_cases/complete_profile_use_case.dart';
import '../../features/profile/domain/use_cases/get_my_profile_use_case.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
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

  // Profile & Onboarding Feature
  sl.registerLazySingleton<ProfileApiService>(
    () => ProfileApiService(sl<Dio>()),
  );
  sl.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(profileApiService: sl<ProfileApiService>()),
  );
  sl.registerLazySingleton<GetMyProfileUseCase>(
    () => GetMyProfileUseCase(profileRepo: sl<ProfileRepo>()),
  );
  sl.registerLazySingleton<CompleteProfileUseCase>(
    () => CompleteProfileUseCase(profileRepo: sl<ProfileRepo>()),
  );
  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(getMyProfileUseCase: sl<GetMyProfileUseCase>()),
  );
  sl.registerFactory<ProfileSetupCubit>(
    () =>
        ProfileSetupCubit(completeProfileUseCase: sl<CompleteProfileUseCase>()),
  );

  // Explore Feature
  sl.registerLazySingleton<ExploreApiService>(
    () => ExploreApiService(sl<Dio>()),
  );
  sl.registerLazySingleton<ExploreRepo>(
    () => ExploreRepoImpl(exploreApiService: sl<ExploreApiService>()),
  );
  sl.registerLazySingleton<ExploreVenuesUseCase>(
    () => ExploreVenuesUseCase(exploreRepo: sl<ExploreRepo>()),
  );
  sl.registerLazySingleton<GetVenueDetailsUseCase>(
    () => GetVenueDetailsUseCase(exploreRepo: sl<ExploreRepo>()),
  );
  sl.registerLazySingleton<GetVenuePitchesUseCase>(
    () => GetVenuePitchesUseCase(exploreRepo: sl<ExploreRepo>()),
  );
  sl.registerLazySingleton<GetVenueAvailabilityUseCase>(
    () => GetVenueAvailabilityUseCase(exploreRepo: sl<ExploreRepo>()),
  );
  sl.registerLazySingleton<GetVenuePaymentMethodsUseCase>(
    () => GetVenuePaymentMethodsUseCase(exploreRepo: sl<ExploreRepo>()),
  );
  sl.registerFactory<ExploreListCubit>(
    () => ExploreListCubit(exploreVenuesUseCase: sl<ExploreVenuesUseCase>()),
  );
  sl.registerFactory<VenueProfileCubit>(
    () => VenueProfileCubit(
      getVenueDetailsUseCase: sl<GetVenueDetailsUseCase>(),
      getVenuePitchesUseCase: sl<GetVenuePitchesUseCase>(),
    ),
  );
  sl.registerFactory<PitchBookingCubit>(
    () => PitchBookingCubit(
      getVenueAvailabilityUseCase: sl<GetVenueAvailabilityUseCase>(),
      getVenuePaymentMethodsUseCase: sl<GetVenuePaymentMethodsUseCase>(),
      getBookingQuoteUseCase: sl<GetBookingQuoteUseCase>(),
      createBookingUseCase: sl<CreateBookingUseCase>(),
    ),
  );

  // Home Feature
  sl.registerLazySingleton<HomeApiService>(() => HomeApiService(sl<Dio>()));
  sl.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(homeApiService: sl<HomeApiService>()),
  );
  sl.registerLazySingleton<GetHomeFeedUseCase>(
    () => GetHomeFeedUseCase(homeRepo: sl<HomeRepo>()),
  );
  sl.registerFactory<HomeFeedCubit>(
    () => HomeFeedCubit(getHomeFeedUseCase: sl<GetHomeFeedUseCase>()),
  );

  // Booking Feature
  sl.registerLazySingleton<BookingApiService>(
    () => BookingApiService(sl<Dio>()),
  );
  sl.registerLazySingleton<BookingRepo>(
    () => BookingRepoImpl(
      bookingApiService: sl<BookingApiService>(),
      dio: sl<Dio>(),
    ),
  );
  sl.registerLazySingleton<GetBookingQuoteUseCase>(
    () => GetBookingQuoteUseCase(bookingRepo: sl<BookingRepo>()),
  );
  sl.registerLazySingleton<CreateBookingUseCase>(
    () => CreateBookingUseCase(bookingRepo: sl<BookingRepo>()),
  );
  sl.registerLazySingleton<GetMyBookingsUseCase>(
    () => GetMyBookingsUseCase(bookingRepo: sl<BookingRepo>()),
  );
  sl.registerLazySingleton<GetBookingDetailUseCase>(
    () => GetBookingDetailUseCase(bookingRepo: sl<BookingRepo>()),
  );
  sl.registerLazySingleton<SubmitBookingProofUseCase>(
    () => SubmitBookingProofUseCase(bookingRepo: sl<BookingRepo>()),
  );
  sl.registerFactory<MyBookingsCubit>(
    () => MyBookingsCubit(getMyBookingsUseCase: sl<GetMyBookingsUseCase>()),
  );
  sl.registerFactory<ProofUploadCubit>(
    () => ProofUploadCubit(
      submitBookingProofUseCase: sl<SubmitBookingProofUseCase>(),
    ),
  );
}
