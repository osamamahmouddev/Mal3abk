import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../widgets/team_member_row_widget.dart';

class ManageMembersScreen extends StatelessWidget {
  const ManageMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'teams.manage_members_title'.tr(context: context),
        subtitle: 'فريق النجوم (٨ لاعبين)',
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          children: const [
            TeamMemberRowWidget(name: 'أحمد سامي', details: 'كابتن الفريق · ٠١٠١٢٣٤٥٦٧٨', isCaptain: true),
            TeamMemberRowWidget(name: 'محمد علي', details: 'مدافع · انضم منذ شهر', isCaptain: false),
            TeamMemberRowWidget(name: 'كريم محمود', details: 'حارس مرمى · انضم منذ شهرين', isCaptain: false),
            TeamMemberRowWidget(name: 'عمر خالد', details: 'مهاجم · انضم منذ ٣ أسابيع', isCaptain: false),
            TeamMemberRowWidget(name: 'يوسف حسن', details: 'وسط · انضم منذ أسبوع', isCaptain: false),
          ],
        ),
      ),
    );
  }
}
