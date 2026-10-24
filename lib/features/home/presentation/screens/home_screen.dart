import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_bottom_nav_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      bottomNavigationBar: CustomBottomNavBarWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 1) Navigator.of(context).pushNamed(AppRoutes.exploreList);
          if (index == 2) Navigator.of(context).pushNamed(AppRoutes.myBookings);
          if (index == 3) Navigator.of(context).pushNamed(AppRoutes.myTeams);
          if (index == 4) Navigator.of(context).pushNamed(AppRoutes.myProfile);
        },
        items: const [
          CustomBottomNavBarItem(title: 'الرئيسية', icon: Icons.home_filled),
          CustomBottomNavBarItem(title: 'استكشف', icon: Icons.explore_outlined, activeIcon: Icons.explore_rounded),
          CustomBottomNavBarItem(title: 'حجوزاتي', icon: Icons.calendar_today_outlined, activeIcon: Icons.calendar_today_rounded),
          CustomBottomNavBarItem(title: 'فرقي', icon: Icons.groups_outlined, activeIcon: Icons.groups_rounded),
          CustomBottomNavBarItem(title: 'حسابي', icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Location & Notification Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'موقعك الحالي',
                          style: AppTextStyles.font11Regular,
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded, size: 16.sp, color: AppColors.brandRed),
                            SizedBox(width: 4.w),
                            Text(
                              'مدينة نصر، القاهرة',
                              style: AppTextStyles.font15Bold,
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded, size: 18.sp, color: AppColors.textSecondary),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.notifications),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      width: 44.w,
                      height: 44.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Stack(
                        children: [
                          Icon(Icons.notifications_none_rounded, size: 24.sp, color: AppColors.brandNavy),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 9.w,
                              height: 9.h,
                              decoration: const BoxDecoration(
                                color: AppColors.brandRed,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),

              // Hero Search Pitch Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.brandNavy,
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إمتى عايز تلعب؟',
                      style: AppTextStyles.font18Bold.copyWith(color: AppColors.white),
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today_rounded, size: 16.sp, color: AppColors.white),
                                SizedBox(width: 8.w),
                                Text('النهارده', style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.white)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.access_time_rounded, size: 16.sp, color: AppColors.white),
                                SizedBox(width: 8.w),
                                Text('٨:٠٠ م', style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.white)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    CustomButton(
                      text: 'دوّر على ملعب',
                      icon: Icon(Icons.search_rounded, size: 20.sp, color: AppColors.white),
                      type: CustomButtonType.primary,
                      height: 48.h,
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.exploreList),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Upcoming Booking Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('حجزك القادم', style: AppTextStyles.font16Bold),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed(AppRoutes.myBookings),
                    child: Text('حجوزاتي', style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.brandNavy)),
                  ),
                ],
              ),
              CustomCardWidget(
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
                padding: EdgeInsets.all(12.w),
                child: Row(
                  children: [
                    Container(
                      width: 52.w,
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: AppColors.pitchGreen,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Icon(Icons.sports_soccer_rounded, color: AppColors.white, size: 24.sp),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ملعب النجوم — ملعب ١', style: AppTextStyles.font14Bold),
                          SizedBox(height: 2.h),
                          Text('السبت ٢٦ يوليو · ٨:٠٠ م', style: AppTextStyles.font12Regular),
                        ],
                      ),
                    ),
                    const AppBadgeWidget(text: 'قيد المراجعة', type: AppBadgeType.warning),
                  ],
                ),
              ),
              SizedBox(height: 18.h),

              // Teams Activity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('نشاط فرقك', style: AppTextStyles.font16Bold),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed(AppRoutes.myTeams),
                    child: Text('فرقي', style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.brandNavy)),
                  ),
                ],
              ),
              CustomCardWidget(
                padding: EdgeInsets.all(12.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18.r,
                      backgroundColor: AppColors.brandNavy,
                      child: Text('نج', style: AppTextStyles.font12Bold.copyWith(color: AppColors.white)),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('تحدي الصقور اتقبل — الملعب لسه مش محجوز', style: AppTextStyles.font13SemiBold),
                          SizedBox(height: 2.h),
                          Text('السبت ٢ أغسطس · ٩:٠٠ م', style: AppTextStyles.font11Regular),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),

              // Nearby Pitches
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ملاعب قريبة منك', style: AppTextStyles.font16Bold),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed(AppRoutes.exploreMap),
                    child: Text('على الخريطة', style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.brandNavy)),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildNearbyPitchCard(
                      name: 'ملعب النجوم',
                      rating: '٤٫٨',
                      dist: '١٫٢ كم · من ١٥٠ ج.م',
                      slot: 'متاح ٨:٠٠ م',
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.venueProfile),
                    ),
                    SizedBox(width: 12.w),
                    _buildNearbyPitchCard(
                      name: 'أكاديمية الدلتا',
                      rating: '٤٫٦',
                      dist: '٢٫٥ كم · من ٢٠٠ ج.م',
                      slot: 'متاح ٩:٠٠ م',
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.venueProfile),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNearbyPitchCard({
    required String name,
    required String rating,
    required String dist,
    required String slot,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: 210.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.borderCard, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90.h,
              decoration: BoxDecoration(
                color: AppColors.pitchGreen,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Icon(Icons.sports_soccer_rounded, size: 36.sp, color: AppColors.white),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(name, style: AppTextStyles.font14Bold, maxLines: 1)),
                Row(
                  children: [
                    Icon(Icons.star_rounded, size: 14.sp, color: AppColors.goldDark),
                    SizedBox(width: 2.w),
                    Text(rating, style: AppTextStyles.font12Bold.copyWith(color: AppColors.goldDark)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(dist, style: AppTextStyles.font12Regular),
            SizedBox(height: 6.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(slot, style: AppTextStyles.font11Bold.copyWith(color: AppColors.successGreen)),
            ),
          ],
        ),
      ),
    );
  }
}
