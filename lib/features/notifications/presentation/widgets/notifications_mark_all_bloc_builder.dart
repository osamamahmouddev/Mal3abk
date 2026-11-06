import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_button.dart';
import '../cubit/notifications_cubit.dart';
import '../cubit/notifications_state.dart';

class NotificationsMarkAllBlocBuilder extends StatelessWidget {
  const NotificationsMarkAllBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      buildWhen: (previous, current) =>
          previous is! NotificationsSuccess ||
          current is! NotificationsSuccess ||
          (previous.unreadCount == 0) != (current.unreadCount == 0),
      builder: (context, state) {
        if (state is! NotificationsSuccess || state.unreadCount == 0) {
          return const SizedBox.shrink();
        }
        return CustomButton(
          text: 'notifications.mark_all_read'.tr(context: context),
          type: CustomButtonType.ghost,
          onTap: () {
            HapticFeedback.lightImpact();
            context.read<NotificationsCubit>().markAllRead();
          },
        );
      },
    );
  }
}
