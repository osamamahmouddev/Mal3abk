import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../widgets/booking_detail_row_widget.dart';
import '../widgets/booking_quick_action_widget.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.details_title'.tr(context: context),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomButton(
            text: 'booking.cancel_booking_btn'.tr(context: context),
            type: CustomButtonType.outline,
            borderColor: AppColors.brandRed,
            foregroundColor: AppColors.brandRed,
            height: 52.h,
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.cancelBooking),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('أكاديمية الدلتا — ملعب ٢', style: AppTextStyles.font16Bold),
                        const AppBadgeWidget(text: '✓ حجز مؤكد', type: AppBadgeType.success),
                      ],
                    ),
                    hSpace(6),
                    Text('الخميس ٣١ يوليو · ٩:٠٠ م · كود: KH-3107-0098', style: AppTextStyles.font13Regular),
                  ],
                ),
              ),
              hSpace(14),
              Row(
                children: [
                  Expanded(
                    child: BookingQuickActionWidget(
                      icon: Icons.phone_outlined,
                      label: 'common.call_venue'.tr(context: context),
                    ),
                  ),
                  vSpace(8),
                  Expanded(
                    child: BookingQuickActionWidget(
                      icon: Icons.directions_outlined,
                      label: 'common.directions'.tr(context: context),
                    ),
                  ),
                  vSpace(8),
                  Expanded(
                    child: BookingQuickActionWidget(
                      icon: Icons.share_outlined,
                      label: 'booking.share_team'.tr(context: context),
                    ),
                  ),
                ],
              ),
              hSpace(14),
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('تفاصيل الدفع', style: AppTextStyles.font15Bold),
                    hSpace(12),
                    BookingDetailRowWidget(
                      label: 'booking.total_price'.tr(context: context),
                      value: '٢٠٠ ج.م',
                    ),
                    hSpace(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('العربون المدفوع', style: AppTextStyles.font13Regular),
                        Row(
                          children: [
                            Text('٧٠ ج.م', style: AppTextStyles.font13SemiBold),
                            vSpace(6),
                            const AppBadgeWidget(text: '✓ اعتمده الملعب', type: AppBadgeType.success),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 20, color: AppColors.border),
                    BookingDetailRowWidget(
                      label: 'booking.remaining_price'.tr(context: context),
                      value: '١٣٠ ج.م',
                      isBold: true,
                    ),
                  ],
                ),
              ),
              hSpace(14),
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('سياسة الإلغاء للحجز ده', style: AppTextStyles.font15Bold),
                    hSpace(8),
                    Text(
                      '• إلغاء مجاني مع استرداد العربون لحد الخميس ٣:٠٠ م (٦ ساعات قبل الميعاد).',
                      style: AppTextStyles.font12Regular,
                    ),
                  ],
                ),
              ),
              hSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
