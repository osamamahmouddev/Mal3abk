import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/booking/presentation/cubit/booking_details_cubit.dart';
import '../../features/booking/presentation/cubit/cancel_booking_cubit.dart';
import '../../features/booking/presentation/cubit/deposit_methods_cubit.dart';
import '../../features/explore/presentation/cubit/favorite_toggle_cubit.dart';
import '../../features/reference/presentation/cubit/filter_options_cubit.dart';
import '../../features/explore/presentation/cubit/favorites_cubit.dart';
import '../../features/home/domain/use_cases/get_home_team_activity_use_case.dart';
import '../../features/home/presentation/cubit/home_team_activity_cubit.dart';
import '../../features/matches/data/apis/matches_api_service.dart';
import '../../features/notifications/data/apis/notifications_api_service.dart';
import '../../features/settings/data/apis/account_api_service.dart';
import '../../features/settings/data/repos/account_repo_impl.dart';
import '../../features/settings/domain/repos/account_repo.dart';
import '../../features/settings/domain/use_cases/delete_account_use_case.dart';
import '../../features/settings/presentation/cubit/account_action_cubit.dart';
import '../../features/settings/presentation/cubit/biometric_lock_cubit.dart';
import '../../features/settings/presentation/cubit/consents_cubit.dart';
import '../../features/settings/presentation/cubit/notification_preferences_cubit.dart';
import '../../features/settings/presentation/cubit/sessions_cubit.dart';
import '../../features/step_up/data/apis/step_up_api_service.dart';
import '../../features/step_up/data/repos/step_up_repo_impl.dart';
import '../../features/step_up/domain/repos/step_up_repo.dart';
import '../../features/step_up/presentation/cubit/step_up_cubit.dart';
import '../../features/notifications/data/repos/notifications_repo_impl.dart';
import '../../features/notifications/domain/repos/notifications_repo.dart';
import '../../features/notifications/presentation/cubit/notifications_cubit.dart';
import '../../features/notifications/presentation/cubit/unread_notifications_cubit.dart';
import '../../features/matches/data/repos/matches_repo_impl.dart';
import '../../features/matches/domain/repos/matches_repo.dart';
import '../../features/matches/domain/use_cases/get_challenge_details_use_case.dart';
import '../../features/matches/domain/use_cases/get_match_details_use_case.dart';
import '../../features/matches/domain/use_cases/respond_to_challenge_use_case.dart';
import '../../features/matches/domain/use_cases/send_challenge_use_case.dart';
import '../../features/matches/presentation/cubit/challenge_details_cubit.dart';
import '../../features/matches/presentation/cubit/challenge_response_cubit.dart';
import '../../features/matches/presentation/cubit/match_details_cubit.dart';
import '../../features/matches/presentation/cubit/match_result_cubit.dart';
import '../../features/matches/presentation/cubit/send_challenge_cubit.dart';
import '../security/biometric_lock.dart';
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
import '../../features/onboarding/presentation/cubit/avatar_cubit.dart';
import '../../features/onboarding/presentation/cubit/onboarding_consent_cubit.dart';
import '../../features/profile/domain/use_cases/get_profile_overview_use_case.dart';
import '../../features/profile/domain/use_cases/save_profile_use_case.dart';
import '../../features/profile/domain/use_cases/upload_avatar_use_case.dart';
import '../../features/profile/domain/use_cases/get_my_profile_use_case.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/splash/data/repos/splash_repo_impl.dart';
import '../../features/splash/domain/repos/splash_repo.dart';
import '../../features/splash/domain/use_cases/check_auth_status_use_case.dart';
import '../../features/splash/presentation/cubit/splash_cubit.dart';
import '../../features/reference/data/apis/reference_api_service.dart';
import '../../features/reference/data/repos/reference_repo_impl.dart';
import '../../features/reference/domain/repos/reference_repo.dart';
import '../../features/reference/presentation/cubit/governorates_cubit.dart';
import '../../features/teams/data/apis/teams_api_service.dart';
import '../../features/teams/data/repos/tactics_repo_impl.dart';
import '../../features/teams/data/repos/teams_repo_impl.dart';
import '../../features/teams/domain/repos/tactics_repo.dart';
import '../../features/teams/presentation/cubit/tactical_board_cubit.dart';
import '../../features/teams/domain/repos/teams_repo.dart';
import '../../features/teams/domain/use_cases/create_team_use_case.dart';
import '../../features/teams/domain/use_cases/get_leaderboard_use_case.dart';
import '../../features/teams/domain/use_cases/get_team_dashboard_use_case.dart';
import '../../features/teams/domain/use_cases/join_team_by_code_use_case.dart';
import '../../features/teams/presentation/cubit/create_team_cubit.dart';
import '../../features/teams/presentation/cubit/discover_teams_cubit.dart';
import '../../features/teams/presentation/cubit/join_team_cubit.dart';
import '../../features/teams/presentation/cubit/leaderboard_cubit.dart';
import '../../features/teams/presentation/cubit/my_teams_cubit.dart';
import '../../features/teams/presentation/cubit/team_action_cubit.dart';
import '../../features/teams/presentation/cubit/team_dashboard_cubit.dart';
import '../../features/teams/presentation/cubit/team_invite_cubit.dart';
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
  sl.registerLazySingleton<BiometricLock>(BiometricLock.new);
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
    () => SplashCubit(
      checkAuthStatusUseCase: sl<CheckAuthStatusUseCase>(),
      biometricLock: sl<BiometricLock>(),
    ),
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
    () => ProfileRepoImpl(
      profileApiService: sl<ProfileApiService>(),
      dio: sl<Dio>(),
    ),
  );
  sl.registerLazySingleton<GetMyProfileUseCase>(
    () => GetMyProfileUseCase(profileRepo: sl<ProfileRepo>()),
  );
  sl.registerLazySingleton<SaveProfileUseCase>(
    () => SaveProfileUseCase(profileRepo: sl<ProfileRepo>()),
  );
  sl.registerLazySingleton<UploadAvatarUseCase>(
    () => UploadAvatarUseCase(profileRepo: sl<ProfileRepo>()),
  );
  sl.registerLazySingleton<GetProfileOverviewUseCase>(
    () => GetProfileOverviewUseCase(
      profileRepo: sl<ProfileRepo>(),
      teamsRepo: sl<TeamsRepo>(),
      bookingRepo: sl<BookingRepo>(),
      mediaBaseUrl: sl<EnvConfig>().baseUrl,
    ),
  );
  sl.registerFactory<AvatarCubit>(
    () => AvatarCubit(
      uploadAvatarUseCase: sl<UploadAvatarUseCase>(),
      profileRepo: sl<ProfileRepo>(),
      mediaBaseUrl: sl<EnvConfig>().baseUrl,
    ),
  );
  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      getProfileOverviewUseCase: sl<GetProfileOverviewUseCase>(),
    ),
  );
  sl.registerFactory<ProfileSetupCubit>(
    () => ProfileSetupCubit(saveProfileUseCase: sl<SaveProfileUseCase>()),
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
  sl.registerFactory<ExploreListCubit>(
    () => ExploreListCubit(exploreVenuesUseCase: sl<ExploreVenuesUseCase>()),
  );
  sl.registerFactory<VenueProfileCubit>(
    () => VenueProfileCubit(
      getVenueDetailsUseCase: sl<GetVenueDetailsUseCase>(),
      getVenuePitchesUseCase: sl<GetVenuePitchesUseCase>(),
      exploreRepo: sl<ExploreRepo>(),
    ),
  );
  sl.registerFactory<PitchBookingCubit>(
    () => PitchBookingCubit(
      getVenueAvailabilityUseCase: sl<GetVenueAvailabilityUseCase>(),
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
    () => GetHomeFeedUseCase(
      homeRepo: sl<HomeRepo>(),
      profileRepo: sl<ProfileRepo>(),
    ),
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
  sl.registerFactory<BookingDetailsCubit>(
    () => BookingDetailsCubit(
      getBookingDetailUseCase: sl<GetBookingDetailUseCase>(),
    ),
  );
  sl.registerFactory<DepositMethodsCubit>(
    () => DepositMethodsCubit(bookingRepo: sl<BookingRepo>()),
  );
  sl.registerFactory<CancelBookingCubit>(
    () => CancelBookingCubit(bookingRepo: sl<BookingRepo>()),
  );
  sl.registerFactory<MyBookingsCubit>(
    () => MyBookingsCubit(getMyBookingsUseCase: sl<GetMyBookingsUseCase>()),
  );
  sl.registerFactory<ProofUploadCubit>(
    () => ProofUploadCubit(
      submitBookingProofUseCase: sl<SubmitBookingProofUseCase>(),
    ),
  );

  // Reference Data
  sl.registerLazySingleton<ReferenceApiService>(
    () => ReferenceApiService(sl<Dio>()),
  );
  sl.registerLazySingleton<ReferenceRepo>(
    () => ReferenceRepoImpl(referenceApiService: sl<ReferenceApiService>()),
  );
  sl.registerFactory<GovernoratesCubit>(
    () => GovernoratesCubit(referenceRepo: sl<ReferenceRepo>()),
  );

  // Teams Feature
  sl.registerLazySingleton<TeamsApiService>(() => TeamsApiService(sl<Dio>()));
  sl.registerLazySingleton<MatchesApiService>(
    () => MatchesApiService(sl<Dio>()),
  );
  sl.registerLazySingleton<MatchesRepo>(
    () => MatchesRepoImpl(matchesApiService: sl<MatchesApiService>()),
  );
  sl.registerLazySingleton<SendChallengeUseCase>(
    () => SendChallengeUseCase(matchesRepo: sl<MatchesRepo>()),
  );
  sl.registerLazySingleton<RespondToChallengeUseCase>(
    () => RespondToChallengeUseCase(matchesRepo: sl<MatchesRepo>()),
  );
  sl.registerLazySingleton<GetChallengeDetailsUseCase>(
    () => GetChallengeDetailsUseCase(
      matchesRepo: sl<MatchesRepo>(),
      teamsRepo: sl<TeamsRepo>(),
    ),
  );
  sl.registerLazySingleton<GetMatchDetailsUseCase>(
    () => GetMatchDetailsUseCase(
      matchesRepo: sl<MatchesRepo>(),
      teamsRepo: sl<TeamsRepo>(),
    ),
  );
  sl.registerFactory<SendChallengeCubit>(
    () => SendChallengeCubit(sendChallengeUseCase: sl<SendChallengeUseCase>()),
  );
  sl.registerFactory<ChallengeDetailsCubit>(
    () => ChallengeDetailsCubit(
      getChallengeDetailsUseCase: sl<GetChallengeDetailsUseCase>(),
    ),
  );
  sl.registerFactory<ChallengeResponseCubit>(
    () => ChallengeResponseCubit(
      respondToChallengeUseCase: sl<RespondToChallengeUseCase>(),
    ),
  );
  sl.registerFactory<MatchDetailsCubit>(
    () =>
        MatchDetailsCubit(getMatchDetailsUseCase: sl<GetMatchDetailsUseCase>()),
  );
  sl.registerLazySingleton<StepUpApiService>(() => StepUpApiService(sl<Dio>()));
  sl.registerLazySingleton<StepUpRepo>(
    () => StepUpRepoImpl(stepUpApiService: sl<StepUpApiService>()),
  );
  sl.registerFactory<StepUpCubit>(
    () => StepUpCubit(stepUpRepo: sl<StepUpRepo>()),
  );
  sl.registerLazySingleton<NotificationsApiService>(
    () => NotificationsApiService(sl<Dio>()),
  );
  sl.registerLazySingleton<NotificationsRepo>(
    () => NotificationsRepoImpl(
      notificationsApiService: sl<NotificationsApiService>(),
    ),
  );
  sl.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(notificationsRepo: sl<NotificationsRepo>()),
  );
  sl.registerFactory<UnreadNotificationsCubit>(
    () => UnreadNotificationsCubit(notificationsRepo: sl<NotificationsRepo>()),
  );
  sl.registerLazySingleton<AccountApiService>(
    () => AccountApiService(sl<Dio>()),
  );
  sl.registerLazySingleton<AccountRepo>(
    () => AccountRepoImpl(accountApiService: sl<AccountApiService>()),
  );
  sl.registerLazySingleton<DeleteAccountUseCase>(
    () => DeleteAccountUseCase(
      accountRepo: sl<AccountRepo>(),
      authRepo: sl<AuthRepo>(),
    ),
  );
  sl.registerFactory<NotificationPreferencesCubit>(
    () => NotificationPreferencesCubit(
      notificationsRepo: sl<NotificationsRepo>(),
    ),
  );
  sl.registerFactory<FilterOptionsCubit>(
    () => FilterOptionsCubit(referenceRepo: sl<ReferenceRepo>()),
  );
  sl.registerFactory<FavoriteToggleCubit>(
    () => FavoriteToggleCubit(exploreRepo: sl<ExploreRepo>()),
  );
  sl.registerFactory<FavoritesCubit>(
    () => FavoritesCubit(exploreRepo: sl<ExploreRepo>()),
  );
  sl.registerFactory<BiometricLockCubit>(
    () => BiometricLockCubit(biometricLock: sl<BiometricLock>()),
  );
  sl.registerFactory<OnboardingConsentCubit>(
    () => OnboardingConsentCubit(accountRepo: sl<AccountRepo>()),
  );
  sl.registerFactory<ConsentsCubit>(
    () => ConsentsCubit(accountRepo: sl<AccountRepo>()),
  );
  sl.registerFactory<SessionsCubit>(
    () => SessionsCubit(accountRepo: sl<AccountRepo>()),
  );
  sl.registerFactory<AccountActionCubit>(
    () => AccountActionCubit(
      accountRepo: sl<AccountRepo>(),
      deleteAccountUseCase: sl<DeleteAccountUseCase>(),
    ),
  );
  sl.registerLazySingleton<GetHomeTeamActivityUseCase>(
    () => GetHomeTeamActivityUseCase(
      teamsRepo: sl<TeamsRepo>(),
      matchesRepo: sl<MatchesRepo>(),
    ),
  );
  sl.registerFactory<HomeTeamActivityCubit>(
    () => HomeTeamActivityCubit(
      getHomeTeamActivityUseCase: sl<GetHomeTeamActivityUseCase>(),
    ),
  );
  sl.registerFactory<MatchResultCubit>(
    () => MatchResultCubit(matchesRepo: sl<MatchesRepo>()),
  );
  sl.registerLazySingleton<TeamsRepo>(
    () => TeamsRepoImpl(teamsApiService: sl<TeamsApiService>()),
  );
  sl.registerLazySingleton<GetTeamDashboardUseCase>(
    () => GetTeamDashboardUseCase(
      teamsRepo: sl<TeamsRepo>(),
      matchesRepo: sl<MatchesRepo>(),
    ),
  );
  sl.registerLazySingleton<CreateTeamUseCase>(
    () => CreateTeamUseCase(teamsRepo: sl<TeamsRepo>()),
  );
  sl.registerLazySingleton<GetLeaderboardUseCase>(
    () => GetLeaderboardUseCase(teamsRepo: sl<TeamsRepo>()),
  );
  sl.registerLazySingleton<JoinTeamByCodeUseCase>(
    () => JoinTeamByCodeUseCase(teamsRepo: sl<TeamsRepo>()),
  );
  sl.registerFactory<MyTeamsCubit>(
    () => MyTeamsCubit(teamsRepo: sl<TeamsRepo>()),
  );
  sl.registerFactory<DiscoverTeamsCubit>(
    () => DiscoverTeamsCubit(teamsRepo: sl<TeamsRepo>()),
  );
  sl.registerFactory<TeamDashboardCubit>(
    () => TeamDashboardCubit(
      getTeamDashboardUseCase: sl<GetTeamDashboardUseCase>(),
    ),
  );
  sl.registerFactory<CreateTeamCubit>(
    () => CreateTeamCubit(createTeamUseCase: sl<CreateTeamUseCase>()),
  );
  sl.registerFactory<JoinTeamCubit>(
    () => JoinTeamCubit(joinTeamByCodeUseCase: sl<JoinTeamByCodeUseCase>()),
  );
  sl.registerFactory<TeamInviteCubit>(
    () => TeamInviteCubit(teamsRepo: sl<TeamsRepo>()),
  );
  sl.registerFactory<LeaderboardCubit>(
    () => LeaderboardCubit(getLeaderboardUseCase: sl<GetLeaderboardUseCase>()),
  );
  sl.registerLazySingleton<TacticsRepo>(() => const TacticsRepoImpl());
  sl.registerFactory<TacticalBoardCubit>(
    () => TacticalBoardCubit(tacticsRepo: sl<TacticsRepo>()),
  );
  sl.registerFactory<TeamActionCubit>(
    () => TeamActionCubit(teamsRepo: sl<TeamsRepo>()),
  );
}
