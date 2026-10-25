import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/explore_map_pin_widget.dart';

class ExploreMapScreen extends StatelessWidget {
  const ExploreMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'explore.map_title'.tr(context: context),
        subtitle: 'explore.all'.tr(context: context),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_rounded, color: AppColors.brandNavy),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFE8ECEF),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined, size: 72.sp, color: AppColors.borderInput),
                  hSpace(8),
                  Text('عرض الخريطة التفاعلية', style: AppTextStyles.font14Medium),
                ],
              ),
            ),
          ),
          Positioned(
            top: 140.h,
            left: 80.w,
            child: const ExploreMapPinWidget(name: 'ملعب النجوم', price: '١٥٠ ج.م', isSelected: true),
          ),
          Positioned(
            top: 220.h,
            right: 90.w,
            child: const ExploreMapPinWidget(name: 'أكاديمية الدلتا', price: '٢٠٠ ج.م', isSelected: false),
          ),
          Positioned(
            top: 320.h,
            left: 140.w,
            child: const ExploreMapPinWidget(name: 'نادي الشباب', price: '١٦٠ ج.م', isSelected: false),
          ),
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
                      vSpace(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ملعب النجوم', style: AppTextStyles.font15Bold),
                            hSpace(2),
                            Text('مدينة نصر · ١٫٢ كم · ★ ٤٫٨', style: AppTextStyles.font12Regular),
                            hSpace(2),
                            Text('من ١٥٠ ج.م / ساعة', style: AppTextStyles.font13SemiBold),
                          ],
                        ),
                      ),
                    ],
                  ),
                  hSpace(12),
                  CustomButton(
                    text: 'explore.venue_profile'.tr(context: context),
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
}
