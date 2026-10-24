import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class DepositInstructionsScreen extends StatelessWidget {
  const DepositInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'دفع العربون'),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomButton(
            text: 'ارفع إيصال التحويل',
            type: CustomButtonType.primary,
            height: 52.h,
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.uploadProof),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Timer Alert Banner
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: AppColors.goldLight,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.goldBorder, width: 1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.timer_outlined, size: 24.sp, color: AppColors.goldDark),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الميعاد محجوز مؤقتاً — متبقي ٢٨:٤٥', style: AppTextStyles.font14Bold.copyWith(color: AppColors.goldDark)),
                          SizedBox(height: 2.h),
                          Text('ارفع إيصال التحويل قبل انتهاء الوقت لتأكيد الحجز.', style: AppTextStyles.font12Regular.copyWith(color: AppColors.goldDark)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Wallet Information Card
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('بيانات تحويل العربون (فودافون كاش / إنستاباي)', style: AppTextStyles.font15Bold),
                    SizedBox(height: 14.h),
                    _buildPaymentField('المبلغ المطلوب تحويله', '٥٠ ج.م', isHighlight: true),
                    SizedBox(height: 10.h),
                    _buildPaymentField('رقم المحفظة / إنستاباي', '01098765432', canCopy: true),
                    SizedBox(height: 10.h),
                    _buildPaymentField('اسم المستلم', 'إدارة ملاعب النجوم'),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Steps Card
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('خطوات الدفع والتأكيد', style: AppTextStyles.font15Bold),
                    SizedBox(height: 12.h),
                    _buildStep('١', 'افتح تطبيق محفظتك أو إنستاباي وحوّل مبلغ العربون (٥٠ ج.م).'),
                    SizedBox(height: 10.h),
                    _buildStep('٢', 'خد لقطة شاشة (سكرين شوت) واضحة لرسالة أو إيصال نجاح التحويل.'),
                    SizedBox(height: 10.h),
                    _buildStep('٣', 'اضغط على الزرار بالأسفل وارفع الصورة لمراجعتها واعتماد حجزك.'),
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

  Widget _buildPaymentField(String label, String value, {bool isHighlight = false, bool canCopy = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.lightGrayBackground,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.font13Regular),
          Row(
            children: [
              Text(
                value,
                style: isHighlight
                    ? AppTextStyles.font16Bold.copyWith(color: AppColors.brandRed)
                    : AppTextStyles.font14Bold,
              ),
              if (canCopy) ...[
                SizedBox(width: 8.w),
                Icon(Icons.copy_rounded, size: 16.sp, color: AppColors.brandNavy),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String num, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 12.r,
          backgroundColor: AppColors.brandNavy,
          child: Text(num, style: AppTextStyles.font11Bold.copyWith(color: AppColors.white)),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(text, style: AppTextStyles.font13Regular),
        ),
      ],
    );
  }
}

