import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class RankingsScreen extends StatelessWidget {
  const RankingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(
        title: 'ترتيب الفرق',
        subtitle: 'مدينة نصر والقاهرة',
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          children: [
            _buildRankCard(1, 'فريق الفراعنة', '٢٨ فوز · ٠ خسارة', '٨٤ نقطة', true),
            _buildRankCard(2, 'نسور الدلتا', '٢٤ فوز · ٢ خسارة', '٧٤ نقطة', false),
            _buildRankCard(3, 'فريق الأبطال', '٢٠ فوز · ٤ خسارة', '٦٤ نقطة', false),
            _buildRankCard(4, 'فريق النجوم (فريقك)', '١٤ فوز · ٥ خسارة', '٤٥ نقطة', false, isMyTeam: true),
            _buildRankCard(5, 'الصقور', '١٢ فوز · ٦ خسارة', '٤٠ نقطة', false),
          ],
        ),
      ),
    );
  }

  Widget _buildRankCard(int rank, String teamName, String record, String points, bool isFirst, {bool isMyTeam = false}) {
    return CustomCardWidget(
      backgroundColor: isMyTeam ? AppColors.goldLight : AppColors.white,
      borderColor: isMyTeam ? AppColors.goldBorder : AppColors.borderCard,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isFirst ? AppColors.accentGold : AppColors.lightSurface,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$rank',
              style: AppTextStyles.font14Bold.copyWith(
                color: isFirst ? AppColors.textPrimary : AppColors.brandNavy,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(teamName, style: AppTextStyles.font15Bold),
                SizedBox(height: 2.h),
                Text(record, style: AppTextStyles.font12Regular),
              ],
            ),
          ),
          Text(points, style: AppTextStyles.font15Bold.copyWith(color: AppColors.brandNavy)),
        ],
      ),
    );
  }
}

