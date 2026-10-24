import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class ManageMembersScreen extends StatelessWidget {
  const ManageMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(
        title: 'إدارة أعضاء الفريق',
        subtitle: 'فريق النجوم (٨ لاعبين)',
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          children: [
            _buildMemberRow('أحمد سامي', 'كابتن الفريق · ٠١٠١٢٣٤٥٦٧٨', true),
            _buildMemberRow('محمد علي', 'مدافع · انضم منذ شهر', false),
            _buildMemberRow('كريم محمود', 'حارس مرمى · انضم منذ شهرين', false),
            _buildMemberRow('عمر خالد', 'مهاجم · انضم منذ ٣ أسابيع', false),
            _buildMemberRow('يوسف حسن', 'وسط · انضم منذ أسبوع', false),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberRow(String name, String details, bool isCaptain) {
    return CustomCardWidget(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.brandNavy,
            child: Text(
              name.substring(0, 1),
              style: AppTextStyles.font14Bold.copyWith(color: AppColors.white),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: AppTextStyles.font15Bold),
                    if (isCaptain) ...[
                      SizedBox(width: 8.w),
                      const AppBadgeWidget(text: 'كابتن', type: AppBadgeType.warning),
                    ],
                  ],
                ),
                SizedBox(height: 2.h),
                Text(details, style: AppTextStyles.font12Regular),
              ],
            ),
          ),
          if (!isCaptain)
            IconButton(
              icon: const Icon(Icons.more_vert_rounded, color: AppColors.textSecondary),
              onPressed: () {},
            ),
        ],
      ),
    );
  }
}

