import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class BookingReviewScreen extends StatefulWidget {
  const BookingReviewScreen({super.key});

  @override
  State<BookingReviewScreen> createState() => _BookingReviewScreenState();
}

class _BookingReviewScreenState extends State<BookingReviewScreen> {
  bool _isTeamBooking = false;
  bool _agreedToPolicy = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'مراجعة الحجز'),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomButton(
            text: 'إرسال طلب الحجز',
            type: CustomButtonType.primary,
            height: 52.h,
            enabled: _agreedToPolicy,
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
              // Booking Type Switcher
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _isTeamBooking = false),
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        height: 46.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: !_isTeamBooking ? AppColors.brandNavy : AppColors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: !_isTeamBooking ? AppColors.brandNavy : AppColors.borderInput),
                        ),
                        child: Text(
                          'حجز فردي',
                          style: !_isTeamBooking
                              ? AppTextStyles.font14Bold.copyWith(color: AppColors.white)
                              : AppTextStyles.font14Medium,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _isTeamBooking = true),
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        height: 46.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _isTeamBooking ? AppColors.brandNavy : AppColors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: _isTeamBooking ? AppColors.brandNavy : AppColors.borderInput),
                        ),
                        child: Text(
                          'حجز باسم فريق',
                          style: _isTeamBooking
                              ? AppTextStyles.font14Bold.copyWith(color: AppColors.white)
                              : AppTextStyles.font14Medium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Booking Overview Card
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ملعب النجوم — ملعب ١', style: AppTextStyles.font16Bold),
                    SizedBox(height: 12.h),
                    _buildDetailRow('الميعاد', 'السبت ٢٦ يوليو · ٨:٠٠ – ٩:٠٠ م'),
                    SizedBox(height: 8.h),
                    _buildDetailRow('الملعب', '٥ لاعب · نجيل صناعي'),
                    SizedBox(height: 8.h),
                    _buildDetailRow('المسؤول عن الحجز', 'أحمد سامي · ٠١٠١٢٣٤٥٦٧٨'),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              // Price Summary Card
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ملخص السعر', style: AppTextStyles.font16Bold),
                    SizedBox(height: 12.h),
                    _buildPriceRow('ساعة واحدة × ١٥٠ ج.م', '١٥٠ ج.م'),
                    SizedBox(height: 8.h),
                    _buildPriceRow('رسوم الخدمة', '٠ ج.م'),
                    const Divider(height: 24, color: AppColors.border),
                    _buildPriceRow('الإجمالي', '١٥٠ ج.م', isBold: true),
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.goldLight,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('العربون المطلوب الآن', style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.goldDark)),
                          Text('٥٠ ج.م', style: AppTextStyles.font15Bold.copyWith(color: AppColors.goldDark)),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _buildPriceRow('المتبقي — يُدفع في الملعب', '١٠٠ ج.م'),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              // Notice Banner
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
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'لما تبعت الطلب، الميعاد بيتحجز لك مؤقتاً ٣٠ دقيقة لحد ما ترفع إيصال العربون. الحجز مش مؤكد غير بعد ما الملعب يراجع التحويل.',
                        style: AppTextStyles.font12Regular,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              // Policy and Checkbox
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('سياسة الحجز', style: AppTextStyles.font15Bold),
                    SizedBox(height: 8.h),
                    Text('• إلغاء مجاني مع استرداد العربون لحد ٦ ساعات قبل الميعاد.', style: AppTextStyles.font12Regular),
                    SizedBox(height: 4.h),
                    Text('• عدم الحضور أو التأخير أكتر من ١٥ دقيقة بيفقدك العربون.', style: AppTextStyles.font12Regular),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreedToPolicy,
                          activeColor: AppColors.brandNavy,
                          onChanged: (val) => setState(() => _agreedToPolicy = val ?? true),
                        ),
                        Expanded(
                          child: Text('أوافق على سياسة الحجز والإلغاء', style: AppTextStyles.font13SemiBold),
                        ),
                      ],
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

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.font13Regular),
        Text(value, style: AppTextStyles.font13SemiBold),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: isBold ? AppTextStyles.font15Bold : AppTextStyles.font13Regular),
        Text(value, style: isBold ? AppTextStyles.font16Bold.copyWith(color: AppColors.brandNavy) : AppTextStyles.font14SemiBold),
      ],
    );
  }
}

