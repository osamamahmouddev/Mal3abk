import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../widgets/deposit_payment_field_widget.dart';
import '../widgets/deposit_step_widget.dart';

class DepositInstructionsScreen extends StatelessWidget {
  const DepositInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.deposit_instructions_title'.tr(context: context),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomButton(
            text: 'booking.upload_proof_btn'.tr(context: context),
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
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: AppColors.goldLight,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.goldBorder, width: 1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.timer_outlined, size: 28.sp, color: AppColors.goldDark),
                    vSpace(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الميعاد محجوز مؤقتاً — متبقي ٢٨:٤٥', style: AppTextStyles.font14Bold.copyWith(color: AppColors.goldDark)),
                          hSpace(2),
                          Text('ارفع إيصال التحويل قبل انتهاء الوقت لتأكيد الحجز.', style: AppTextStyles.font12Regular.copyWith(color: AppColors.goldDark)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              hSpace(16),
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('بيانات تحويل العربون (فودافون كاش / إنستاباي)', style: AppTextStyles.font15Bold),
                    hSpace(14),
                    DepositPaymentFieldWidget(
                      label: 'booking.amount_to_transfer'.tr(context: context),
                      value: '٥٠ ج.م',
                      isHighlight: true,
                    ),
                    hSpace(10),
                    DepositPaymentFieldWidget(
                      label: 'booking.wallet_number'.tr(context: context),
                      value: '01098765432',
                      canCopy: true,
                    ),
                    hSpace(10),
                    DepositPaymentFieldWidget(
                      label: 'booking.recipient_name'.tr(context: context),
                      value: 'إدارة ملاعب النجوم',
                    ),
                  ],
                ),
              ),
              hSpace(16),
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('خطوات الدفع والتأكيد', style: AppTextStyles.font15Bold),
                    hSpace(12),
                    DepositStepWidget(number: '١', text: 'booking.step_1'.tr(context: context)),
                    hSpace(10),
                    DepositStepWidget(number: '٢', text: 'booking.step_2'.tr(context: context)),
                    hSpace(10),
                    DepositStepWidget(number: '٣', text: 'booking.step_3'.tr(context: context)),
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
