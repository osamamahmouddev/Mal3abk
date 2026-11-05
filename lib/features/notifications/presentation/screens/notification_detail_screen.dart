import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../data/models/notification_model.dart';
import '../widgets/notification_category_icon.dart';
import '../widgets/notification_detail_card_widget.dart';

class NotificationDetailScreen extends StatelessWidget {
  const NotificationDetailScreen({required this.notification, super.key});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = NotificationCategoryIcon.of(notification.category);
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'notifications.detail_title'.tr(context: context),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          children: [
            NotificationDetailCardWidget(
              icon: icon,
              iconColor: color,
              title: notification.title,
              time: CairoTime.dayAndTime(
                notification.createdAtUtc,
                context.locale.languageCode,
              ),
              content: notification.body,
            ),
          ],
        ),
      ),
    );
  }
}
