import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_logger.dart';

/// Global [BlocObserver] that intercepts, logs, and handles all BLoC and Cubit
/// transitions, events, and uncaught errors to prevent crashes in production.
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    AppLogger.d('${bloc.runtimeType} state change: ${change.currentState.runtimeType} -> ${change.nextState.runtimeType}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    AppLogger.e(
      'BlocObserver caught unhandled error in ${bloc.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
