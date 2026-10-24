import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.brandNavy,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Step 2 indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('خطوة ٢ من ٢', style: AppTextStyles.font13Regular),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.brandRed,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.brandRed,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: Container(
                  width: 140.w,
                  height: 140.h,
                  decoration: const BoxDecoration(
                    color: AppColors.lightSurface,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.location_on_rounded,
                      size: 64.sp,
                      color: AppColors.brandRed,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'نوريك الملاعب الأقرب ليك',
                style: AppTextStyles.font22Bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                'بنستخدم موقعك عشان نحسب المسافة لكل ملعب ونرتّب النتايج. موقعك بالظبط مش بيظهر لأي لاعب أو ملعب.',
                style: AppTextStyles.font14Regular,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomButton(
                text: 'اسمح باستخدام الموقع',
                type: CustomButtonType.primary,
                height: 52.h,
                onTap: () =>
                    context.pushNamed(AppRoutes.notificationsPermission),
              ),
              SizedBox(height: 12.h),
              CustomButton(
                text: 'اختار المنطقة بنفسي',
                type: CustomButtonType.outline,
                height: 48.h,
                onTap: () =>
                    context.pushNamed(AppRoutes.notificationsPermission),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
