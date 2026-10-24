import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';

class ExploreMapScreen extends StatelessWidget {
  const ExploreMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'الخريطة',
        subtitle: 'الملاعب القريبة منك',
        actions: [
          IconButton(
            icon: const Icon(Icons.list_rounded, color: AppColors.brandNavy),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map Background Placeholder (Simulated Map Graphic)
          Container(
            color: const Color(0xFFE8ECEF),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined, size: 72.sp, color: AppColors.borderInput),
                  SizedBox(height: 8.h),
                  Text('عرض الخريطة التفاعلية', style: AppTextStyles.font14Medium),
                ],
              ),
            ),
          ),
          // Sample Map Pins
          Positioned(
            top: 140.h,
            left: 80.w,
            child: _buildMapPin('ملعب النجوم', '١٥٠ ج.م', true),
          ),
          Positioned(
            top: 220.h,
            right: 90.w,
            child: _buildMapPin('أكاديمية الدلتا', '٢٠٠ ج.م', false),
          ),
          Positioned(
            top: 320.h,
            left: 140.w,
            child: _buildMapPin('نادي الشباب', '١٦٠ ج.م', false),
          ),
          // Floating Bottom Preview Card
          Positioned(
            bottom: 24.h,
            left: 16.w,
            right: 16.w,
            child: Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: AppColors.pitchGreen,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: const Center(
                          child: Icon(Icons.sports_soccer_rounded, color: AppColors.white),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ملعب النجوم', style: AppTextStyles.font15Bold),
                            SizedBox(height: 2.h),
                            Text('مدينة نصر · ١٫٢ كم · ★ ٤٫٨', style: AppTextStyles.font12Regular),
                            SizedBox(height: 2.h),
                            Text('من ١٥٠ ج.م / ساعة', style: AppTextStyles.font13SemiBold),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  CustomButton(
                    text: 'عرض تفاصيل الملعب والحجز',
                    type: CustomButtonType.secondary,
                    height: 44.h,
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.venueProfile),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPin(String name, String price, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.brandNavy : AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSelected ? AppColors.brandNavy : AppColors.borderInput,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.sports_soccer_rounded,
            size: 14.sp,
            color: isSelected ? AppColors.white : AppColors.brandRed,
          ),
          SizedBox(width: 4.w),
          Text(
            '$name · $price',
            style: AppTextStyles.font11Bold.copyWith(
              color: isSelected ? AppColors.white : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

