import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';

class SubmitResultScreen extends HookWidget {
  const SubmitResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final score1 = useState(4);
    final score2 = useState(3);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'نتيجة المباراة'),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomButton(
            text: 'إرسال النتيجة للتأكيد',
            type: CustomButtonType.primary,
            height: 52.h,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إرسال النتيجة لكابتن الفريق المنافس')),
              );
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              Text(
                'السبت ١٩ يوليو · ملعب الأهلي الصغير — ملعب ٣',
                style: AppTextStyles.font13Regular,
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.brandNavy,
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Team 1
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 26.r,
                          backgroundColor: AppColors.white,
                          child: Text('نج', style: AppTextStyles.font16Bold.copyWith(color: AppColors.brandNavy)),
                        ),
                        SizedBox(height: 6.h),
                        Text('النجوم', style: AppTextStyles.font15Bold.copyWith(color: AppColors.white)),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => score1.value = (score1.value - 1).clamp(0, 99),
                              icon: const Icon(Icons.remove_circle_outline, color: AppColors.white),
                            ),
                            Text('${score1.value}', style: AppTextStyles.font24Bold.copyWith(color: AppColors.white)),
                            IconButton(
                              onPressed: () => score1.value++,
                              icon: const Icon(Icons.add_circle_outline, color: AppColors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text('–', style: AppTextStyles.font24Bold.copyWith(color: AppColors.accentGold)),
                    // Team 2
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 26.r,
                          backgroundColor: AppColors.brandRed,
                          child: Text('صق', style: AppTextStyles.font16Bold.copyWith(color: AppColors.white)),
                        ),
                        SizedBox(height: 6.h),
                        Text('الصقور', style: AppTextStyles.font15Bold.copyWith(color: AppColors.white)),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => score2.value = (score2.value - 1).clamp(0, 99),
                              icon: const Icon(Icons.remove_circle_outline, color: AppColors.white),
                            ),
                            Text('${score2.value}', style: AppTextStyles.font24Bold.copyWith(color: AppColors.white)),
                            IconButton(
                              onPressed: () => score2.value++,
                              icon: const Icon(Icons.add_circle_outline, color: AppColors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'النتيجة هتتبعت لكابتن الصقور يأكدها. مش هتأثر على الترتيب ولا الإحصائيات غير بعد التأكيد.',
                  style: AppTextStyles.font12Regular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
