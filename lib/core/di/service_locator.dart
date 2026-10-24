import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/apis/auth_api_service.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../../features/auth/domain/use_cases/login_use_case.dart';
import '../../features/auth/presentation/cubit/login_cubit.dart';
import '../../features/splash/data/repos/splash_repo_impl.dart';
import '../../features/splash/domain/repos/splash_repo.dart';
import '../../features/splash/domain/use_cases/check_auth_status_use_case.dart';
import '../../features/splash/presentation/cubit/splash_cubit.dart';
import '../config/env_config.dart';
import '../network/dio_factory.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator(EnvConfig envConfig) async {
  if (sl.isRegistered<EnvConfig>()) return;

  // Environment & External
  sl.registerSingleton<EnvConfig>(envConfig);
  sl.registerLazySingleton<Dio>(DioFactory.getDio);

  // Splash Feature
  sl.registerLazySingleton<SplashRepo>(SplashRepoImpl.new);
  sl.registerLazySingleton<CheckAuthStatusUseCase>(
    () => CheckAuthStatusUseCase(splashRepo: sl<SplashRepo>()),
  );
  sl.registerFactory<SplashCubit>(
    () => SplashCubit(checkAuthStatusUseCase: sl<CheckAuthStatusUseCase>()),
  );

  // Auth Feature
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService(sl<Dio>()));
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(authApiService: sl<AuthApiService>()),
  );
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(authRepo: sl<AuthRepo>()),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(loginUseCase: sl<LoginUseCase>()),
  );
}
