import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/custom_chip_widget.dart';

class LeaveTeamScreen extends HookWidget {
  const LeaveTeamScreen({super.key});

  static const List<String> _reasons = ['مواعيدهم مش مناسبة', 'الملاعب بعيدة', 'المستوى مختلف', 'سبب تاني'];

  @override
  Widget build(BuildContext context) {
    final selectedReason = useState('مواعيدهم مش مناسبة');

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'teams.leave_team_title'.tr(context: context),
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
              Expanded(
                child: CustomButton(
                  text: 'خليني في الفريق',
                  type: CustomButtonType.outline,
                  height: 52.h,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              vSpace(12),
              Expanded(
                child: CustomButton(
                  text: 'teams.confirm_leave'.tr(context: context),
                  type: CustomButtonType.primary,
                  height: 52.h,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomCardWidget(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22.r,
                      backgroundColor: AppColors.brandNavy,
                      child: Text('أب', style: AppTextStyles.font14Bold.copyWith(color: AppColors.white)),
                    ),
                    vSpace(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('فريق الأبطال', style: AppTextStyles.font16Bold),
                          Text('مصر الجديدة · الكابتن: كريم عادل · إنت عضو', style: AppTextStyles.font12Regular),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              hSpace(16),
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: AppColors.goldLight,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.goldBorder, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('قبل ما تمشي', style: AppTextStyles.font14Bold.copyWith(color: AppColors.goldDark)),
                    hSpace(8),
                    Text('• نتايجك وسجلك القديم هيفضل محفوظ باسمك مع الفريق.', style: AppTextStyles.font12Regular),
                    hSpace(4),
                    Text('• عشان ترجع تاني هتحتاج دعوة أو كود جديد من الكابتن.', style: AppTextStyles.font12Regular),
                  ],
                ),
              ),
              hSpace(20),
              Text('السبب (اختياري — بيوصل للكابتن بس)', style: AppTextStyles.font14SemiBold),
              hSpace(10),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: _reasons.map((r) {
                  return CustomChipWidget(
                    label: r,
                    isSelected: selectedReason.value == r,
                    onTap: () => selectedReason.value = r,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
