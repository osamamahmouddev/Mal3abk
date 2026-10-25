import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/match_card_widget.dart';

class MatchDetailsScreen extends StatelessWidget {
  const MatchDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'matches.match_details_title'.tr(context: context),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomButton(
            text: 'matches.submit_result_title'.tr(context: context),
            type: CustomButtonType.primary,
            height: 52.h,
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.submitResult),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          children: [
            const MatchCardWidget(
              team1Name: 'النجوم',
              team1Initials: 'نج',
              team2Name: 'الصقور',
              team2Initials: 'صق',
              dateTime: 'السبت ١٩ يوليو · ٨:٠٠ م',
              pitchName: 'ملعب الأهلي الصغير — ملعب ٣',
              scoreTeam1: 4,
              scoreTeam2: 3,
              statusText: 'بانتظار التأكيد',
              statusType: AppBadgeType.warning,
            ),
            hSpace(14),
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AppColors.goldLight,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: AppColors.goldBorder, width: 1),
              ),
              child: Text(
                'أحمد سامي (كابتن النجوم) سجّل النتيجة ٤–٣. أكّدها أو اعترض خلال ٤٨ ساعة.',
                style: AppTextStyles.font13Regular.copyWith(color: AppColors.goldDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
