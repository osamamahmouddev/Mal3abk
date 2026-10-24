import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  AppAssets.logoStacked,
                  width: 140.w,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'احجز ملعبك، كوّن فريقك، واتحدى أي حد في منطقتك.',
                style: AppTextStyles.font20Bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              _buildFeatureItem(
                number: '١',
                title: 'ملاعب قريبة منك',
                subtitle: 'أسعار ومواعيد متاحة قبل ما تتصل بحد',
              ),
              SizedBox(height: 18.h),
              _buildFeatureItem(
                number: '٢',
                title: 'حجز وعربون من التطبيق',
                subtitle: 'ارفع الإيصال وتابع حالة حجزك',
              ),
              SizedBox(height: 18.h),
              _buildFeatureItem(
                number: '٣',
                title: 'فريقك وترتيبه',
                subtitle: 'تحديات ونتايج متأكدة من الفريقين',
              ),
              const Spacer(),
              CustomButton(
                text: 'ابدأ برقم موبايلك',
                type: CustomButtonType.primary,
                height: 54.h,
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.login),
              ),
              SizedBox(height: 12.h),
              CustomButton(
                text: 'تصفّح الملاعب الأول',
                type: CustomButtonType.outline,
                height: 50.h,
                onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
              ),
              SizedBox(height: 16.h),
              Text(
                'بالمتابعة إنت موافق على الشروط وسياسة الخصوصية',
                style: AppTextStyles.font11Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required String number,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 44.w,
          height: 44.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            number,
            style: AppTextStyles.font16Bold.copyWith(
              color: AppColors.brandNavy,
            ),
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.font15Bold,
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: AppTextStyles.font13Regular,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

