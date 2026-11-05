import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../../../notifications/presentation/cubit/unread_notifications_cubit.dart';
import 'home_notifications_button_widget.dart';

class HomeNotificationsButtonBlocBuilder extends StatelessWidget {
  const HomeNotificationsButtonBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnreadNotificationsCubit, int>(
      builder: (context, unread) => HomeNotificationsButtonWidget(
        hasUnread: unread > 0,
        onTap: () async {
          final cubit = context.read<UnreadNotificationsCubit>();
          await Navigator.of(context).pushNamed(AppRoutes.notifications);
          await cubit.refresh();
        },
      ),
    );
  }
}
