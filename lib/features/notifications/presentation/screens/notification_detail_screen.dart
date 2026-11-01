import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/notification_detail_card_widget.dart';

class NotificationDetailScreen extends StatelessWidget {
  const NotificationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'notifications.detail_title'.tr(context: context),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NotificationDetailCardWidget(
                icon: Icons.check_circle_rounded,
                title: 'onboarding.notifications.preview1_title'.tr(
                  context: context,
                ),
                time: 'منذ ١٠ دقائق',
                content:
                    'إدارة ملعب النجوم اعتمدت إيصال التحويل، وحجزك ليوم السبت ٢٦ يوليو الساعة ٨:٠٠ م أصبح مؤكداً بنجاح. نتمنى لكم مباراة ممتعة!',
              ),
              hSpace(20),
              CustomButton(
                text: 'booking.view_booking_details'.tr(context: context),
                type: CustomButtonType.secondary,
                height: 48.h,
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
