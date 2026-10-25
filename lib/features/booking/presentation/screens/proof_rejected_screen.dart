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
import '../widgets/booking_summary_row_widget.dart';

class ProofRejectedScreen extends StatelessWidget {
  const ProofRejectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.proof_rejected_title'.tr(context: context),
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
                flex: 1,
                child: CustomButton(
                  text: 'common.call_venue'.tr(context: context),
                  type: CustomButtonType.outline,
                  height: 52.h,
                  onTap: () {},
                ),
              ),
              vSpace(12),
              Expanded(
                flex: 2,
                child: CustomButton(
                  text: 'booking.reupload_proof_btn'.tr(context: context),
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
                        vSpace(10),
                        Text('الملعب رفض إيصال التحويل', style: AppTextStyles.font16Bold.copyWith(color: AppColors.redDark)),
                      ],
                    ),
                    hSpace(12),
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
                          hSpace(4),
                          Text(
                            'المبلغ في الإيصال ٣٠ ج.م بدل ٦٠ ج.م المطلوبة. حوّل الفرق وارفع الإيصالين في صورة واحدة.',
                            style: AppTextStyles.font13SemiBold,
                          ),
                        ],
                      ),
                    ),
                    hSpace(10),
                    Row(
                      children: [
                        Icon(Icons.timer_outlined, size: 16.sp, color: AppColors.redDark),
                        vSpace(6),
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
              hSpace(16),
              CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ملعب المدينة — ملعب ١', style: AppTextStyles.font16Bold),
                    hSpace(4),
                    Text('KH-2807-0151', style: AppTextStyles.font12Regular),
                    hSpace(4),
                    Text('الإثنين ٢٨ يوليو · ١٠:٠٠ م – ١١:٠٠ م · ٥ لاعب', style: AppTextStyles.font13Regular),
                    const Divider(height: 24, color: AppColors.border),
                    BookingSummaryRowWidget(
                      label: 'booking.total_price'.tr(context: context),
                      value: '١٨٠ ج.م',
                    ),
                    hSpace(6),
                    BookingSummaryRowWidget(
                      label: 'booking.deposit_required'.tr(context: context),
                      value: '٦٠ ج.م',
                      isBold: true,
                    ),
                    hSpace(6),
                    BookingSummaryRowWidget(
                      label: 'booking.deposit_verified'.tr(context: context),
                      value: '٠ ج.م',
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
