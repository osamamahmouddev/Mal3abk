import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class NotificationDetailScreen extends StatelessWidget {
  const NotificationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'تفاصيل الإشعار'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: AppColors.successLight,
                          child: Icon(Icons.check_circle_rounded, color: AppColors.successGreen, size: 22.sp),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('اتأكد حجزك في ملعب النجوم', style: AppTextStyles.font16Bold),
                              Text('منذ ١٠ دقائق', style: AppTextStyles.font11Regular),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24, color: AppColors.border),
                    Text(
                      'إدارة ملعب النجوم اعتمدت إيصال التحويل، وحجزك ليوم السبت ٢٦ يوليو الساعة ٨:٠٠ م أصبح مؤكداً بنجاح. نتمنى لكم مباراة ممتعة!',
                      style: AppTextStyles.font13Regular,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                text: 'عرض تفاصيل الحجز',
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

