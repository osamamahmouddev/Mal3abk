import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/presentation/cubit/logout_cubit.dart';
import 'cubit/venue_session_cubit.dart';

/// Opens a venue dashboard page on top of the shell, keeping the shell's
/// session (venue, permissions) available to it.
Future<T?> openVenuePage<T>(
  BuildContext context, {
  required String name,
  required WidgetBuilder builder,
}) {
  final session = context.read<VenueSessionCubit>();
  final logout = context.read<LogoutCubit>();
  return Navigator.of(context, rootNavigator: true).push<T>(
    MaterialPageRoute<T>(
      settings: RouteSettings(name: name),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: session),
          BlocProvider.value(value: logout),
        ],
        child: Builder(builder: builder),
      ),
    ),
  );
}
