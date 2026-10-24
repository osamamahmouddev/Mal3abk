import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'تفاصيل الحجز'),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomButton(
            text: 'إلغاء الحجز',
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
              // Venue Header Card
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
                    SizedBox(height: 6.h),
                    Text('الخميس ٣١ يوليو · ٩:٠٠ م · كود: KH-3107-0098', style: AppTextStyles.font13Regular),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              // Action buttons (Call, Direction, Share)
              Row(
                children: [
                  _buildQuickAction(Icons.phone_outlined, 'اتصال بالملعب'),
                  SizedBox(width: 8.w),
                  _buildQuickAction(Icons.directions_outlined, 'الاتجاهات'),
                  SizedBox(width: 8.w),
                  _buildQuickAction(Icons.share_outlined, 'شارك مع فريقك'),
                ],
              ),
              SizedBox(height: 14.h),

              // Payment Details Card
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('تفاصيل الدفع', style: AppTextStyles.font15Bold),
                    SizedBox(height: 12.h),
                    _buildRow('الإجمالي', '٢٠٠ ج.م'),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('العربون المدفوع', style: AppTextStyles.font13Regular),
                        Row(
                          children: [
                            Text('٧٠ ج.م', style: AppTextStyles.font13SemiBold),
                            SizedBox(width: 6.w),
                            const AppBadgeWidget(text: '✓ اعتمده الملعب', type: AppBadgeType.success),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 20, color: AppColors.border),
                    _buildRow('المتبقي للدفع في الملعب', '١٣٠ ج.م', isBold: true),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              // Policy Section
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('سياسة الإلغاء للحجز ده', style: AppTextStyles.font15Bold),
                    SizedBox(height: 8.h),
                    Text(
                      '• إلغاء مجاني مع استرداد العربون لحد الخميس ٣:٠٠ م (٦ ساعات قبل الميعاد).',
                      style: AppTextStyles.font12Regular,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderCard, width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20.sp, color: AppColors.brandNavy),
            SizedBox(height: 4.h),
            Text(label, style: AppTextStyles.font11Bold),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: isBold ? AppTextStyles.font14Bold : AppTextStyles.font13Regular),
        Text(
          value,
          style: isBold
              ? AppTextStyles.font16Bold.copyWith(color: AppColors.brandNavy)
              : AppTextStyles.font14Regular,
        ),
      ],
    );
  }
}

