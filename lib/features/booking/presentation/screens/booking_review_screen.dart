import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../widgets/booking_detail_row_widget.dart';
import '../widgets/booking_policy_card_widget.dart';
import '../widgets/booking_price_row_widget.dart';
import '../widgets/booking_type_selector_widget.dart';

class BookingReviewScreen extends HookWidget {
  const BookingReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTeamBooking = useState(false);
    final agreedToPolicy = useState(true);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.review_title'.tr(context: context),
        showBackButton: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomButton(
            text: 'booking.submit_request'.tr(context: context),
            type: CustomButtonType.primary,
            height: 52.h,
            enabled: agreedToPolicy.value,
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.depositInstructions),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BookingTypeSelectorWidget(
                isTeamBooking: isTeamBooking.value,
                onChanged: (val) => isTeamBooking.value = val,
              ),
              hSpace(16),
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ملعب النجوم — ملعب ١', style: AppTextStyles.font16Bold),
                    hSpace(12),
                    BookingDetailRowWidget(
                      label: 'booking.time_label'.tr(context: context),
                      value: 'السبت ٢٦ يوليو · ٨:٠٠ – ٩:٠٠ م',
                    ),
                    BookingDetailRowWidget(
                      label: 'booking.pitch_label'.tr(context: context),
                      value: '٥ لاعب · نجيل صناعي',
                    ),
                    BookingDetailRowWidget(
                      label: 'booking.manager_label'.tr(context: context),
                      value: 'أحمد سامي · ٠١٠١٢٣٥٦٧٨',
                    ),
                  ],
                ),
              ),
              hSpace(14),
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'booking.price_summary'.tr(context: context),
                      style: AppTextStyles.font16Bold,
                    ),
                    hSpace(12),
                    BookingPriceRowWidget(
                      label: 'booking.one_hour_rate'.tr(context: context),
                      value: '١٥٠ ج.م',
                    ),
                    BookingPriceRowWidget(
                      label: 'booking.service_fee'.tr(context: context),
                      value: '٠ ج.م',
                    ),
                    const Divider(height: 24, color: AppColors.border),
                    BookingPriceRowWidget(
                      label: 'booking.total_price'.tr(context: context),
                      value: '١٥٠ ج.م',
                      isBold: true,
                    ),
                    hSpace(10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.goldLight,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'booking.deposit_required_now'.tr(context: context),
                            style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.goldDark),
                          ),
                          Text(
                            '٥٠ ج.م',
                            style: AppTextStyles.font15Bold.copyWith(color: AppColors.goldDark),
                          ),
                        ],
                      ),
                    ),
                    hSpace(8),
                    BookingPriceRowWidget(
                      label: 'booking.remaining_price'.tr(context: context),
                      value: '١٠٠ ج.م',
                    ),
                  ],
                ),
              ),
              hSpace(14),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline_rounded, size: 20.sp, color: AppColors.brandNavy),
                    vSpace(8),
                    Expanded(
                      child: Text(
                        'booking.hold_notice'.tr(context: context),
                        style: AppTextStyles.font12Regular,
                      ),
                    ),
                  ],
                ),
              ),
              hSpace(14),
              BookingPolicyCardWidget(
                agreedToPolicy: agreedToPolicy.value,
                onChanged: (val) => agreedToPolicy.value = val ?? true,
              ),
              hSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
