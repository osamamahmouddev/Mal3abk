import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/custom_chip_widget.dart';

class LeaveTeamScreen extends StatefulWidget {
  const LeaveTeamScreen({super.key});

  @override
  State<LeaveTeamScreen> createState() => _LeaveTeamScreenState();
}

class _LeaveTeamScreenState extends State<LeaveTeamScreen> {
  String _selectedReason = 'مواعيدهم مش مناسبة';
  final List<String> _reasons = ['مواعيدهم مش مناسبة', 'الملاعب بعيدة', 'المستوى مختلف', 'سبب تاني'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'مغادرة الفريق'),
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
              SizedBox(width: 12.w),
              Expanded(
                child: CustomButton(
                  text: 'مغادرة الفريق',
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
                    SizedBox(width: 12.w),
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
              SizedBox(height: 16.h),

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
                    SizedBox(height: 8.h),
                    Text('• نتايجك وسجلك القديم هيفضل محفوظ باسمك مع الفريق.', style: AppTextStyles.font12Regular),
                    SizedBox(height: 4.h),
                    Text('• عشان ترجع تاني هتحتاج دعوة أو كود جديد من الكابتن.', style: AppTextStyles.font12Regular),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              Text('السبب (اختياري — بيوصل للكابتن بس)', style: AppTextStyles.font14SemiBold),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: _reasons.map((r) {
                  return CustomChipWidget(
                    label: r,
                    isSelected: _selectedReason == r,
                    onTap: () => setState(() => _selectedReason = r),
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

