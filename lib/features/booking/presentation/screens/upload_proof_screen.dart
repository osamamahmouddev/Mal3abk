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

class UploadProofScreen extends HookWidget {
  const UploadProofScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isUploaded = useState(false);
    final isSubmitted = useState(false);

    if (isSubmitted.value) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: const BoxDecoration(
                    color: AppColors.successLight,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.check_rounded, size: 48.sp, color: AppColors.successGreen),
                  ),
                ),
                hSpace(24),
                Text('تم رفع الإيصال بنجاح!', style: AppTextStyles.font22Bold),
                hSpace(8),
                Text(
                  'طلبك قيد المراجعة حالياً من إدارة الملعب. هنبعتلك إشعار فور اعتماد الحجز (عادة في أقل من ١٥ دقيقة).',
                  style: AppTextStyles.font14Regular,
                  textAlign: TextAlign.center,
                ),
                hSpace(36),
                CustomButton(
                  text: 'booking.view_booking_details'.tr(context: context),
                  type: CustomButtonType.secondary,
                  height: 50.h,
                  onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.bookingDetails),
                ),
                hSpace(12),
                CustomButton(
                  text: 'common.back'.tr(context: context),
                  type: CustomButtonType.ghost,
                  height: 48.h,
                  onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.upload_proof_title'.tr(context: context),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomButton(
            text: 'تأكيد وإرسال الإيصال',
            type: CustomButtonType.primary,
            height: 52.h,
            enabled: isUploaded.value,
            onTap: () => isSubmitted.value = true,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('صورة الإيصال أو التحويل', style: AppTextStyles.font16Bold),
              hSpace(6),
              Text('تأكد من وضوح رقم العملية وتاريخها والمبلغ (٥٠ ج.م)', style: AppTextStyles.font13Regular),
              hSpace(20),
              InkWell(
                onTap: () => isUploaded.value = true,
                borderRadius: BorderRadius.circular(16.r),
                child: Container(
                  height: 220.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isUploaded.value ? AppColors.successGreen : AppColors.borderInput,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: isUploaded.value
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_rounded, size: 54.sp, color: AppColors.successGreen),
                              hSpace(10),
                              Text('instapay-receipt-2607.png', style: AppTextStyles.font14Bold),
                              hSpace(4),
                              Text('تم اختيار الصورة · اضغط للتغيير', style: AppTextStyles.font12Medium),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload_outlined, size: 54.sp, color: AppColors.brandNavy),
                              hSpace(10),
                              Text('اضغط لرفع صورة الإيصال', style: AppTextStyles.font15Bold),
                              hSpace(4),
                              Text('يدعم صيغ JPG و PNG', style: AppTextStyles.font12Regular),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
