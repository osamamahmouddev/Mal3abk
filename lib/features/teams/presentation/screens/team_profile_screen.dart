import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class TeamProfileScreen extends StatelessWidget {
  const TeamProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            backgroundColor: AppColors.brandNavy,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_rounded, color: AppColors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.brandNavy,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 36.r,
                        backgroundColor: AppColors.white,
                        child: Text('نج', style: AppTextStyles.font22Bold.copyWith(color: AppColors.brandNavy)),
                      ),
                      SizedBox(height: 8.h),
                      Text('فريق النجوم', style: AppTextStyles.font20Bold.copyWith(color: AppColors.white)),
                      Text('مدينة نصر · الكابتن: أحمد سامي', style: AppTextStyles.font12Regular.copyWith(color: AppColors.white.withValues(alpha: 0.8))),
                    ],
                  ),
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
                  // Team Stats
                  CustomCardWidget(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatBox('٢٢', 'مباراة ملعوبة'),
                        _buildStatBox('١٤', 'فوز'),
                        _buildStatBox('#٤', 'ترتيب الحي'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'دعوة لاعبين',
                          type: CustomButtonType.secondary,
                          height: 46.h,
                          onTap: () => Navigator.of(context).pushNamed(AppRoutes.invitePlayers),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomButton(
                          text: 'تحدي الفريق',
                          type: CustomButtonType.primary,
                          height: 46.h,
                          onTap: () => Navigator.of(context).pushNamed(AppRoutes.challengeTeam),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('أعضاء الفريق (٨ لاعبين)', style: AppTextStyles.font16Bold),
                      TextButton(
                        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.manageMembers),
                        child: Text('إدارة', style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.brandNavy)),
                      ),
                    ],
                  ),
                  _buildMemberTile('أحمد سامي', 'كابتن · وسط', true),
                  _buildMemberTile('محمد علي', 'مدافع', false),
                  _buildMemberTile('كريم محمود', 'حارس مرمى', false),
                  _buildMemberTile('عمر خالد', 'مهاجم', false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String val, String label) {
    return Column(
      children: [
        Text(val, style: AppTextStyles.font20Bold.copyWith(color: AppColors.brandNavy)),
        SizedBox(height: 2.h),
        Text(label, style: AppTextStyles.font11Regular),
      ],
    );
  }

  Widget _buildMemberTile(String name, String role, bool isCaptain) {
    return CustomCardWidget(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.lightSurface,
            child: Text(name.substring(0, 1), style: AppTextStyles.font13SemiBold),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.font14SemiBold),
                Text(role, style: AppTextStyles.font11Regular),
              ],
            ),
          ),
          if (isCaptain) const AppBadgeWidget(text: 'كابتن', type: AppBadgeType.warning),
        ],
      ),
    );
  }
}

