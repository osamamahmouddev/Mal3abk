import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
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
      appBar: CustomAppBarWidget(
        title: 'booking.cancel_booking_title'.tr(context: context),
      ),
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
                  text: 'common.cancel'.tr(context: context),
                  type: CustomButtonType.outline,
                  height: 52.h,
                  onTap: () => Navigator.of(context).maybePop(),
                ),
              ),
              vSpace(12),
              Expanded(
                child: CustomButton(
                  text: 'common.confirm'.tr(context: context),
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
                    hSpace(4),
                    Text('الخميس ٣١ يوليو · ٩:٠٠ م · كود: KH-3107-0098', style: AppTextStyles.font13Regular),
                  ],
                ),
              ),
              hSpace(14),
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
                    hSpace(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('العربون المدفوع: ٧٠ ج.م', style: AppTextStyles.font13Regular),
                        Text('هتسترد: ٧٠ ج.م', style: AppTextStyles.font15Bold.copyWith(color: AppColors.successGreen)),
                      ],
                    ),
                    hSpace(8),
                    Text(
                      'الملعب بيرجّع العربون يدوي على نفس المحفظة خلال ٣ أيام عمل.',
                      style: AppTextStyles.font11Regular.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              hSpace(16),
              Text('سبب الإلغاء *', style: AppTextStyles.font15Bold),
              hSpace(10),
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
              hSpace(16),
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
