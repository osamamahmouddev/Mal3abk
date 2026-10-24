import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';

class UploadProofScreen extends StatefulWidget {
  const UploadProofScreen({super.key});

  @override
  State<UploadProofScreen> createState() => _UploadProofScreenState();
}

class _UploadProofScreenState extends State<UploadProofScreen> {
  bool _isUploaded = false;
  bool _isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    if (_isSubmitted) {
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
                SizedBox(height: 24.h),
                Text('تم رفع الإيصال بنجاح!', style: AppTextStyles.font22Bold),
                SizedBox(height: 8.h),
                Text(
                  'طلبك قيد المراجعة حالياً من إدارة الملعب. هنبعتلك إشعار فور اعتماد الحجز (عادة في أقل من ١٥ دقيقة).',
                  style: AppTextStyles.font14Regular,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 36.h),
                CustomButton(
                  text: 'متابعة تفاصيل الحجز',
                  type: CustomButtonType.secondary,
                  height: 50.h,
                  onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.bookingDetails),
                ),
                SizedBox(height: 12.h),
                CustomButton(
                  text: 'الرجوع للرئيسية',
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
      appBar: const CustomAppBarWidget(title: 'رفع إيصال التحويل'),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomButton(
            text: 'تأكيد وإرسال الإيصال',
            type: CustomButtonType.primary,
            height: 52.h,
            enabled: _isUploaded,
            onTap: () => setState(() => _isSubmitted = true),
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
              SizedBox(height: 6.h),
              Text('تأكد من وضوح رقم العملية وتاريخها والمبلغ (٥٠ ج.م)', style: AppTextStyles.font13Regular),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () => setState(() => _isUploaded = true),
                borderRadius: BorderRadius.circular(16.r),
                child: Container(
                  height: 220.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: _isUploaded ? AppColors.successGreen : AppColors.borderInput,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: _isUploaded
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_rounded, size: 54.sp, color: AppColors.successGreen),
                              SizedBox(height: 10.h),
                              Text('instapay-receipt-2607.png', style: AppTextStyles.font14Bold),
                              SizedBox(height: 4.h),
                              Text('تم اختيار الصورة · اضغط للتغيير', style: AppTextStyles.font12Medium),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload_outlined, size: 54.sp, color: AppColors.brandNavy),
                              SizedBox(height: 10.h),
                              Text('اضغط لرفع صورة الإيصال', style: AppTextStyles.font15Bold),
                              SizedBox(height: 4.h),
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

