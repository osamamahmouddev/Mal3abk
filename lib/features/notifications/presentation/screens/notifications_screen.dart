import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../widgets/notifications_bloc_builder.dart';
import '../widgets/notifications_mark_all_bloc_builder.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'notifications.title'.tr(context: context),
        actions: const [NotificationsMarkAllBlocBuilder()],
      ),
      body: const SafeArea(child: NotificationsBlocBuilder()),
    );
  }
}
