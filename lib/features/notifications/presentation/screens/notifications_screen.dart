import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/notification_item_card_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'notifications.title'.tr(context: context),
        actions: [
          CustomButton(
            text: 'notifications.mark_all_read'.tr(context: context),
            type: CustomButtonType.ghost,
            onTap: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          children: [
            NotificationItemCardWidget(
              icon: Icons.check_circle_rounded,
              iconColor: AppColors.successGreen,
              title: 'onboarding.notifications.preview1_title'.tr(context: context),
              time: 'منذ ١٠ دقائق · العربون اتعتمد من الملعب',
              isUnread: true,
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.notificationDetail),
            ),
            NotificationItemCardWidget(
              icon: Icons.sports_soccer_rounded,
              iconColor: AppColors.brandNavy,
              title: 'الصقور بيتحدوا فريقك في ماتش جديد',
              time: 'منذ ساعتين · السبت ٢ أغسطس ٩:٠٠ م',
              isUnread: true,
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.notificationDetail),
            ),
            NotificationItemCardWidget(
              icon: Icons.alarm_rounded,
              iconColor: AppColors.brandRed,
              title: 'ماتشك بعد ٣ ساعات في ملعب النجوم',
              time: 'منذ ٤ ساعات · ملعب ١',
              isUnread: false,
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.notificationDetail),
            ),
          ],
        ),
      ),
    );
  }
}
