import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class ProofRejectedScreen extends StatelessWidget {
  const ProofRejectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'تفاصيل الحجز'),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(color: AppColors.border, width: 1)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CustomButton(
                  text: 'كلّم الملعب',
                  type: CustomButtonType.outline,
                  height: 52.h,
                  onTap: () {},
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: CustomButton(
                  text: 'أعد رفع الإيصال',
                  type: CustomButtonType.primary,
                  height: 52.h,
                  onTap: () => Navigator.of(context).pushNamed(AppRoutes.uploadProof),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Rejection Alert Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.redLight,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.redBorder, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16.r,
                          backgroundColor: AppColors.redText,
                          child: Icon(Icons.close_rounded, color: AppColors.white, size: 18.sp),
                        ),
                        SizedBox(width: 10.w),
                        Text('الملعب رفض إيصال التحويل', style: AppTextStyles.font16Bold.copyWith(color: AppColors.redDark)),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('سبب الرفض من ملعب المدينة · ٧:١٢ م', style: AppTextStyles.font11Regular),
                          SizedBox(height: 4.h),
                          Text(
                            'المبلغ في الإيصال ٣٠ ج.م بدل ٦٠ ج.م المطلوبة. حوّل الفرق وارفع الإيصالين في صورة واحدة.',
                            style: AppTextStyles.font13SemiBold,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(Icons.timer_outlined, size: 16.sp, color: AppColors.redDark),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            'الميعاد لسه محجوز لك ٤٥ دقيقة. بعدها الطلب يتلغي تلقائياً.',
                            style: AppTextStyles.font12Medium.copyWith(color: AppColors.redDark),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Booking Specs
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ملعب المدينة — ملعب ١', style: AppTextStyles.font16Bold),
                    SizedBox(height: 4.h),
                    Text('KH-2807-0151', style: AppTextStyles.font12Regular),
                    SizedBox(height: 4.h),
                    Text('الإثنين ٢٨ يوليو · ١٠:٠٠ م – ١١:٠٠ م · ٥ لاعب', style: AppTextStyles.font13Regular),
                    const Divider(height: 24, color: AppColors.border),
                    _buildSummaryRow('الإجمالي', '١٨٠ ج.م'),
                    SizedBox(height: 6.h),
                    _buildSummaryRow('العربون المطلوب', '٦٠ ج.م', isBold: true),
                    SizedBox(height: 6.h),
                    _buildSummaryRow('المعتمد حتى الآن', '٠ ج.م'),
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

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: isBold ? AppTextStyles.font14Bold : AppTextStyles.font13Regular),
        Text(
          value,
          style: isBold
              ? AppTextStyles.font15Bold.copyWith(color: AppColors.brandNavy)
              : AppTextStyles.font14Regular,
        ),
      ],
    );
  }
}

