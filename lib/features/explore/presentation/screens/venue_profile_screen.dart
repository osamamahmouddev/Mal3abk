import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class VenueProfileScreen extends StatelessWidget {
  const VenueProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220.h,
            pinned: true,
            backgroundColor: AppColors.brandNavy,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border_rounded, color: AppColors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share_rounded, color: AppColors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.pitchGreen,
                child: Center(
                  child: Icon(Icons.sports_soccer_rounded, size: 72.sp, color: AppColors.white.withValues(alpha: 0.6)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ملعب النجوم', style: AppTextStyles.font22Bold),
                      Row(
                        children: [
                          Icon(Icons.star_rounded, size: 18.sp, color: AppColors.goldDark),
                          SizedBox(width: 4.w),
                          Text('٤٫٨ (١٤٢ تقييم)', style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.goldDark)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 16.sp, color: AppColors.textSecondary),
                      SizedBox(width: 4.w),
                      Text('مدينة نصر، خلف النادي الأهلي · ١٫٢ كم', style: AppTextStyles.font13Regular),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Amenities / Facilities
                  CustomCardWidget(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildAmenity(Icons.wb_incandescent_outlined, 'إضاءة ليد'),
                        _buildAmenity(Icons.shower_outlined, 'غرف تبديل'),
                        _buildAmenity(Icons.local_cafe_outlined, 'كافيتريا'),
                        _buildAmenity(Icons.local_parking_outlined, 'موقف سيارات'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Text('الملاعب المتاحة بالمنشأة', style: AppTextStyles.font16Bold),
                  SizedBox(height: 10.h),
                  _buildPitchOption(context, 'ملعب ١ (خماسي)', 'نجيل تركي صناعي مميز · ٥ ضد ٥', '١٥٠ ج.م'),
                  _buildPitchOption(context, 'ملعب ٢ (سباعي)', 'مساحة قانونية واسعة · ٧ ضد ٧', '٢٢٠ ج.م'),
                  _buildPitchOption(context, 'ملعب ٣ (خماسي مغطى)', 'صالة مغطاة ترتان مكيفة', '١٨٠ ج.م'),
                ],
              ),
            ),
          ),
        ],
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
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('السعر يبدأ من', style: AppTextStyles.font11Regular),
                  Text('١٥٠ ج.م / ساعة', style: AppTextStyles.font16Bold.copyWith(color: AppColors.brandNavy)),
                ],
              ),
              const Spacer(),
              CustomButton(
                text: 'اختر الملعب والميعاد',
                type: CustomButtonType.primary,
                width: 190.w,
                height: 48.h,
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.pitchAndTime),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmenity(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 22.sp, color: AppColors.brandNavy),
        SizedBox(height: 4.h),
        Text(label, style: AppTextStyles.font11Regular),
      ],
    );
  }

  Widget _buildPitchOption(BuildContext context, String title, String subtitle, String price) {
    return CustomCardWidget(
      margin: EdgeInsets.only(bottom: 10.h),
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.pitchAndTime),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.font15Bold),
                SizedBox(height: 2.h),
                Text(subtitle, style: AppTextStyles.font12Regular),
                SizedBox(height: 4.h),
                Text(price, style: AppTextStyles.font14Bold.copyWith(color: AppColors.brandNavy)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 16.sp, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
