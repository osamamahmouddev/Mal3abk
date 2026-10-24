import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/cubit/login_cubit.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/splash/presentation/cubit/splash_cubit.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../di/service_locator.dart';
import 'routes.dart';

class AppRouter {
  const AppRouter._();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.splash),
          builder: (_) => BlocProvider<SplashCubit>(
            create: (_) => sl<SplashCubit>()..checkAuth(),
            child: const SplashScreen(),
          ),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.login),
          builder: (_) => BlocProvider<LoginCubit>(
            create: (_) => sl<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.home),
          builder: (_) => const HomeScreen(),
        );

      default:
        return _errorRoute('Unknown route: ${settings.name}');
    }
  }

  static Route _errorRoute(String message) => MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(message),
          ),
        ),
      );
}
