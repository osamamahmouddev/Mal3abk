import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/custom_chip_widget.dart';

class CancelBookingScreen extends HookWidget {
  const CancelBookingScreen({super.key});

  static const List<String> _reasons = ['الميعاد مش مناسب', 'العدد مش مكتمل', 'الجو', 'سبب تاني'];

  @override
  Widget build(BuildContext context) {
    final selectedReason = useState('الميعاد مش مناسب');

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'إلغاء الحجز'),
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
                child: CustomButton(
                  text: 'احتفظ بالحجز',
                  type: CustomButtonType.outline,
                  height: 52.h,
                  onTap: () => Navigator.of(context).maybePop(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomButton(
                  text: 'تأكيد الإلغاء',
                  type: CustomButtonType.primary,
                  height: 52.h,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم إلغاء الحجز بنجاح')),
                    );
                    Navigator.of(context).pop();
                  },
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
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('أكاديمية الدلتا — ملعب ٢', style: AppTextStyles.font16Bold),
                    SizedBox(height: 4.h),
                    Text('الخميس ٣١ يوليو · ٩:٠٠ م · كود: KH-3107-0098', style: AppTextStyles.font13Regular),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              // Refund info card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.successBorder, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('إلغاء مجاني — متبقي ٤ ساعات و٢٠ دقيقة على المهلة', style: AppTextStyles.font13Bold.copyWith(color: AppColors.successGreen)),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('العربون المدفوع: ٧٠ ج.م', style: AppTextStyles.font13Regular),
                        Text('هتسترد: ٧٠ ج.م', style: AppTextStyles.font15Bold.copyWith(color: AppColors.successGreen)),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'الملعب بيرجّع العربون يدوي على نفس المحفظة خلال ٣ أيام عمل.',
                      style: AppTextStyles.font11Regular.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              Text('سبب الإلغاء *', style: AppTextStyles.font15Bold),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: _reasons.map((reason) {
                  return CustomChipWidget(
                    label: reason,
                    isSelected: selectedReason.value == reason,
                    onTap: () => selectedReason.value = reason,
                  );
                }).toList(),
              ),
              SizedBox(height: 16.h),

              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'الملعب هيوصله إشعار والميعاد هيتاح لغيرك. الإلغاء مينفعش يترجع.',
                  style: AppTextStyles.font12Regular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
