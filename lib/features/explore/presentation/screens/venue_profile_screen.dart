import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../widgets/venue_amenity_chip_widget.dart';
import '../widgets/venue_pitch_option_card_widget.dart';

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
            backgroundColor: AppColors.pitchGreen,
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
                  child: Icon(Icons.sports_soccer_rounded, size: 64.sp, color: AppColors.white.withValues(alpha: 0.8)),
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
                      Text('ملاعب النجوم', style: AppTextStyles.font20Bold),
                      Row(
                        children: [
                          Icon(Icons.star_rounded, color: AppColors.goldDark, size: 20.sp),
                          vSpace(4),
                          Text('٤٫٨', style: AppTextStyles.font14Bold.copyWith(color: AppColors.goldDark)),
                        ],
                      ),
                    ],
                  ),
                  hSpace(4),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 16.sp, color: AppColors.textSecondary),
                      vSpace(4),
                      Text('مدينة نصر، خلف النادي الأهلي · ١٫٢ كم', style: AppTextStyles.font13Regular),
                    ],
                  ),
                  hSpace(16),
                  CustomCardWidget(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        VenueAmenityChipWidget(icon: Icons.wb_incandescent_outlined, label: 'explore.lighting'.tr(context: context)),
                        VenueAmenityChipWidget(icon: Icons.shower_outlined, label: 'explore.changing_rooms'.tr(context: context)),
                        VenueAmenityChipWidget(icon: Icons.local_cafe_outlined, label: 'explore.cafeteria'.tr(context: context)),
                        VenueAmenityChipWidget(icon: Icons.local_parking_outlined, label: 'explore.parking'.tr(context: context)),
                      ],
                    ),
                  ),
                  hSpace(20),
                  Text('explore.pitches_in_venue'.tr(context: context), style: AppTextStyles.font16Bold),
                  hSpace(10),
                  VenuePitchOptionCardWidget(
                    title: 'ملعب ١ (خماسي)',
                    subtitle: 'نجيل تركي صناعي مميز · ٥ ضد ٥',
                    price: '١٥٠ ج.م',
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.pitchAndTime),
                  ),
                  VenuePitchOptionCardWidget(
                    title: 'ملعب ٢ (سباعي)',
                    subtitle: 'مساحة قانونية واسعة · ٧ ضد ٧',
                    price: '٢٢٠ ج.م',
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.pitchAndTime),
                  ),
                  VenuePitchOptionCardWidget(
                    title: 'ملعب ٣ (خماسي مغطى)',
                    subtitle: 'صالة مغطاة ترتان مكيفة',
                    price: '١٨٠ ج.م',
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.pitchAndTime),
                  ),
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
                text: 'explore.pitch_and_time'.tr(context: context),
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
}
